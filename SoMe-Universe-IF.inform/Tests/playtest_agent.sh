#!/bin/bash
# playtest_agent.sh - 测试玩家/评测 harness 驱动脚本（模仿 sm3-inform/Tests/playtest.sh）
# 用法: bash Tests/playtest_agent.sh [mode] [token] [out-file] [max-turns]
#   mode     : review（默认，跑 Cases+强模型评测）| play（自治试玩）
#   token    : Agnes API key（默认读 Tests/.playtest_token；或用 env AGNES_TOKEN）
#   out-file : 评测输出（默认 Tests/playtest_feedback.txt）
#   max-turns: play 模式探索回合数上限（默认 26）
#
# 行为：
#   1) 若 story.ulx 缺失或比 story.ni 旧，则重新编译（inform7 + inform6，已修 POSIX 路径 bug）
#   2) 调用 playtest_agent.py（默认 review 模式）产出中文评测
cd "$(dirname "$0")/.." || exit 1

MODE="${1:-review}"
TOKEN="${2:-${AGNES_TOKEN}}"
OUT="${3:-Tests/playtest_feedback.txt}"
MAXT="${4:-26}"

if [ -z "$TOKEN" ] && [ -f Tests/.playtest_token ]; then
  TOKEN="$(cat Tests/.playtest_token)"
fi
if [ -z "$TOKEN" ]; then
  echo "用法: bash Tests/playtest_agent.sh <agnes-token> [out-file] [max-turns]" >&2
  exit 1
fi

BASE="D:/projects/inform/SoMe-Universe/SoMe-Universe-IF.inform"
NI="$BASE/Source/story.ni"
ULX="D:/projects/inform/build/story.ulx"
INF="D:/projects/inform/build/auto.inf"
I7="/c/Program Files/Inform/Compilers/inform7"
I6="/c/Program Files/Inform/Compilers/inform6.exe"

# 1) 编译兜底
NEED_BUILD=0
if [ ! -f "$ULX" ]; then NEED_BUILD=1; fi
if [ "$NI" -nt "$ULX" ] 2>/dev/null; then NEED_BUILD=1; fi
if [ "$NEED_BUILD" = "1" ]; then
  echo "== 编译 story.ni -> story.ulx =="
  "$I7" -internal "C:/Program Files/Inform/Internal" \
        -external "C:/Users/Gamorang/Documents/Inform" \
        -format=Inform6/32d -o "$INF" "$NI" >/dev/null
  "$I6" -E2 -w -G "$INF" "$ULX" 2>&1 | tail -5
fi

# 2) 运行 harness
AGNES_TOKEN="$TOKEN" AGENT_TURNS="$MAXT" \
  python3 "$BASE/Tests/playtest_agent.py" "$MODE" "$OUT" "$MAXT"
