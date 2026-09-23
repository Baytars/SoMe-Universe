# The Sheather — 敛锋者

> **#85** | Faction: F2 (adaptive immunity) — Songhai tonality | First appeared: 2026-09-23 morning
> Role: false-folate apothecary who gently persuades over-activated T cells into peaceful apoptosis, so anti-drug antibodies never form
> Design display: `imgs/260923_07_生图/some_0923m_sheather_display_v5.png`

## Scientific origin

Sottile S., Paul C., Audo R., Rispens T., Mulleman D., Rashkov P., **"Methotrexate's effect on cells and adalimumab immunogenicity in axial spondyloarthritis: A mathematical study,"** *PLOS Computational Biology*, 2026-09-21. DOI: [10.1371/journal.pcbi.1014740](https://doi.org/10.1371/journal.pcbi.1014740).

- In axial spondyloarthritis (AxSpA), up to 25% of patients stop the TNF inhibitor adalimumab because anti-drug antibodies (ADA) reduce its effectiveness.
- Methotrexate (MTX) is ineffective alone but reduces ADA formation; its mechanism on the immune response was unclear.
- An ODE model described T/B lymphocytes, adalimumab, MTX, TNF-α and BLyS dynamics, calibrated on prior in-vitro data and the CoMARIS trial (110 patients, five visits).
- Virtual patient cohorts tested **31 competing mechanism scenarios**; simulations best support **MTX reducing immunogenicity by increasing apoptosis of activated T cells**.
- Boundary: this is a model-selected preferred mechanism, not direct in-vivo validation; its value is prioritizing what experiments to run next.
- Design language also draws on real MTX chemistry: a folate structural mimic (false leaf), and MTX's known adenosine-release anti-inflammatory pathway in rheumatoid arthritis.

## Character concept

A quietist Songhai apothecary in a dawn cloister. She is the drug made woman — a *false leaf*, a folate mimic that walks into the lymph-node garth not to fight, but to kneel with those who fight too hard. Over-activated T cells are the bravest of warriors, yet their blades raised against a healing antibody are what makes the cure fail; rather than strike them down, she lays a single pale leaf on each brow and persuades the fire to go out on its own: programmed death, peaceful, unforced. The tray of frosted silver leaves is her pharmacopeia; the small kneeling sentry before her, orange-red blade fading to grey steel and eyes closing, is the moment mercy is mistaken for defeat. She asks no credit — fewer antibodies, a treatment that keeps working, a patient who never knows her name.

Name: **敛锋者 The Sheather** — 敛 = sheathe/restrain/draw in; 锋 = blade edge. English: sheather, one who returns a sword to its sheath.

## Visual design (canonical v5)

- **Eye slot intent — #26 muted sage `sheathed-sage`**: irises meant to be a dull, dusty grey-green like dried sage in shadow, flat matte and unlit, faint leaf-vein lines from a plain dark pupil, both eyes identical, no glow. *Production note:* the exact sage-green iris was not fully achieved — see Iteration record; v5 reads as a dark matte olive-grey. Identity is carried by the silver leaves, blade-fading motif and dawn garth.
- Pale ash-sage hair in one low braid with silver leaf beads; one small single-strand gold spiral coil pin (α-helix, explicitly not DNA; no rungs).
- Mist blue-grey crossed-collar short-sleeve robe, sage trim, moss sash, cloth panels with simple leaf-vein embroidery; soft cloth, no armor, bare feet.
- Only two hands. One holds an ivory tray piled with frosted silver leaves (her false-folate pharmacopeia); the other places one pale leaf on the forehead of a small kneeling armored warrior whose glowing orange-red blade fades to grey steel, eyes closed peacefully.
- Setting: bright cold-dawn cloister of pale stone arches, cold blue-white light, dark flagstones, falling dry leaves, far horizon one thin warm rose line. A tiny distant rose form appears at the horizon behind the sword (unwanted prior; far and small).

## Duelyst mapping draft (for owner post-processing)

F2/Songhai minion, ~3 mana 2/4.

- New keyword **Quietus 安息**: Battlecry dispel one enemy minion; if 2+ buffs are removed, that minion skips its next turn (the over-zealous warrior rests). At end of turn, one adjacent attacking enemy gains −1 attack.
- Linked spell **Adenosine Hush 腺苷低吟** (2 mana): one enemy minion cannot attack or be targeted by buffs this turn; draw 1.
- Linked spell **False Leaf 伪叶** (3 mana): destroy a dispelled enemy minion (the persuaded death); restore 1 Health to your General.
- Counters over-aggression / buff-heavy boards; pairs with Songhai dispel tools.

## Iteration record

- v1 (994 chars): strong composition — full body, bright cold dawn, correct two hands (tray + leaf on brow), blade fading orange-red→grey, warrior eyes closed, zero text, no flowers. Fail: eyes rendered bright luminous **light blue/silver** with big white highlight dots, not green.
- v2: eyes re-anchored with green-stone material and blue/grey negations; model swung to **bright luminous vivid glowing green** — opposite failure.
- v3: dried-sage herb metaphor, unlit; eyes muted but read **greyish dark grey** — green lost again. Scene also darker than v1 (warrior shaved head), otherwise anchors held.
- v4: explicit "grey-green" naming; regressed to glowing vivid green, added a pink rose at an arch, and swapped the hands.
- v5 (final): "dull dusty sage-green, grayish green like dried sage, flat matte unlit" with bright/glow negations; returned to v1's strong bright-dawn composition and correct hand action, zero readable text. Eyes land as **dark matte olive-grey** — not the named sage slot, but unlit, non-glowing and tonally right for a mercy figure.
- Lessons: (1) the model oscillates on a *narrow low-saturation hue* — suppress glow and it outputs grey, name green and it outputs neon; muted sage sits at an unstable point for this model. Future muted-color slots should anchor with a **named real-world colored object that is inherently both grey and green** (e.g. "sage foliage in fog" gave grey; consider an explicit two-word paint/chip name like "dried artemisia" tested separately) and accept ≤3 rounds. (2) Flower/rose prior at the dawn horizon survives even "no roses, no flowers"; a flower persists as a memorial cliché at an arch opening — crop the arch line during self-check. (3) Compression discipline held: parts composed up front, no per-character bash spin; the 1000-char hard limit was discovered at submit (VALIDATE_INPUT, no credits consumed) and subsequent prompts drafted to ≤995.
- Self-verification: full frame plus enlarged eye crops reviewed directly; robe panels and arch openings checked for text and flowers.
