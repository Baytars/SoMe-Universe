import io, os, subprocess, sys

# Headless playtest driver for the Sightings Lanyard SAN Cascade.
# Runs the compiled story.ulx through glulxe under WSL with several deliberate
# player behaviours (optimal / errors / abuse / boundary) and saves transcripts
# so a reviewer (human or agent) can critique the actual player experience.

BUILD = "D:/projects/inform/build"
OUT = os.path.join(BUILD, "playtest")
os.makedirs(OUT, exist_ok=True)

PRE = ["s", "choose cradle", "take pamphlet", "go to fear technology"]

COUNTERS = ["pre-empt", "respond", "inoculate", "restore", "respond", "restore"]
WRONG = ["restore", "pre-empt", "respond", "inoculate", "pre-empt", "inoculate"]

def seq_optimal():
    out = []
    for c in COUNTERS:
        out += ["steady " + c, "face"]
    return out

def seq_bare():
    return ["face"] * 6

def seq_wrong_all():
    out = []
    for c in WRONG:
        out += ["steady " + c, "face"]
    return out

def seq_beat3_error():
    out = []
    cs = list(COUNTERS); cs[2] = "respond"
    for c in cs:
        out += ["steady " + c, "face"]
    return out

CASES = {
    "01-optimal":      ["ask director about sightings"] + seq_optimal(),
    "02-bare-no-steady": ["ask director about sightings"] + seq_bare(),
    "03-wrong-all":    ["ask director about sightings"] + seq_wrong_all(),
    "04-beat3-miss":   ["ask director about sightings"] + seq_beat3_error(),
    "05-illegal-counter": ["ask director about sightings", "steady banana", "steady污水处理", "steady pre emt",
                           "steady pre-empt", "face", "face"],
    "06-abandon-midway": ["ask director about sightings", "steady pre-empt", "face", "go to masquerade",
                          "go to fear technology", "ask director about sightings"],
    "07-double-face":  ["ask director about sightings", "face", "face", "steady respond", "face"],
    "08-restready-twice": ["ask director about sightings", "steady pre-empt", "steady respond", "face"],
    "09-aliases":      ["ask director about sightings", "composed pre-empt", "face", "calm respond", "endure",
                        "breathe inoculate", "step", "restore tall", "proceed"],
    "10-no-pamphlet":  ["s", "choose cradle", "go to fear technology", "ask director about sightings"],
    "11-after-win-repeat": ["ask director about sightings"] + seq_optimal() + ["ask director about sightings", "seals"],
    "12-steady-outside":  ["steady pre-empt", "face"],
}

def run_case(name, cmds):
    case_path = os.path.join(BUILD, "playtest_case.txt")
    with io.open(case_path, "w", encoding="utf-8", newline="\n") as f:
        f.write("\n".join(cmds) + "\n")
    mnt = "/mnt/d/projects/inform/build"
    cmd = ("cd %s && yes '' | head -n 300 > _pad.txt && cat playtest_case.txt _pad.txt > _case.txt "
           "&& timeout 120 ~/build/glulxe/glulxe story.ulx < _case.txt" % mnt)
    r = subprocess.run(["wsl.exe", "-d", "Ubuntu", "--", "sh", "-c", cmd],
                       capture_output=True, timeout=180)
    txt = r.stdout.decode("utf-8", "replace")
    out_path = os.path.join(OUT, name + ".txt")
    with io.open(out_path, "w", encoding="utf-8", newline="\n") as f:
        f.write(txt)
    return out_path, len(txt)

if __name__ == "__main__":
    for name, cmds in CASES.items():
        body = cmds if name == "10-no-pamphlet" else PRE + cmds
        p, n = run_case(name, body)
        print("%-22s -> %s (%d bytes)" % (name, os.path.basename(p), n))
