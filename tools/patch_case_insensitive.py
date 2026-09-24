"""Make every `topic understood` regex match case-insensitively.

Why: an autonomous playtest typed `ask Count Dracula about Meister` and the game
answered "offers nothing on that", because all 115 topic rules were written as
`the topic understood matches the regular expression "^meister$"`, which is
case-sensitive. Players capitalise proper nouns; the game must tolerate that.

Inform 7 supports the trailing `, case insensitively` option on the phrase, so
the fix is purely mechanical: append it after every such comparison.

Usage:
    python tools/patch_case_insensitive.py
"""

import io
import re

SRC = "D:/projects/inform/SoMe-Universe/SoMe-Universe-IF.inform/Source/story.ni"

# Note the regex stops at the closing quote; none of these patterns contain one.
PAT = re.compile(r'the topic understood matches the regular expression "([^"]*)"(, case insensitively)?')


def main():
    # newline="" keeps the existing line endings intact on read+write:
    # this file is pinned eol=lf, and writing CRLF here breaks the compiler.
    with io.open(SRC, encoding="utf-8", newline="") as f:
        src = f.read()

    already = 0

    def repl(m):
        nonlocal already
        if m.group(2):
            already += 1
            return m.group(0)
        return 'the topic understood matches the regular expression "%s", case insensitively' % m.group(1)

    out = PAT.sub(repl, src)
    total = len(PAT.findall(out))
    print("rules total:      %d" % total)
    print("already patched:  %d" % already)
    print("newly patched:    %d" % (total - already))
    if out != src:
        with io.open(SRC, "w", encoding="utf-8", newline="") as f:
            f.write(out)
        print("written:", SRC)
    # sanity: every occurrence now carries the option
    left = PAT.sub(lambda m: m.group(0), out).count(', case insensitively')
    print("annotated now:    %d" % left)


if __name__ == "__main__":
    main()
