#!/usr/bin/env python3
# playtest_agent.py - SoMe-Universe-IF 的测试玩家 / 评测 harness
#
# 两种模式（模仿参考的 sm3-inform/Tests/playtest.sh 架构：跑命令脚本 -> 抓实机转录 -> LLM 审稿）：
#   1) review（默认）：把 Tests/Cases/*.txt 里手工编写、能真正走通游戏的命令脚本
#      逐条跑过 glulxe，得到真实转录，再交给模型（agnes-3.0-flash）做「有据可查」的评测。
#      —— 这能真正覆盖西路修复（west-shielded-passage 武装通行 / west-unshielded-death 门槛死亡无 Lucifer 台词）。
#   2) play：自治试玩模式，让 LLM 自己决定下一条命令。免费档模型普遍不会玩 Inform 7
#      游戏（读不懂提示、反复乱输），产出多为幻觉；需更强 token 才有意义（遗留功能）。
#
# 模型策略：主用 agnes-3.0-flash（免费），被速率限制时降级到 models.json 里的 openrouter/free。
#
# 依赖（Windows + WSL 环境）:
#   - wsl.exe (Ubuntu) 内含 ~/build/glulxe/glulxe
#   - curl（可连通 api.agnes-ai.cn / openrouter.ai）
#   - 已编译的 story.ulx（见 playtest_agent.sh 的编译兜底）
#
# 用法:
#   AGNES_TOKEN=sk-xxx python3 Tests/playtest_agent.py review [out-file]
#   AGNES_TOKEN=sk-xxx python3 Tests/playtest_agent.py play   [out-file] [max-turns]

import os
import sys
import json
import re
import time
import subprocess

HERE = os.path.dirname(os.path.abspath(__file__))
CASES_DIR = os.path.join(HERE, "Cases")
BUILD = "D:/projects/inform/build"
ULX = os.path.join(BUILD, "story.ulx")
CMDS_FILE = os.path.join(BUILD, "_agent_cmds.txt")
BODY_FILE = os.path.join(BUILD, "_agent_body.json")

TOKEN = os.environ.get("AGNES_TOKEN", "")
if not TOKEN:
    tokfile = os.path.join(HERE, ".playtest_token")
    if os.path.exists(tokfile):
        TOKEN = open(tokfile, encoding="utf-8").read().strip()

# ---- 模型 / provider 配置 ----
AGNES_URL = "https://api.agnes-ai.cn/v1/chat/completions"
AGNES_MODEL = "agnes-3.0-flash"
OPENROUTER_URL = "https://openrouter.ai/api/v1/chat/completions"
OPENROUTER_MODEL = "openrouter/free"
OPENROUTER_KEY = ""
try:
    _mj = os.path.join(os.path.expanduser("~"), ".workbuddy", "models.json")
    if os.path.exists(_mj):
        for _e in json.load(open(_mj, encoding="utf-8")):
            if _e.get("id") == "openrouter/free":
                OPENROUTER_KEY = _e.get("apiKey", "")
except Exception:
    pass

# 主模型 agnes-3.0-flash（免费）；限流时降级 openrouter/free
PROVIDERS = []
if TOKEN:
    PROVIDERS.append({"name": "agnes-3.0-flash", "url": AGNES_URL,
                      "key": TOKEN, "model": AGNES_MODEL})
if OPENROUTER_KEY:
    PROVIDERS.append({"name": "openrouter/free", "url": OPENROUTER_URL,
                      "key": OPENROUTER_KEY, "model": OPENROUTER_MODEL})


PARSE_ERROR_MARKERS = [
    "I didn't understand that sentence",
    "That noun did not make sense",
    "That's not a verb I recognise",
    "You can't see any such thing",
    "You seem to want to talk to someone",
    "I only understood",
    "You can't go that way",
]


def clean_transcript(out):
    """截掉游戏结束后的废行噪声：在 RESTART/计分提示处断开，并剥掉尾部空行与
    'I beg your pardon?'（这些是结束后空行刷输入产生的，会让评测误判为静默）。"""
    m = re.search(r"Would you like to RESTART|In that game you scored", out)
    if m:
        out = out[:m.start()]
    lines = out.split("\n")
    while lines and lines[-1].strip() in ("", ">I beg your pardon?", "I beg your pardon?"):
        lines.pop()
    return "\n".join(lines)


def run_game(commands):
    """把命令写入文件，经 WSL 的 glulxe 跑出转录（尾部填充少量空行刷掉任何提示符），
    并清理结束后的噪声，只保留真实试玩部分。"""
    with open(CMDS_FILE, "w", encoding="utf-8", newline="\n") as f:
        f.write("\n".join(commands) + "\n")
    script = (
        "cd /mnt/d/projects/inform/build && "
        "cp '/mnt/d/projects/inform/build/_agent_cmds.txt' _case.txt && "
        "yes '' | head -n 80 >> _case.txt && "
        "timeout 120 ~/build/glulxe/glulxe story.ulx < _case.txt"
    )
    res = subprocess.run(
        ["wsl.exe", "-d", "Ubuntu", "--", "sh", "-c", script],
        capture_output=True, text=True, encoding="utf-8", errors="replace")
    return clean_transcript(res.stdout)


def _try_provider(prov, prompt, max_tokens, temperature, retries):
    """对单个 provider 做带退避重试的调用；返回 (content_or_None, last_err)。"""
    body = {
        "model": prov["model"],
        "max_tokens": max_tokens,
        "temperature": temperature,
        "messages": [{"role": "user", "content": prompt}],
    }
    with open(BODY_FILE, "wb") as f:
        f.write(json.dumps(body, ensure_ascii=False).encode("utf-8"))
    delays = [3, 6, 12, 20, 30, 45]
    last_err = ""
    for attempt in range(retries):
        r = subprocess.run(
            ["curl", "-sS", "--max-time", "120", prov["url"],
             "-H", "Content-Type: application/json",
             "-H", f"Authorization: Bearer {prov['key']}",
             "-d", f"@{BODY_FILE}"],
            capture_output=True, text=True, encoding="utf-8", errors="replace")
        try:
            data = json.loads(r.stdout)
        except Exception as e:
            data = None
            last_err = f"json解析失败: {e} | {r.stdout[:160]}"
        if isinstance(data, dict) and data.get("choices"):
            return data["choices"][0]["message"]["content"], ""
        last_err = (data or {}).get("error", {}).get("message") or r.stdout[:160]
        if attempt < retries - 1:
            d = delays[min(attempt, len(delays) - 1)]
            sys.stderr.write(f"[api:{prov['name']}] 第{attempt + 1}次失败: {last_err[:55]} -> {d}s 重试\n")
            time.sleep(d)
    return None, last_err


def call_api(prompt, max_tokens=256, temperature=0.7, retries=6):
    """跨 provider 调用：agnes-3.0-flash 优先，限流则降级 openrouter/free。"""
    if not PROVIDERS:
        return "[API ERROR: 无可用 provider（未配置 token）]"
    last_err = ""
    for prov in PROVIDERS:
        content, err = _try_provider(prov, prompt, max_tokens, temperature, retries)
        if content is not None:
            return content
        last_err = err
        sys.stderr.write(f"[api] provider {prov['name']} 耗尽重试，切换到下一个\n")
    return f"[API ERROR: 所有 provider 失败] {last_err}"


# ----------------------------------------------------------------------------
# review 模式：跑 Cases + 模型评测
# ----------------------------------------------------------------------------

def review_prompt(transcript, case_name, commands=None):
    if len(transcript) > 16000:
        shown = transcript[:12000] + "\n\n...[中部省略]...\n\n" + transcript[-4000:]
    else:
        shown = transcript
    extra = ""
    if "west" in case_name.lower():
        extra = (
            "\n补充：本用例专门测试「西路（旧金属/荒原）」剧情。请额外确认：\n"
            "  (a) 未武装走向 Black Cathedral 时，是否【在到达前】就被辐射『结清』死亡，"
            "且【没有】出现 Lucifer 的招募台词（'Alive, and armored, and arrived' / 'CHOOSE PANTHEON'）？\n"
            "  (b) 若用例是武装（佩戴 Aegis gauntlets）通行，是否顺利走到 Cathedral 并成功 choose Pantheon？\n"
        )
    cmds_block = ""
    if commands:
        cmds_block = (
            "\n【本用例玩家实际输入的命令序列（按时间顺序，这是真实发生的输入；转录里命令通常不被回显）】：\n  "
            + "\n  ".join("> " + c for c in commands) + "\n"
        )
    prompt = (
        "你是一名严谨的文字冒险游戏试玩评测员。下面是一段《SoMe-Universe: The Ten Banners》的"
        "【真实实机转录】，这是真实发生过的，绝不允许编造。\n\n"
        "【转录格式重要说明】本游戏用 Cheap Glk 解释器（glulxe）运行，转录里：\n"
        "  - 行首的 '>' 是游戏的【命令提示符】，其后的文字是【游戏输出】，不是玩家输入；\n"
        "  - 玩家键入的命令【通常不被回显】在转录中。因此绝不能把 '>' 后的叙述文字当成玩家输入。\n"
        "  - 要判断玩家做了什么，请以下面『命令序列』为准，再对照游戏输出看响应是否合理。\n\n"
        f"【本用例文件名】{case_name}.txt（开发者手工编写、覆盖特定剧情的命令脚本）。\n"
        + cmds_block +
        "\n【铁律】只引用转录里真实出现的游戏输出；对照上面的命令序列判断响应；"
        "禁止虚构任何玩家输入或未发生的情节；未观察到的就写『未观察到』，不要脑补。\n\n"
        "请按以下结构评审：\n"
        "1. 事实复述：按上面的命令序列，逐条列出玩家输入了什么、游戏分别给出了什么关键回应"
        "（引用转录原文词句）。\n"
        "2. 困惑/卡点：哪些地方描写含糊、输出静默、出现死路或出口矛盾？（引用原文）\n"
        "3. 缺陷/Bug：本该锁的门没锁、缺失的房间描述、命令无响应（例如 HELP、SEARCH、EXAMINE 等是否被识别）、"
        "剧情/逻辑漏洞？（引用原文）\n"
        "4. 可玩性评分 1-10，并附一句话理由。\n"
        "5. 给开发者的一条具体、可落地的改进建议。\n"
        "用中文，结构清晰、基于证据。\n" + extra + "\n转录：\n" + shown
    )
    return prompt


def mode_review(out_file):
    if not os.path.exists(CASES_DIR):
        sys.stderr.write(f"找不到 Cases 目录: {CASES_DIR}\n")
        sys.exit(1)
    cases = sorted(f for f in os.listdir(CASES_DIR) if f.endswith(".txt"))
    if not cases:
        sys.stderr.write("Cases 目录为空\n")
        sys.exit(1)
    sys.stderr.write(f"[review] 共 {len(cases)} 个用例：{', '.join(cases)}\n")

    consolidated = []
    for c in cases:
        name = c[:-4]
        with open(os.path.join(CASES_DIR, c), encoding="utf-8") as f:
            commands = [ln.strip() for ln in f if ln.strip()]
        sys.stderr.write(f"[review] 跑 {name}（{len(commands)} 条命令）...\n")
        transcript = run_game(commands)
        sys.stderr.write(f"[review]   转录 {len(transcript)} 字符，调用评测模型...\n")
        fb = call_api(review_prompt(transcript, name, commands), max_tokens=2600, temperature=0.3)
        per = os.path.join(HERE, f"playtest_review_{name}.txt")
        with open(per, "w", encoding="utf-8") as f:
            f.write(f"===== 用例 {name} 评测 =====\n\n{fb}\n")
        consolidated.append((name, fb))
        time.sleep(3)  # 用例间节流

    header = (
        "================ SoMe-Universe-IF 测试玩家 agent 评测 (review 模式) ================\n"
        f"评测模型: {AGNES_MODEL}（+限流降级 openrouter/free）   用例数: {len(cases)}\n"
        "模式说明：把 Tests/Cases/*.txt 命令脚本跑过 glulxe 实机，交模型做有据可查的评测。\n"
        "================================================================================\n\n"
    )
    body = ""
    for name, fb in consolidated:
        body += f"\n################ 用例：{name} ################\n\n{fb}\n\n"
    with open(out_file, "w", encoding="utf-8") as f:
        f.write(header + body)
    sys.stderr.write(f"[review] 汇总评测已写入 {out_file}\n")
    print(header + body)


# ----------------------------------------------------------------------------
# play 模式：自治试玩（免费档模型普遍玩不动，遗留功能）
# ----------------------------------------------------------------------------

I7_PRIMER = (
    "这是一款 Inform 7 英文文字冒险。基本命令语法（务必遵守）：\n"
    "  - 移动：单独输入方向 N / S / E / W（或 NORTH/SOUTH...）。开局必须先从 Singularity 走到一个 gate：输入 S 去 Hall of Medicine，或 N 去 Disease Citadel。\n"
    "  - 查看：LOOK（重看房间）；EXAMINE <物体> 或 LOOK AT <物体>（细看）。\n"
    "  - 交谈：ASK <人名> ABOUT <主题>（例如 ASK THE PRECEPTOR ABOUT JOINING）。\n"
    "  - 宣誓：在 gate 内对某势力满意后，输入 CHOOSE <势力名>（例如 CHOOSE CRADLE、CHOOSE VIBRIO、CHOOSE PANTHOON 等）。\n"
    "  - 瞬移：GO TO <地点> 只有在【已宣誓】后才可用；未宣誓会被拒绝（提示你去 gate CHOOSE a patron）。\n"
    "  - 进度：BANNERS 查看战役；HELP 重看新手引导。\n"
    "核心循环：去 gate（S 或 N）-> 与 recruiter 交谈 -> CHOOSE 一个势力 -> 之后才能 GO TO 其他地方。\n"
    "未宣誓前反复 GO TO 是无效的，请先 S 或 N 走到 gate 并 CHOOSE。\n"
)


def detect_end(t):
    if re.search(r"Would you like to RESTART", t):
        return True
    if re.search(r"\*\*\* .+? \*\*\*", t):
        return True
    if re.search(r"In that game you scored", t):
        return True
    return False


def last_command_failed(t):
    tail = t[-700:]
    return any(m.lower() in tail.lower() for m in PARSE_ERROR_MARKERS)


def fallback_direction(commands):
    dirs = ["s", "n", "w", "go to landing", "look"]
    counts = {d: sum(1 for c in commands if c.lower() == d) for d in dirs}
    return min(dirs, key=lambda d: counts[d])


def decide_next(transcript, last_cmd, failed):
    tail = transcript[-8000:]
    prompt = (
        "你正在试玩一款英文文字冒险游戏《SoMe-Universe: The Ten Banners》。以 '>' 开头的行是玩家输入，"
        "其余是游戏输出。\n\n" + I7_PRIMER +
        f"\n上一条命令：{last_cmd or '(无)'}；该命令是否解析失败：{failed}\n"
        "请选择【下一条】真实有效的游戏命令（只回文本本身，不要引号/解释/'>'前缀；绝不回复 quit/空/闲聊/sorry/help 这类非命令）：\n"
        "继续推进：先 S 或 N 到 gate，与 recruiter 交谈，再 CHOOSE 一个势力；之后才能 GO TO。\n"
        "若刚 look 过就改为移动或交互；南、北、西三条路都值得走到（尤其 'w' 西路）。\n\n"
        "转录：\n" + tail
    )
    txt = call_api(prompt, max_tokens=64, temperature=0.3).strip()
    if txt.startswith("[API ERROR"):
        return ""
    return txt


def mode_play(out_file, max_turns):
    if not os.path.exists(ULX):
        sys.stderr.write(f"找不到 {ULX}，请先编译（见 playtest_agent.sh）\n")
        sys.exit(1)
    sys.stderr.write(f"[play] 自治试玩，最多 {max_turns} 回合\n")
    commands = ["help"]
    transcript = run_game(commands)
    for i in range(max_turns):
        if detect_end(transcript):
            sys.stderr.write(f"[play] 第 {i} 回合检测到游戏结束，停止\n")
            break
        last_cmd = commands[-1] if len(commands) > 1 else ""
        failed = last_command_failed(transcript)
        if failed and len(commands) >= 2 and commands[-1] == commands[-2]:
            nxt = "s"
            sys.stderr.write(f"[play] 第 {i} 回合：上次命令连续失败，改试 s (去 Hall of Medicine)\n")
        else:
            nxt = decide_next(transcript, last_cmd, failed)
        nxt = nxt.strip().strip('"').strip("'").split("\n")[0].strip().lower()
        if not nxt or nxt == "quit":
            nxt = fallback_direction(commands)
        sys.stderr.write(f"[play] turn {i}: > {nxt}\n")
        commands.append(nxt)
        transcript = run_game(commands)
        time.sleep(2)

    transcript_out = os.path.join(HERE, "playtest_transcript.txt")
    with open(transcript_out, "w", encoding="utf-8") as f:
        f.write(transcript)
    with open(os.path.join(HERE, "playtest_commands.txt"), "w", encoding="utf-8") as f:
        f.write("\n".join(commands) + "\n")

    fb = call_api(review_prompt(transcript, "autonomous-play"), max_tokens=2600, temperature=0.3)
    header = (
        "================ SoMe-Universe-IF 自治试玩反馈 (play 模式) ================\n"
        f"模型: {AGNES_MODEL}（+限流降级）   实际命令数: {len(commands)}\n"
        "玩家动线：\n  " + "\n  ".join(commands) + "\n"
        "========================================================================\n\n"
    )
    with open(out_file, "w", encoding="utf-8") as f:
        f.write(header + fb + "\n")
    sys.stderr.write(f"[play] 反馈已写入 {out_file}\n")
    print(header + fb)


def main():
    if not TOKEN and not OPENROUTER_KEY:
        sys.stderr.write("AGNES_TOKEN 未设置，且 models.json 也无 openrouter/free key\n")
        sys.exit(1)
    mode = sys.argv[1] if len(sys.argv) > 1 else "review"
    if mode == "play":
        out = sys.argv[2] if len(sys.argv) > 2 else os.path.join(HERE, "playtest_feedback.txt")
        max_turns = int(sys.argv[3]) if len(sys.argv) > 3 else int(os.environ.get("AGENT_TURNS", "26"))
        mode_play(out, max_turns)
    elif mode == "review":
        out = sys.argv[2] if len(sys.argv) > 2 else os.path.join(HERE, "playtest_feedback.txt")
        mode_review(out)
    else:
        sys.stderr.write(f"未知模式: {mode}（用 review 或 play）\n")
        sys.exit(1)


if __name__ == "__main__":
    main()
