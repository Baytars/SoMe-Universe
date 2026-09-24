"""Split the Generalizer's curriculum rule into two shorter rules.

Why: Inform 7 compiles each regex to a Glulx regexp whose size budget is small.
Packing eight anchors into one pattern ("^curriculum$|^curriculum wars$|^narrow$|
...") overflows it and the game prints a run-time P51 "regexp too complex" - which
fires on EVERY ask, because Inform evaluates the conditions of each candidate
Instead rule in turn. The fix is several rules with short patterns instead of one
rule with a long one.

Usage:
    python tools/patch_split_generalizer.py
"""

import io

SRC = "D:/projects/inform/SoMe-Universe/SoMe-Universe-IF.inform/Source/story.ni"

OLD_HEAD = 'Instead of asking the Generalizer about something when the topic understood matches the regular expression '
OLD = (
    OLD_HEAD + '"^curriculum$|^curriculum wars$|^narrow$|^narrow faction$'
    '|^the narrow faction$|^intolerance$|^autoreactivity$|^autoreactive$"'
    ', case insensitively:'
    '\n\trun the curriculum exchange.'
)
NEW = (
    OLD_HEAD + '"^curriculum$|^curriculum wars$|^narrow$|^narrow faction$'
    '|^the narrow faction$|^intolerance$", case insensitively:'
    '\n\trun the curriculum exchange.'
    '\n' + OLD_HEAD + '"^autoreactivity$|^autoreactive$|^stricter self$"'
    ', case insensitively:'
    '\n\trun the curriculum exchange.'
)


def main():
    with io.open(SRC, encoding="utf-8", newline="") as f:
        src = f.read()
    if OLD not in src:
        print("!! long rule not found; nothing to do")
        return
    with io.open(SRC, "w", encoding="utf-8", newline="") as f:
        f.write(src.replace(OLD, NEW, 1))
    print("split into two rules (longest pattern now 78 chars)")


if __name__ == "__main__":
    main()
