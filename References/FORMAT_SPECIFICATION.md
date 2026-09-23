# SoMe Universe Character Entry Format Specification
## Unified Format for Character Entries v1.0

---

## Overview

This document defines the standardized format for all character entries in the SoMe Universe wiki. The format is designed to:
1. Maintain sci-fi military dossier aesthetic
2. Preserve historical person tributes and parallels
3. Support complete tactical/strategic documentation
4. Enable consistent parsing and cross-referencing

---

## Required Frontmatter

```yaml
---
layout: default
title: [Display Title]
codename: [Short Code Name]
classification: [Biological/Role Classification]
historical_parallel: [Historical Person Name (Years)] — Brief description
affiliation: [Faction: Immune Division | Neoplasm Forces | Umin | Neutral]
status: [Active | Dormant | Legendary | Deceased | Pervasive]
tags: [List of relevant tags]
---
```

### Frontmatter Fields Explained

| Field | Required | Description |
|-------|----------|-------------|
| `layout` | Yes | Must be `default` |
| `title` | Yes | Full display title (e.g., "HeLa — The Immortal Navigator") |
| `codename` | Yes | Short identifier (e.g., "HeLa") |
| `classification` | Yes | Biological/role classification |
| `historical_parallel` | No | Real historical figure being honored |
| `affiliation` | Yes | Faction alignment |
| `status` | Yes | Current operational status |
| `tags` | No | For categorization and search |

---

## Document Structure

### 1. Header Section
```
# [CODE NAME] "[Title/Epithet]"

**Tactical Designation | Role Summary | Origin Tribute**

> Epigraph quote that captures the character's essence
```

### 2. Overview Section
Contains basic information in this order:
- Code Name
- Classification
- Codename Origin (etymology)
- Vessel/Cell Classification (if applicable)
- Operational Domain
- Service Period/Status

### 3. Historical Context Section
- **For characters with historical parallels**: Background on the real person
- **For original characters**: Origin story and transformation

### 4. Tactical Profile Section
Required subsections:
- **Role Classification**: Primary function and strategic value
- **Operational Doctrine**: Quote + explanation
- **Known Capabilities**: Bulleted list of abilities
- **Combat Behavior**: How the character engages

### 5. Character Profile Section
- Physical appearance/description
- Psychological profile
- Relationships with other characters

### 6. Narrative Significance Section
- Role in the larger story
- Philosophical themes
- Unique perspective on the conflict

### 7. Medical/Scientific Counterparts Section
Comparison table (if applicable):
| Aspect | Normal State | Character State |

### 8. Notable Quotes Section
3-5 representative quotes in blockquote format

### 9. Metadata Footer
```
---
**Classification:** [Tactical Classification]
**Priority:** [LOW | MEDIUM | MEDIUM-HIGH | HIGH | CRITICAL]
**Recommended Response:** [Countermeasures if enemy]

**— END DOSSIER —**
```

---

## Style Guidelines

### Writing Style
- **Tone**: Military dossier meets literary fiction
- **Voice**: Third-person character narration preferred
- **Quotes**: Use `>` blockquotes with attribution
- **Emphasis**: Use **bold** for key terms and names

### Naming Conventions
- Characters: `FirstName_LastName_The_Epithet.md`
- Factions: Use category-specific names (Commander, Vessel, Operative)
- Cross-references: Use `[[Character Name]]` wiki-style links

### Terminology Standards
- **Immune Division**: Friendly forces
- **Neoplasm**: Cancer/tumor enemy forces
- **Umin**: Psychological warfare enemy faction
- **Vessel**: Large-scale friendly units
- **Cell**: Individual-scale entities

---

## Format Examples

### Example 1: Historical Figure (Immune Division)
```markdown
---
layout: default
title: Nightingale — The Lady with the Lamp
codename: Nightingale
classification: Medical Support Carrier-Class Vessel
historical_parallel: Florence Nightingale (1820-1910) — Founder of modern nursing
affiliation: Immune Division
status: Active
tags: [medical, support, vessel, historical-tribute]
---

# NIGHTINGALE "The Lady with the Lamp"

**Medical Support Carrier | Heavenly Army Medical Corps | The Scarlet Guardian**

> *"In the darkness of the battlefield, I carry the light..."*
```

### Example 2: Enemy Commander (Neoplasm)
```markdown
---
layout: default
title: Chrono-01 — The Eternalist
codename: Chrono-01
classification: Telomerase-Positive Tumor Stem Cell
historical_parallel: null
affiliation: Neoplasm Forces
status: Active
tags: [neoplasm, immortal, commander, telomerase]
---

# CHRONO-01 "The Eternalist"

**Strategic Core | Telomerase Sovereign | Granters of Immortality**

> *"I do not fight to survive. I fight because survival has already been achieved..."*
```

---

## Conversion Notes

When converting from legacy formats:
1. Extract frontmatter from existing metadata
2. Preserve all content - never delete
3. Add missing sections where content exists
4. Maintain cross-references between characters
5. Add appropriate metadata footer if missing

---

**Document Version:** 1.0  
**Last Updated:** 2024  
**Maintained By:** SoMe Universe Wiki Team
