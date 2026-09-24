import io

# 6-beat counter sequence matching the SAN cascade required counters:
#   beat1=pre-empt, beat2=respond, beat3=inoculate(Recognition), beat4=restore, beat5=respond, beat6=restore
seq = (
    "steady pre-empt\nface\n"
    "steady respond\nface\n"
    "steady inoculate\nface\n"
    "steady restore\nface\n"
    "steady respond\nface\n"
    "steady restore\nface\n"
)

for fn in ["full-walkthrough.txt", "full-apocalypse-ending.txt"]:
    p = "D:/projects/inform/SoMe-Universe/SoMe-Universe-IF.inform/Tests/Cases/" + fn
    with io.open(p, encoding="utf-8", newline="\n") as f:
        content = f.read()
    # guard: do not double-insert if already patched
    if "steady pre-empt" in content:
        print(fn, "already patched, skipped")
        continue
    out = []
    inserted = False
    for ln in content.split("\n"):
        out.append(ln)
        if ln.strip() == "ask director about sightings" and not inserted:
            # append the multi-line sequence as a single block; join adds the line separators
            out.append(seq.rstrip("\n"))
            inserted = True
    # newline="\n" forces LF on write (avoids CRLF that breaks glulxe command parsing)
    with io.open(p, "w", encoding="utf-8", newline="\n") as f:
        f.write("\n".join(out))
    print(fn, "inserted=", inserted)
