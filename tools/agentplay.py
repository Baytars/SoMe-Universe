"""Autonomous LLM player for SoMe-Universe (The Ten Banners).

Drives the compiled story through headless glulxe as an interactive process and
lets a chat model choose each command, so we can watch a real "new player"
explore and see where the game's guidance fails.

Primary model is OpenRouter's anonymous-free `stealth/space-bunny-alpha`; on any
failure we fall through the remaining models in order (see MODELS below).

Switch provider with AGENTPLAY_PROVIDER=agnes to use the independent Agnes API
(api.agnes-ai.cn) — NOT subject to the OpenRouter space-bunny rate limit.

Usage:
    set OPENROUTER_API_KEY=...            # or pass --key-file
    python tools/agentplay.py --smoke     # fixed script, no API calls
    python tools/agentplay.py --turns 40  # real autonomous run
    AGENTPLAY_PROVIDER=agnes AGNES_TOKEN=sk-... python tools/agentplay.py --turns 40 --key-file Tests/.playtest_token

The API key is never written to disk by this script (repo-safe).
"""

import argparse, json, os, io, queue, re, subprocess, sys, threading, time, urllib.request

BUILD = "D:/projects/inform/build"
OUT = os.path.join(BUILD, "agentplay")

API_URL = os.getenv("OPENROUTER_URL", "https://openrouter.ai/api/v1/chat/completions")

# Agnes provider (independent of OpenRouter; NOT subject to the space-bunny 429).
# Token via AGNES_TOKEN env or --key-file (Tests/.playtest_token).
AGNES_URL = os.getenv("AGNES_URL", "https://api.agnes-ai.cn/v1/chat/completions")
AGNES_MODEL = os.getenv("AGNES_MODEL", "agnes-3.0-flash")

# Provider selection: "openrouter" (default) or "agnes". Set AGENTPLAY_PROVIDER=agnes.
PROVIDER = os.getenv("AGENTPLAY_PROVIDER", "openrouter").lower()

# Fallback order. First entry is primary; later entries are tried in this order
# when a call fails (HTTP error, timeout, empty content). Override with the
# AGENTPLAY_MODELS env var (comma separated).
MODELS = [
    "stealth/space-bunny-alpha",
    "deepseek/deepseek-r1:free",
    "google/gemini-2.0-flash-thinking-exp:free",
    "meta-llama/llama-3.3-70b-instruct:free",
    "qwen/qwen-2.5-72b-instruct:free",
]
AGNES_MODELS = [AGNES_MODEL]

SYSTEM = """You are playing a text adventure called SOME-UNIVERSE: THE TEN BANNERS, as a brand-new player who knows nothing about it beyond what appears on screen.

You must reply in EXACTLY this format and nothing else:

<cmd>YOUR COMMAND HERE</cmd>

For example: <cmd>look</cmd> or <cmd>take pamphlet</cmd>

Rules:
- One command inside one <cmd> tag. Never more than one command per reply.
- Use only verbs the game itself has shown or implied. Typical ones you may need: look, examine <thing>, take <thing>, read <thing>, ask <person> about <topic>, go to <place>, directions like north/south, inventory, seals, banners.
- Follow the game's own instructions rather than guessing wildly.
- If a command is refused, read the refusal carefully and send a corrected version.
- Never repeat the exact same command twice in a row if it failed.
- If asked a yes/no question, answer yes or no.
- Use quit only when you choose to stop exploring."""

TAG_RE = re.compile(r"<cmd>(.*?)</cmd>", re.IGNORECASE | re.DOTALL)


def sanitize(raw):
    """Turn a model reply into a single clean command line."""
    if raw is None:
        return None
    # Preferred: the <cmd>...</cmd> tag. The model's own reasoning arrives in a
    # separate field and must never be mixed into the command.
    m = TAG_RE.search(raw)
    if m:
        cmd = " ".join(m.group(1).split()).strip("`\"' .")
        return cmd[:160] or None
    # Fallback: strip fences and take the last short line that looks like a command.
    text = raw.replace("```", "").strip()
    lines = [l.strip() for l in text.splitlines() if l.strip()]
    if not lines:
        return None
    cmd = lines[-1].strip("`\"' .")
    # reject runaway reasoning: a paragraph is not a command
    if len(cmd.split()) > 8:
        return None
    return cmd[:160] or None


class Game:
    """Interactive wrapper around headless glulxe running under WSL."""

    def __init__(self):
        self.q = queue.Queue()
        self.buf = []
        self.proc = None

    def start(self):
        cmd = ("wsl.exe -d Ubuntu -- sh -c "
               "\"cd /mnt/d/projects/inform/build && ~/build/glulxe/glulxe story.ulx\"")
        self.proc = subprocess.Popen(
            cmd, stdin=subprocess.PIPE, stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT, bufsize=0)
        self.reader = threading.Thread(target=self._pump, daemon=True)
        self.reader.start()

    def _pump(self):
        while True:
            try:
                chunk = self.proc.stdout.read(1)
            except Exception:
                break
            if not chunk:
                break
            self.q.put(chunk)

    def read(self, quiet=0.6, max_wait=12.0):
        """Collect output until it has been quiet for `quiet` seconds."""
        start = time.time()
        last = time.time()
        out = []
        while True:
            try:
                c = self.q.get(timeout=0.05)
                out.append(c)
                last = time.time()
            except queue.Empty:
                if out and (time.time() - last) >= quiet:
                    break
                if (time.time() - start) >= max_wait:
                    break
        return b"".join(out).decode("utf-8", "replace")

    def send(self, cmd):
        try:
            self.proc.stdin.write((cmd + "\n").encode("utf-8"))
            self.proc.stdin.flush()
        except Exception:
            return False
        return True

    def close(self):
        try:
            if self.proc and self.proc.poll() is None:
                self.proc.terminate()
        except Exception:
            pass


def call_model(model, messages, key, url=API_URL, timeout=120, max_tokens=700):
    payload = {
        "model": model,
        "messages": messages,
        "max_tokens": max_tokens,
        "temperature": 0.3,
    }
    body = json.dumps(payload).encode("utf-8")
    req = urllib.request.Request(
        url, data=body,
        headers={
            "Authorization": "Bearer " + key,
            "Content-Type": "application/json",
            "HTTP-Referer": "http://localhost/agentplay",
            "X-Title": "SoMe-Universe agentplay",
        })
    with urllib.request.urlopen(req, timeout=timeout) as r:
        data = json.loads(r.read().decode("utf-8"))
    msg = data["choices"][0]["message"]
    content = msg.get("content") or msg.get("reasoning") or ""
    if not content.strip():
        return False, "empty content"
    return True, content


def call_with_fallback(messages, key, models, url=API_URL):
    errs = []
    for m in models:
        try:
            ok, res = call_model(m, messages, key, url=url)
            if ok:
                return m, res, errs
            errs.append("%s: %s" % (m, res))
        except Exception as e:
            errs.append("%s: %s: %s" % (m, type(e).__name__, e))
    return None, None, errs


def build_messages(history, tail=1400, system=None):
    msgs = [{"role": "system", "content": system or SYSTEM}]
    running = 0
    recent = history[-12:]
    for turn in recent:
        label = "> " + turn["cmd"] if turn["cmd"] else "(game opened)"
        piece = label + "\n" + turn["out"][-tail:]
        if running + len(piece) > 9000 and len(msgs) > 1:
            break
        running += len(piece)
        msgs.append({"role": "user", "content": piece})
    msgs.append({"role": "user",
                 "content": "Reply now with <cmd>your next command</cmd>."})
    return msgs


def run(args):
    if PROVIDER == "agnes":
        key = os.getenv("AGNES_TOKEN") or ""
        if args.key_file and os.path.exists(args.key_file):
            key = io.open(args.key_file, encoding="utf-8").read().strip()
        models = [m.strip() for m in os.getenv("AGENTPLAY_MODELS", "").split(",") if m.strip()] or AGNES_MODELS
        api_url = AGNES_URL
        provider_label = "agnes (%s)" % AGNES_MODEL
    else:
        key = os.getenv("OPENROUTER_API_KEY") or ""
        if args.key_file and os.path.exists(args.key_file):
            key = io.open(args.key_file, encoding="utf-8").read().strip()
        models = [m.strip() for m in os.getenv("AGENTPLAY_MODELS", "").split(",") if m.strip()] or MODELS
        api_url = API_URL
        provider_label = "openrouter"
    print("[provider] %s  models=%s" % (provider_label, models))

    goal = ""
    if args.goal:
        goal = "\n\nYour current objective: " + args.goal

    game = Game()
    game.start()
    opening = game.read()
    history = [{"cmd": None, "out": opening}]
    log_path = os.path.join(OUT, "%s.txt" % args.name)
    io.open(log_path, "w", encoding="utf-8", newline="\n").write(
        "=== OPENING ===\n" + opening + "\n")

    script = args.script or []

    # Optional prefix: run these commands before the model takes over, so we can
    # spend the turn budget on the part of the game we are actually testing.
    if args.prefix:
        for pcmd in [c.strip() for c in args.prefix.split(";") if c.strip()]:
            game.send(pcmd)
            out = game.read()
            history.append({"cmd": pcmd, "out": out})
            with io.open(log_path, "a", encoding="utf-8", newline="\n") as f:
                f.write("\n=== PREFIX ===\n> %s\n%s\n" % (pcmd, out))
            print("[prefix] > %s" % pcmd)

    ended = False
    for turn in range(args.turns):
        if args.smoke:
            if turn >= len(script):
                break
            cmd = script[turn]
            model = "smoke"
            errs = []
        else:
            if not key:
                print("!! no API key; set OPENROUTER_API_KEY or --key-file")
                break
            model, reply, errs = None, None, []
            cmd = None
            # Sometimes the model leaks reasoning into content instead of using the
            # <cmd> tag. Nudge twice before giving up on the turn.
            for attempt in range(3):
                mm, rep, errs = call_with_fallback(
                    build_messages(history, system=SYSTEM + goal) if goal else build_messages(history),
                    key, models, url=api_url)
                if mm is None:
                    break
                model = mm
                cmd = sanitize(rep)
                if cmd:
                    break
                print(".. attempt %d: no <cmd> in reply, nudging" % (attempt + 1))
                history.append({"cmd": None, "out":
                    "GAME MASTER: your reply was not wrapped in <cmd>...</cmd>. "
                    "Send ONLY the tag and nothing else, e.g. <cmd>look</cmd>."})
            if not cmd:
                # The model sometimes loses the tag entirely and dumps its
                # reasoning. Ending the run there throws away everything we have
                # learned about the trial so far, so refresh the screen instead
                # and let it try again on the next turn.
                cmd = "look"
                print("!! no <cmd> after nudges; falling back to '%s'" % cmd)

        game.send(cmd)
        out = game.read()
        history.append({"cmd": cmd, "out": out})
        with io.open(log_path, "a", encoding="utf-8", newline="\n") as f:
            f.write("\n=== TURN %d [%s] ===\n> %s\n%s\n" % (turn + 1, model, cmd, out))
        print("[%02d][%s] > %s" % (turn + 1, model, cmd))
        low = out.lower()
        if "would you like to restart" in low or "are you sure you want to quit" in low:
            if cmd.strip().lower() in ("quit", "yes"):
                pass
        if "restart, restore" in low or cmd.strip().lower() == "yes":
            ended = True
            break
        if not out.strip():
            print("!! no output; game may have exited")
            ended = True
            break

    meta = {
        "name": args.name, "turns": len(history) - 1, "models_tried": models,
        "ended": ended, "log": log_path,
        "history": [{"cmd": h["cmd"], "out": h["out"][-600:]} for h in history],
    }
    with io.open(os.path.join(OUT, "%s.json" % args.name), "w",
                 encoding="utf-8", newline="\n") as f:
        f.write(json.dumps(meta, ensure_ascii=False, indent=1))
    game.close()
    print("saved:", log_path)
    return history


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--turns", type=int, default=40)
    ap.add_argument("--name", default=time.strftime("run-%H%M%S"))
    ap.add_argument("--smoke", action="store_true", help="run a fixed script, no API calls")
    ap.add_argument("--key-file", default="")
    ap.add_argument("--goal", default="", help="objective appended to the system prompt")
    ap.add_argument("--prefix", default="", help="commands to run first, semi-colon separated")
    args = ap.parse_args()
    args.script = ["look", "take pamphlet", "inventory", "look pamphlet"] if args.smoke else []
    os.makedirs(OUT, exist_ok=True)
    run(args)


if __name__ == "__main__":
    main()
