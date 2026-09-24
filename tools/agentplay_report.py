"""Summarise autonomous agentplay transcripts.

Scans build/agentplay/*.txt and reports, per run:
- how many turns the model took and whether it earned its target seal
- how many of those turns were *wasted* on unparseable / refused input
- the distinct refusal messages, with counts, so guidance gaps are obvious

Usage:
    python tools/agentplay_report.py            # all runs
    python tools/agentplay_report.py seal-bat   # one run + its command list
"""

import glob
import io
import os
import re
import sys

OUT = "D:/projects/inform/build/agentplay"

# Phrases the parser prints when the player's input did not become a real action.
# These are the signal that the game failed to understand a reasonable player.
FRICTION = [
    ("parser-noop", r"I beg your pardon\?"),
    ("unknown-verb", r"not a verb I recognise"),
    ("partial-understand", r"I only understood you as far as"),
    ("nothing-on-topic", r"offers nothing on that"),
    ("cant-see", r"You can't see any such thing"),
    ("cant-do", r"That's not something you can"),
    ("refused-plain", r"You can't\.|You cannot\.|That's not a verb"),
    # any hard stoppage / failure branch the trials can print
    ("died", r"\*\*\* You have died|You have died"),
    ("abandoned", r"run is abandoned|WALK ABORTED"),
    ("panic", r"Panic break|No pass\. No penalty"),
]

# Each seal's printed grant line, enough to detect a win from the transcript.
# IMPORTANT: these must only ever be matched against the game's OUTPUT, never
# against the echoed "> cmd" line - "examine Pale Masquer" contains "Pale Masque"
# and produced a false positive in an early version of this script.
SEAL_WON = {
    "cradle": r"presses the Cradle Sigil|Grants you the Cradle Sigil|Cradle Sigil into your hand",
    "corps": r"Celestial Corps issues it|hands you the Vesalius Medallion|presses the Vesalius Medallion",
    "quicksilver": r"hands you the Quicksilver Ampoule|Quicksilver Ampoule into your hand|gives you the Quicksilver Ampoule",
    "knitting": r"hands you the Knitting Needle|Knitting Needle into your hand|gives you the Knitting Needle",
    "sulfur": r"Sulfur Sigil into your hand|hands you the Sulfur Sigil",
    "masque": r"\bPale Masque\b(?!r)",
    "bat": r"Bat Sigil into your hand|hands you the Bat Sigil|marks you with the Bat Sigil",
    "stille": r"Stille Seal into your hand|hands you the Stille Seal|presses the Stille Seal",
    "sightings": r"BEARER CLEARED FOR SIGHTINGS",
    "abyssal": r"Abyssal Pennant into your hand|hands you the Abyssal Pennant",
}


def parse(path):
    raw = io.open(path, encoding="utf-8", errors="replace").read()
    turns = []
    for chunk in raw.split("=== TURN ")[1:]:
        m = re.match(r"(\d+) \[([^\]]*)\] ===\n> (.*?)\n", chunk)
        if not m:
            continue
        turns.append({
            "n": int(m.group(1)),
            "model": m.group(2),
            "cmd": m.group(3).strip(),
            "out": chunk[m.end():],
        })
    return raw, turns


def classify(out):
    """Return the label of the strongest friction signal in this turn's output."""
    for label, pat in FRICTION:
        if re.search(pat, out, re.IGNORECASE):
            return label
    return None


def main():
    names = sys.argv[1:]
    files = []
    if names:
        for n in names:
            files += glob.glob(os.path.join(OUT, n + ".txt"))
    else:
        files = sorted(glob.glob(os.path.join(OUT, "*.txt")))

    print("%-18s %5s %5s  %-12s %s" % ("RUN", "TURN", "WASTE", "SEAL", "TOP FRICTION"))
    print("-" * 78)
    for fp in files:
        name = os.path.basename(fp)[:-4]
        raw, turns = parse(fp)
        if not turns:
            print("%-18s %5s %5s  %s" % (name, "-", "-", "(no autonomous turns yet)"))
            continue
        waste = 0
        counts = {}
        outputs = []
        for t in turns:
            outputs.append(t["out"])
            lab = classify(t["out"])
            if lab:
                counts[lab] = counts.get(lab, 0) + 1
                if lab in ("parser-noop", "unknown-verb", "partial-understand",
                           "nothing-on-topic", "cant-see"):
                    waste += 1
        # Look for the grant ONLY inside the game's own output. The echoed
        # command line is excluded, otherwise players just typing the name
        # register as a win.
        said = "\n".join(outputs)
        # which seal does the run target? infer from the run name suffix.
        target = name.split("-")[-1]
        won = "-"
        for key, pat in SEAL_WON.items():
            if key.startswith(target) and re.search(pat, said):
                won = key
                break
        # the score notification is the universal grant marker
        gained = len(re.findall(r"Your score has just gone up by one point", said))
        if gained and won == "-":
            won = "? (+%d)" % gained
        top = sorted(counts.items(), key=lambda kv: -kv[1])[:3]
        top_s = ", ".join("%s x%d" % kv for kv in top) if top else "none"
        print("%-18s %5d %5d  %-12s %s" % (name, len(turns), waste, won, top_s))

    if names:
        for fp in files:
            raw, turns = parse(fp)
            print("\n########## %s ##########" % os.path.basename(fp)[:-4])
            for t in turns:
                flag = classify(t["out"])
                mark = "  <<< " + flag if flag else ""
                print("%3d. %-42s %s" % (t["n"], t["cmd"][:42], mark))


if __name__ == "__main__":
    main()
