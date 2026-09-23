#!/bin/sh
# Regression runner for the SoMe-Universe Inform project (The Ten Banners).
# Usage: runtests.sh            run all cases, diff against Ideals
#        runtests.sh -bless     (re)bless ideal outputs from current behaviour
#
# Structure:
#   Tests/Cases/<name>.txt   command scripts fed to the game
#   Tests/Ideals/<name>.txt  blessed transcripts (baseline)
#
# Pipeline: inform7 (Windows, C:\Program Files\Inform) -> inform6 (Glulx)
#           -> headless glulxe (WSL Ubuntu, ~/build/glulxe/glulxe)

set -e
BASE="$(cd "$(dirname "$0")/.." && pwd)"
BASEW="$(cygpath -w "$BASE")"
I7="/c/Program Files/Inform/Compilers/inform7"
I6="/c/Program Files/Inform/Compilers/inform6.exe"
BUILD="/mnt/d/projects/inform/build"
WINBUILD="D:/projects/inform/build"
mkdir -p "$WINBUILD/_actual" "$BASE/Tests/Ideals"

BLESS=no
[ "$1" = "-bless" ] && BLESS=yes

echo "== inform7 translation =="
"$I7" -internal "C:/Program Files/Inform/Internal" \
      -external "C:/Users/Gamorang/Documents/Inform" \
      -format=Inform6/32d -o "$WINBUILD/auto.inf" "$BASEW/Source/story.ni" >/dev/null

echo "== inform6 compilation (Glulx) =="
"$I6" -E2 -w -G "$WINBUILD/auto.inf" "$WINBUILD/story.ulx" >/dev/null

FAIL=0
PASS=0
for CASE in "$BASE/Tests/Cases"/*.txt; do
    NAME="$(basename "$CASE" .txt)"
    IDEAL="$BASE/Tests/Ideals/$NAME.txt"
    ACTUAL="$WINBUILD/_actual/$NAME.txt"

    CASE_MNT="$(cygpath -m "$CASE" | sed -e "s|^\\([A-Za-z]\\):|/mnt/\\L\\1|")"
    wsl.exe -d Ubuntu -- sh -c "cd /mnt/d/projects/inform/build && cp '$CASE_MNT' _case.txt && yes '' | head -n 300 >> _case.txt && timeout 120 ~/build/glulxe/glulxe story.ulx < _case.txt" > "$ACTUAL" 2>&1

    if [ "$BLESS" = "yes" ] || [ ! -f "$IDEAL" ]; then
        cp "$ACTUAL" "$IDEAL"
        echo "[B] $NAME (blessed)"
        PASS=$((PASS+1))
    elif diff -q "$ACTUAL" "$IDEAL" >/dev/null 2>&1; then
        echo "[P] $NAME"
        PASS=$((PASS+1))
    else
        echo "[F] $NAME -- transcript differs, see $ACTUAL"
        diff "$IDEAL" "$ACTUAL" | head -20
        FAIL=$((FAIL+1))
    fi
done

echo "== $PASS passed, $FAIL failed =="
[ "$FAIL" = 0 ]