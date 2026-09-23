# Reference Library: SCP Foundation Wiki (Fandom)
## URL: https://scpfoundation.fandom.com/

---

## Core Philosophy

**Mission Statement**: "We secure. We contain. We protect."

The SCP Foundation operates clandestinely to contain anomalous objects, entities, and phenomena—maintaining normalcy for the global civilian population while standing in the darkness to fight it.

---

## Writing Style: Clinical Tone

SCP documents employ "clinical tone"—a writing style characterized by:

- **Objectivity**: No emotional language, no subjective descriptions
- **Precision**: Exact measurements, specific terminology, clear protocols
- **Impersonality**: Written from researcher perspective, detached observation
- **Analytical Structure**: Hierarchical sections, itemized procedures, categorized threats

This style creates horror through **juxtaposition**: cold scientific documentation of incomprehensible anomalies.

---

## Classification System: Object Classes

| Class | Definition | Containment Difficulty |
|-------|------------|----------------------|
| **Safe** | Easily contained, no active threat | Minimal resources |
| **Euclid** | Unpredictable, requires monitoring | Moderate protocols |
| **Keter** | Highly dangerous, difficult to contain | Maximum security |
| **Thaumiel** | Used to contain other anomalies | Classified |

**Application to SoMe**: This system maps perfectly to pathogen threat levels:
- Safe → Common bacteria, easily treated
- Euclid → Drug-resistant strains, unpredictable mutations
- Keter → Pandemic-capable pathogens, cancer metastases
- Thaumiel → Reprogramming technology (can heal or harm)

---

## Document Structure Template

```
Item #: SCP-XXXX
Object Class: [Safe/Euclid/Keter/Thaumiel]

Special Containment Procedures:
[Exact protocols for containment, handling, storage]

Description:
[Physical appearance, anomalous properties, behavioral patterns]

Addendum:
[Incident reports, experiment logs, recovered documents]
```

**Application to SoMe**:
```
Subject: [Pathogen/Disease Name]
Threat Class: [Safe/Euclid/Keter/Thaumiel]

Containment Protocol:
[Treatment regimens, isolation procedures, countermeasures]

Clinical Description:
[Pathophysiology, transmission, symptoms, complications]

Case Files:
[Notable outbreaks, patient histories, research notes]
```

---

## Narrative Techniques

### 1. The Horror of Bureaucracy
Cold administrative language describing existential threats. The gap between "professional tone" and "catastrophic content" creates tension.

### 2. Implied Worldbuilding
Documents reference each other, hinting at larger conflicts and organizations without explicit exposition.

### 3. The [REDACTED] Technique
Strategic censorship forces reader imagination to fill gaps—often more terrifying than explicit description.

### 4. Escalating Revelations
Documents start clinical, gradually reveal worse information, end with implications that recontextualize everything.

---

## Philosophical Framework

From Tufto's Proposal (SCP-001):

> "Modernity defines the boundaries of the unacceptable. The Foundation exists because modernity demands something to exclude."

SCP Foundation **embodies scientific rationality** confronting the **irrational**. The horror comes from:
- Systems failing to comprehend the incomprehensible
- Order struggling against chaos
- Knowledge never being enough

**Application to SoMe**:
Medicine embodies scientific rationality. Disease represents the irrational—mutations, resistances, the body's own cells turning against itself. The horror isn't supernatural; it's the **limits of medical knowledge**.

---

## SoMe Adaptation Strategy

### Structural Parallels

| SCP Element | SoMe Equivalent |
|-------------|-----------------|
| SCP Foundation | UNSC Medical Division |
| Anomalies | Pathogens, diseases, cellular malfunctions |
| Containment | Treatment protocols, quarantine, countermeasures |
| Object Classes | Threat Classifications (Naïve → Memory → Specialist → Officer) |
| Clinical Tone | Medical Report Style (already established in Prologue) |
| Incident Reports | Case Files, Outbreak Chronicles |
| [REDACTED] | [CLASSIFIED], Patient Confidentiality |

### Unique SoMe Advantages

1. **Real Science**: Unlike SCP's fictional anomalies, SoMe's threats are real medical phenomena—makes horror more grounded
2. **Treatable vs. Containable**: SCP contains; SoMe can potentially **cure**—creates hope alongside horror
3. **Player Agency**: SCP documents are observation logs; SoMe players **act**—decisions matter
4. **Progressive Understanding**: Medicine advances; SCP anomalies often remain incomprehensible

---

## API Access

**Platform**: Fandom (MediaWiki-based)

**API Endpoint**: `https://scpfoundation.fandom.com/api.php`

**Protocol**: REST (MediaWiki Action API)

**Authentication**: None required for read operations

**Available Actions**:
- `action=query` — Query pages, categories, revisions
- `list=search` — Search for pages by keyword
- `prop=revisions` — Get page content and history
- `prop=categories` — Get categories for a page
- `prop=templates` — Get templates used on a page

**Example Usage**:
```bash
# Search for SCP articles
curl "https://scpfoundation.fandom.com/api.php?action=query&list=search&srsearch=SCP-173&format=json"

# Get page content
curl "https://scpfoundation.fandom.com/api.php?action=query&prop=revisions&titles=SCP-173&rvprop=content&format=json"

# Get pages in a category
curl "https://scpfoundation.fandom.com/api.php?action=query&list=categorymembers&cmtitle=Category:Keter&format=json"
```

**TypeScript Library**: `fandom-api-types`
```bash
npm install fandom-api-types
```

---

## Reference Documents

- SCP-173 (The Sculpture): First SCP, demonstrates core format
- SCP-682 (Hard-to-Destroy Reptile): Keter-class example
- SCP-2000 (Deus Ex Machina): Thaumiel-class, world-building
- SCP-001 Proposals: Various origin stories, meta-narrative techniques

---

## Key Takeaway for SoMe

SCP's power lies in **making the extraordinary feel documented**. The clinical tone doesn't diminish horror—it amplifies it by showing how insufficient human systems are against true threats.

For SoMe: Medical documentation of disease should feel equally inadequate. The more precise the protocols, the more terrifying when they fail.

**"We secure. We contain. We protect."**  
→ **"We diagnose. We treat. We heal."**

But sometimes... healing fails.

---

*Document compiled for SoMe development reference. Last updated: 2026-04-08*
