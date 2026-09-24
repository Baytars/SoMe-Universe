import io

p = "D:/projects/inform/SoMe-Universe/SoMe-Universe-IF.inform/Source/story.ni"
with io.open(p, encoding="utf-8") as f:
    s = f.read()

# --- 1) Remove the OLD "ask director about sightings" rule (avoids duplicate-Instead pitfall) ---
start_marker = 'matches the regular expression "^sightings$|^constructs$|^cascade$":'
si = s.index(start_marker)
rule_start = s.rfind("\n", 0, si) + 1
end_marker = "ask again.'\""
ei = s.index(end_marker, si) + len(end_marker)
old_rule = s[rule_start:ei]
assert "The Director completes the walk-through" in old_rule, "old rule not found!"
s = s[:rule_start] + "[ --- Sightings Lanyard SAN cascade: logic relocated below the Director's THIN MAN rule --- ]\n" + s[ei:]

# --- 2) Insert the new SAN Cascade block after the THIN MAN rule ---
anchor = "budget was doubled.'\""
ai = s.index(anchor) + len(anchor)

T = "\t"
new_block = (
    "\n\n"
    "[ --- Sightings Lanyard: the Sanity Cascade (SAN + SCP containment walk; Fred / THIN MAN-01 anchor) --- ]\n"
    "sanity is a number that varies. sanity is 0.\n"
    "sanity-cascade-active is a truth state that varies. sanity-cascade-active is false.\n"
    "sanity-beat is a number that varies. sanity-beat is 0.\n"
    "sanity-preloaded is a text that varies. sanity-preloaded is \"\".\n"
    "sightings-cascade-won is a truth state that varies. sightings-cascade-won is false.\n"
    "\n"
    "To decide which text is the required counter for (b - a number):\n"
    f"{T}if b is 1, decide on \"pre-empt\";\n"
    f"{T}if b is 2, decide on \"respond\";\n"
    f"{T}if b is 3, decide on \"inoculate\";\n"
    f"{T}if b is 4, decide on \"restore\";\n"
    f"{T}if b is 5, decide on \"respond\";\n"
    f"{T}decide on \"restore\".\n"
    "\n"
    "To start the sanity cascade:\n"
    f"{T}now sanity is 50;\n"
    f"{T}now sanity-cascade-active is true;\n"
    f"{T}now sanity-beat is 1;\n"
    f"{T}now sanity-preloaded is \"\";\n"
    f"{T}now sightings-cascade-won is false;\n"
    f"{T}say \"The Director taps the tablet. 'Site-66 containment walk. You carry the protocol; the Construct is on the plinth. Six beats of the cascade, traveler - steady a counter, then face each. Your sanity starts at [sanity]. STEADY pre-empt, respond, inoculate, or restore; then FACE the beat. Hold to the end and the pass is yours.'\";\n"
    f"{T}announce the sanity beat.\n"
    "\n"
    "To announce the sanity beat:\n"
    f"{T}if sanity-beat is 1:\n"
    f"{T}{T}say \"Beat 1 - Initial Sighting. A shape at the treeline of vision. STEADY your counter, then FACE it.\";\n"
    f"{T}otherwise if sanity-beat is 2:\n"
    f"{T}{T}say \"Beat 2 - Viral Spread. The sighting propagates through the network. STEADY, then FACE.\";\n"
    f"{T}otherwise if sanity-beat is 3:\n"
    f"{T}{T}say \"Beat 3 - Scientific Denial, discredited. The Construct folds into the shape of someone you lost - you know that posture. Only recognizing it as a projection holds you. STEADY inoculate, then FACE.\";\n"
    f"{T}otherwise if sanity-beat is 4:\n"
    f"{T}{T}say \"Beat 4 - Increased Belief. The crowd believes the impossible. STEADY restore, then FACE.\";\n"
    f"{T}otherwise if sanity-beat is 5:\n"
    f"{T}{T}say \"Beat 5 - More Sightings, psychosomatic. Copycats bloom. STEADY respond, then FACE.\";\n"
    f"{T}otherwise:\n"
    f"{T}{T}say \"Beat 6 - Authority Collapse. The last pillar wobbles. STEADY restore, then FACE.\".\n"
    "\n"
    "Steadying is an action applying to one topic.\n"
    f"{T}Understand \"steady [text]\" or \"composed [text]\" or \"calm [text]\" or \"breathe [text]\" as steadying.\n"
    "\n"
    "Check steadying:\n"
    f"{T}if the location is not the Puppet Workshop:\n"
    f"{T}{T}say \"There is no cascade to steady here.\" instead;\n"
    f"{T}if sanity-cascade-active is false:\n"
    f"{T}{T}say \"The Director hasn't opened the walk. ASK her about sightings first.\" instead.\n"
    "\n"
    "Carry out steadying:\n"
    f"{T}let c be \"[the topic understood]\";\n"
    f"{T}if c is \"pre-empt\" or c is \"respond\" or c is \"inoculate\" or c is \"restore\":\n"
    f"{T}{T}now sanity-preloaded is c;\n"
    f"{T}{T}say \"You settle the counter in your mind: [c]. FACE the beat when ready.\";\n"
    f"{T}otherwise:\n"
    f"{T}{T}say \"That is not one of the four counters - pre-empt, respond, inoculate, restore.\".\n"
    "\n"
    "Facing the cascade is an action applying to nothing.\n"
    f"{T}Understand \"face\" or \"endure\" or \"step\" or \"proceed\" as facing the cascade.\n"
    "\n"
    "Check facing the cascade:\n"
    f"{T}if the location is not the Puppet Workshop:\n"
    f"{T}{T}say \"The cascade only advances on the Puppet Workshop floor.\" instead;\n"
    f"{T}if sanity-cascade-active is false:\n"
    f"{T}{T}say \"The Director hasn't opened the walk. ASK her about sightings first.\" instead.\n"
    "\n"
    "Carry out facing the cascade:\n"
    f"{T}decrease sanity by 4;\n"
    f"{T}let req be the required counter for sanity-beat;\n"
    f"{T}let personal be false;\n"
    f"{T}if sanity-beat is 3, now personal is true;\n"
    f"{T}if sanity-preloaded is req:\n"
    f"{T}{T}increase sanity by 7;\n"
    f"{T}{T}if personal is true:\n"
    f"{T}{T}{T}say \"Beat 3: the Construct folds into someone you lost - you name it: a template, not a person, and the shape dissolves. Inoculation holds. Sanity [sanity].\";\n"
    f"{T}{T}otherwise:\n"
    f"{T}{T}{T}say \"Beat [sanity-beat]: the right counter holds; the sighting loses its edge. Sanity [sanity].\";\n"
    f"{T}otherwise if sanity-preloaded is not \"\":\n"
    f"{T}{T}decrease sanity by 4;\n"
    f"{T}{T}if personal is true:\n"
    f"{T}{T}{T}say \"Beat 3: the Construct wears your lost one's posture and you reach for the wrong counter - the shape presses closer. Sanity [sanity].\";\n"
    f"{T}{T}otherwise:\n"
    f"{T}{T}{T}say \"Beat [sanity-beat]: the wrong counter feeds the cascade; the sighting hits harder. Sanity [sanity].\";\n"
    f"{T}otherwise:\n"
    f"{T}{T}if personal is true:\n"
    f"{T}{T}{T}say \"Beat 3: the Construct wears your lost one's posture and you face it bare - the shape presses closer. Sanity [sanity].\";\n"
    f"{T}{T}otherwise:\n"
    f"{T}{T}{T}say \"Beat [sanity-beat]: you faced it bare, no counter steadied. Sanity [sanity].\";\n"
    f"{T}now sanity-preloaded is \"\";\n"
    f"{T}if sanity <= 0:\n"
    f"{T}{T}now sanity-cascade-active is false;\n"
    f"{T}{T}now sanity is 50;\n"
    f"{T}{T}say \"Panic break - the room goes white at the edges and the drone swallows the word you were about to say. (The walk resets. ASK the Director about sightings to begin again.)\";\n"
    f"{T}{T}stop;\n"
    f"{T}if sanity-beat is 6:\n"
    f"{T}{T}end the sanity cascade in victory;\n"
    f"{T}{T}stop;\n"
    f"{T}otherwise:\n"
    f"{T}{T}increment sanity-beat;\n"
    f"{T}{T}announce the sanity beat.\n"
    "\n"
    "To end the sanity cascade in victory:\n"
    f"{T}now sanity-cascade-active is false;\n"
    f"{T}now sightings-cascade-won is true;\n"
    f"{T}let lvl be 1;\n"
    f"{T}if sanity >= 60, now lvl is 4;\n"
    f"{T}otherwise if sanity >= 45, now lvl is 3;\n"
    f"{T}otherwise if sanity >= 30, now lvl is 2;\n"
    f"{T}say \"Six beats weathered. The Director closes the tablet. 'Initial sighting. Viral spread. Scientific denial - discredited. Increased belief. More sightings, psychosomatic. Authority collapse. You held, traveler - through the Recognition and the rest.'\";\n"
    f"{T}say \"[line break]'REDACTED,' she says, and the tablet shows a line that was not in the pamphlet: THIN MAN-01 was Daniel of the Phoenix Incident - a living man made into a construct. 'The mind that fears cannot think,' she finishes. 'You kept yours. The pass is graded by what you kept.'\";\n"
    f"{T}if lvl is 4:\n"
    f"{T}{T}say \"[line break]Clearance: Level 4 - Unblinking.\";\n"
    f"{T}otherwise if lvl is 3:\n"
    f"{T}{T}say \"[line break]Clearance: Level 3.\";\n"
    f"{T}otherwise if lvl is 2:\n"
    f"{T}{T}say \"[line break]Clearance: Level 2.\";\n"
    f"{T}otherwise:\n"
    f"{T}{T}say \"[line break]Clearance: Level 1 - provisional.\";\n"
    f"{T}grant the sightings lanyard noting \"The Director hangs the laminated pass around your neck: BEARER CLEARED FOR SIGHTINGS.\"\n"
    "\n"
    "Instead of asking the Director about something when the topic understood matches the regular expression \"^sightings$|^constructs$|^cascade$\":\n"
    f"{T}if the player carries the Rationality Protocol pamphlet:\n"
    f"{T}{T}if the sightings lanyard is carried by the player:\n"
    f"{T}{T}{T}say \"'You have the pass. Walk the floor whenever you like.'\";\n"
    f"{T}{T}otherwise if sanity-cascade-active is true:\n"
    f"{T}{T}{T}say \"'Keep facing the beats, traveler - steady a counter, then face.'\";\n"
    f"{T}{T}otherwise:\n"
    f"{T}{T}{T}start the sanity cascade;\n"
    f"{T}otherwise:\n"
    f"{T}{T}say \"'Your pulse is at drill-rate, traveler,' the Director observes, 'and the cascade eats drill-rate for breakfast. The AAA publishes a field protocol - pre-emptive education, rapid response, inoculation, trust restoration. Read it. Then walk my floor and ask again.'\"\n"
    "\n"
    "After going from the Puppet Workshop when sanity-cascade-active is true:\n"
    f"{T}now sanity-cascade-active is false;\n"
    f"{T}now sanity is 50;\n"
    f"{T}say \"You step out of Site-66; the walk is abandoned. The Construct's fitting light hums on without you.\"\n"
)

s = s[:ai] + new_block + s[ai:]

# --- 3) Replace the trial text ---
old_trial = ('The trial text of the sightings lanyard is "Read the Rationality Protocol pamphlet the Accord publishes, '
             'then keep your pulse through the Puppet Workshop and ASK the Director about sightings."')
assert old_trial in s, "trial text not found!"
new_trial = ('The trial text of the sightings lanyard is "Read the Rationality Protocol pamphlet, then at the Puppet Workshop '
             'ASK the Director about sightings to begin the Site-66 containment walk. STEADY one of the four counters - '
             'pre-empt, respond, inoculate, restore - then FACE each of the six Fear-Cascade beats; hold your sanity through '
             'the Recognition (beat three, where the Construct wears a lost one\'s shape) and the Director grants the lanyard, '
             'cleared by how much you kept."')
s = s.replace(old_trial, new_trial)

with io.open(p, "w", encoding="utf-8") as f:
    f.write(s)

print("patched OK")
print("old rule removed:", "The Director completes the walk-through" not in s)
print("new block present:", "To start the sanity cascade:" in s)
print("trial updated:", new_trial in s)
