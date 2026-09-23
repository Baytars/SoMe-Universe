# Metabolic Homoiconicity: The TCA Cycle as Carbon-Based Lisp

```
┌─────────────────────────────────────────────────────────────────┐
│  METABOLIC HOMOICONICITY                                        │
│  ══════════════════════════════════════════════════════════════│
│  Classification: Foundational Worldbuilding Document            │
│  Domain: Metabolic Architecture / Computational Biology         │
│  Threat Level: N/A (Systems Framework)                          │
│  Status: Canonical                                              │
│  Origin: 2026-07-08 Deep Discussion (Session 01:35–01:48)      │
└─────────────────────────────────────────────────────────────────┘
```

## Overview

This document establishes the theoretical foundation for the **metabolic resource system** in the *Saga of Medicine* (SoMe) universe. It formalizes a deep structural isomorphism between the tricarboxylic acid (TCA) cycle and Lisp's homoiconicity—the principle that *code is data and data is code*.

The thesis is not metaphorical. It is structural: the TCA cycle is a carbon-based implementation of a self-modifying computational system, where metabolic intermediates serve as both substrate (data) and regulatory signal (code). This isomorphism provides the SoMe universe with a scientifically grounded framework for treating metabolism not as background flavor, but as an **operational strategy layer**—the equivalent of an operating system's process scheduler.

> *"McCarthy designed Lisp in 1958 to find the minimal self-consistent basis of computation. Carbon chemistry converged to the same answer four billion years earlier."*

---

## Part I: The Eight Intermediates — Why These Molecules?

### 1.1 Thermodynamic Inevitability

**Morowitz's thought experiment.** Harold Morowitz proposed that if one takes CO₂, water, and a reducing agent, and allows inorganic chemistry to run freely, the first stable organic small molecules to emerge are precisely the TCA cycle intermediates. Citrate, succinate, fumarate, malate, oxaloacetate—they are the **local thermodynamic energy minima** in the C4–C6 carboxylic acid configuration space.

Carbon atoms, under simple chemical conditions, naturally fall into these molecular configurations. No enzymes required. No life required. No selection pressure required. These eight molecules are not "recruited" into a cycle—they are **what carbon chemistry inevitably produces**.

**Implication:** Any planet with liquid water and carbon, once chemistry begins, will see these eight molecules emerge. They are not a biological invention but a **chemical destiny**.

### 1.2 Reverse Origin (rTCA): The Cycle May Predate Life

The most profound hypothesis is the **reductive TCA cycle (rTCA)**. Before life originated, these eight molecules may have cycled in the **reverse direction**—not oxidizing substrates for energy, but fixing CO₂ to synthesize organic matter.

- These eight molecules were among Earth's **first organic molecules**
- The cycle was not a tool life invented, but the **cradle from which life emerged**
- When the Great Oxidation Event (~2.4 Ga) released free oxygen, the cycle **flipped direction**—from synthesis to oxidation, from energy consumption to energy production

If the rTCA hypothesis holds, this metabolic pattern has been turning since the inorganic world. Life did not build the engine; **life was built upon the engine's ruins**.

### 1.3 Chemical Versatility: The α-Keto Acid Advantage

The eight TCA intermediates share a critical structural feature: nearly all are **α-keto acids or their direct derivatives**. This is not coincidence. α-Keto acids are the most chemically versatile class of small carboxylic acids:

| Reaction Type | Capability |
|---|---|
| **Decarboxylation** | Lose CO₂, shortening carbon chain |
| **Transamination** | Convert to amino acids (nitrogen entry point) |
| **Oxidation/Reduction** | Transfer electrons, modulate redox state |
| **Condensation** | Build larger carbon skeletons |

The cycle did not pick eight random molecules from the chemical space. It identified the **only combination** of carbon-chemistry-native molecules capable of forming a closed catalytic loop.

### 1.4 Catalytic Closure: Why a Ring?

A linear oxidation pathway for acetyl-CoA would require continuous input of carrier molecules. The ring's elegance: **the terminal product is the starting material**. Oxaloacetate (4C) + Acetyl-CoA (2C) → Citrate (6C) → two decarboxylations → back to 4C.

This is the **minimal catalytic loop** capable of fully oxidizing a 2-carbon substrate using a 4-carbon carrier:

- **3C carrier:** Insufficient. 3+2=5, decarboxylating twice leaves 1C—cannot form a stable ring.
- **5C carrier:** Redundant. Thermodynamically unstable; no corresponding stable molecular form.
- **4C carrier:** The unique solution. And the only chemically stable 4C carrier is **oxaloacetate**.

### 1.5 Convergence: The Inevitable Ring

The eight TCA intermediates are not assembled. They are the **topology of carbon chemistry itself**.

Imagine the chemical space of carbon as a mountain range. These eight molecules are the natural basins—water (chemical reactions) inevitably flows into them. The TCA cycle is the ring of waterways connecting these basins, carved by thermodynamics over four billion years.

Krebs did not design this cycle. Morowitz did not design this cycle. **No one designed it.** It is the inevitable product of carbon, water, and the Second Law on geological timescales. Life merely moved into the pre-existing waterway and built enzyme-houses around it.

> **SoMe Narrative Implication:** The line "this engine has run for 2 billion years without a version update" is an understatement. The correct framing is: **this engine predates us. We built our civilization on its ruins.** The mitochondrial endosymbiosis theory supports this directly—mitochondria were independent organisms that were engulfed and became organelles, and their core legacy is this cycle.

---

## Part II: The Three α-Keto Acids as Metabolic Instruction Set

### 2.1 The Metabolic ISA (Instruction Set Architecture)

Three α-keto acids serve as the **metabolic instruction set** of the cell, each generating a family of amino acids:

| α-Keto Acid | Carbon Length | Amino Acid Family | Coverage |
|---|---|---|---|
| **Pyruvate** | 3C | Alanine (and downstream to Valine, Leucine) | ~3 of 20 amino acids |
| **Oxaloacetate (OAA)** | 4C | Aspartate → Asparagine, Methionine, Threonine, Lysine, Isoleucine | ~6 of 20 amino acids |
| **α-Ketoglutarate (α-KG)** | 5C | Glutamate → Glutamine, Proline, Arginine | ~3 of 20 amino acids |

Together, these three molecules generate approximately **12 of the 20 proteinogenic amino acids**. They are the cell's **universal intermediate language**—analogous to a bytecode VM that different cell types compile into different protein outputs.

### 2.2 α-KG: The Molecule That Is Both Data and Code

α-Ketoglutarate is the pivotal molecule in the homoiconicity framework. It simultaneously occupies two roles:

#### As Data (Execution)
α-KG is a substrate of the TCA cycle itself. It is oxidized by α-ketoglutarate dehydrogenase to succinyl-CoA, feeding electrons into the electron transport chain. In this role, α-KG is **consumed as fuel**—the metabolic equivalent of `eval`.

#### As Code (Control)
α-KG is an **essential cofactor** for two families of epigenetic enzymes:
- **TET dioxygenases** (TET1/2/3): Catalyze DNA demethylation (5mC → 5hmC → 5fC → 5caC → unmodified C)
- **JmjC histone demethylases**: Remove methyl groups from histone tails (H3K4, H3K9, H3K27, H3K36)

These enzymes **directly control which genomic regions are readable and which are silenced**. α-KG concentration is therefore a **master regulatory signal** for chromatin state and gene expression programs.

**The homoiconic insight:** The same molecule that the TCA cycle *produces as output* (data) is the molecule that *controls the TCA cycle's own transcription* (code). This is not analogous to self-modifying code. **This is self-modifying code**, implemented on carbon hardware with molecular concentration in place of voltage.

### 2.3 Clinical Correlates: When the Interpreter Breaks

#### Cerebral Ischemia
```
TCA cycle stalls
    → α-KG depleted
    → Glutamate transaminase reverses (consuming glutamate → α-KG)
    → Excitotoxicity (glutamate depletion dysregulates neurotransmission)
    → TET/JmjC stall without α-KG cofactor
    → Epigenetic freeze (chromatin state locked, no gene expression reprogramming)
```

In SoMe terms: the Lisp interpreter crashes. The cell loses both its energy supply (eval fails) and its self-modification capability (quote fails). The program is frozen mid-execution with no ability to rewrite itself out of the failure state.

#### Neuronal Reprogramming
TET enzymes require α-KG to function. When the metabolic system cannot sustain an α-KG pool—whether due to mitochondrial dysfunction, substrate limitation, or competitive inhibition—the **epigenetic tools have no fuel**. Reprogramming fails not because the transcription factors are absent, but because the metabolic substrate for chromatin remodeling is exhausted.

**SoMe Design Corollary:** Reprogramming is not a "spell cast" but a **compile job** that requires metabolic fuel. A cell in metabolic distress cannot be reprogrammed any more than a computer with a dead battery can run a compiler.

#### IDH-Mutant Tumors
Mutant IDH (IDH1 R132H or IDH2 R172K) converts α-KG into **2-hydroxyglutarate (2-HG)** instead of the normal product. 2-HG is a **competitive inhibitor** of TET and JmjC enzymes—it occupies the α-KG binding site but cannot function as a cofactor.

The tumor produces a **shadow molecule**—structurally similar to α-KG but functionally null. It freezes the epigenetic landscape by poisoning the interpreter:

> *The tumor doesn't delete the code. It replaces the compiler with one that silently refuses to run.*

This explains why IDH-mutant tumors exhibit **differentiation arrest**: not because cells cannot differentiate, but because the epigenetic interpreter is **locked**. The differentiation macro cannot expand.

---

## Part III: The Lisp–Metabolism Isomorphism

### 3.1 The Mapping Table

| Lisp Concept | Metabolic Correspondent | Mechanism |
|---|---|---|
| **S-expression** | α-Keto acid (universal data/code carrier) | A single molecular type that serves as both substrate and signal |
| **`eval`** | Entry into TCA cycle for oxidation | The molecule is consumed as fuel—executed as data |
| **`quote`** | Binding to TET/JmjC as cofactor | The molecule is used as code—regulates gene expression without being consumed |
| **macro** | Epigenetic enzymes (TET, JmjC, DNMT, HDAC) | Generate new "programs" by rewriting chromatin state |
| **REPL** | TCA cycle (Read-Eval-Print-Loop) | Literally: substrates enter (Read), are oxidized (Eval), CO₂ and products exit (Print), carrier regenerates (Loop) |
| **closure** | Compartmentalization (mitochondrial matrix vs. cytosol) | The same molecule in different compartments has different scope and binding—α-KG in the matrix is fuel; α-KG in the nucleus is a regulatory signal |
| **GC (garbage collection)** | Urea cycle | Nitrogen waste (ammonia from transamination) is collected, detoxified, and excreted—metabolic garbage collection |
| **self-modifying code** | α-KG → TET → rewrite TCA enzyme expression → alter α-KG production | The cycle's output controls the cycle's own transcription—the quintessential Lisp power |

### 3.2 Core Insight

**The TCA cycle produces a molecule (α-KG) that controls the TCA cycle's own compilation.**

This is the defining property of homoiconicity: a system whose outputs can serve as inputs to its own modification. In Lisp, this enables macros that generate code that generates macros. In metabolism, this enables a feedback loop where metabolic state controls gene expression, which controls metabolic enzyme levels, which controls metabolic state.

The cell is not "running a program." The cell is **continuously rewriting its own program while executing it**.

### 3.3 Extended Corollaries

#### Differentiation = Macro Expansion
Stem cell → neuron is not "executing preset code." It is a **series of macro expansions**: epigenetic enzymes (macros) read the current chromatin state (the program), modify it, and produce a new state that enables the next round of macro expansion. Each differentiation step is a compile-time transformation.

#### Reprogramming = Macro Injection
Cellular reprogramming (e.g., Yamanaka factors) is not "overwriting the program." It is **injecting new macros** that force the cell to re-expand from a different point. The exogenous transcription factors are macro definitions; the cell's endogenous metabolic machinery must supply the α-KG fuel for the epigenetic enzymes to execute them.

#### IDH-Mutant Tumor = Poisoned Macro
2-HG is a **malicious macro**—it hijacks the epigenetic interpreter by competitive inhibition. It doesn't corrupt the genome (the source code is intact); it corrupts the **compiler** (TET/JmjC). Normal differentiation macros are submitted but silently fail to expand. The cell is trapped in an unexpanded state.

#### Warburg Effect = Lisp to BASIC Degradation
The Warburg effect—tumor cells abandoning oxidative phosphorylation for aerobic glycolysis—is, in Lisp terms, **abandoning homoiconicity for static compilation**.

- **TCA cycle (Lisp):** Powerful, self-modifying, meta-programmable—but requires maintaining the interpreter (mitochondria), the macro system (epigenetic enzymes), and the feedback loops (α-KG signaling). High overhead, high capability.
- **Glycolysis (BASIC):** Simple, fast, linear execution. No meta-programming. No self-modification. No interpreter overhead. Raw execution speed at the cost of **surrendering the power to rewrite one's own program**.

The tumor chooses **metabolic slavery**—static compilation in exchange for raw proliferation speed. It trades the ability to adapt its program for the ability to execute its current program faster.

> *Warburg is not a bug. It is a strategic downgrade—from a self-modifying system to a hardcoded one. The tumor gains speed and loses its soul.*

---

## Part IV: SoMe Design Implementation

### 4.1 Three-Tier Metabolic Resource Architecture

The metabolic system in SoMe operates as a three-layer abstraction stack, mirroring the architecture of a programming language runtime:

```
┌─────────────────────────────────────────────────────────────┐
│  TIER 3: APPLICATION LAYER                                  │
│  Cell-type-specific compilation outputs                     │
│  ─────────────────────────────────────────────────────────  │
│  • Neurons → compile α-KG into Glutamate / GABA            │
│  • Immune cells → compile arginine / NO from α-KG pool     │
│  • Tumor cells → hijack compiler, output 2-HG              │
│  • Astrocytes → compile glutamine for neuron support       │
├─────────────────────────────────────────────────────────────┤
│  TIER 2: BYTECODE LAYER                                     │
│  Universal intermediate resources                           │
│  ─────────────────────────────────────────────────────────  │
│  • α-Ketoglutarate (5C) — primary data/code carrier        │
│  • Oxaloacetate (4C) — aspartate-family router             │
│  • Pyruvate (3C) — alanine-family router + glycolysis link │
│  • Routing decisions = "which compiler receives fuel"      │
├─────────────────────────────────────────────────────────────┤
│  TIER 1: ASSEMBLY LAYER                                     │
│  TCA cycle — autonomous energy engine                       │
│  ─────────────────────────────────────────────────────────  │
│  • Runs automatically (like a kernel daemon)               │
│  • Consumes Acetyl-CoA + OAA → produces ATP + 3 α-keto acids│
│  • Outputs feed Tier 2 (the "instruction set")             │
│  • α-KG output simultaneously feeds back to Tier 3 control │
└─────────────────────────────────────────────────────────────┘
```

### 4.2 Layer Details

#### Tier 1 — Assembly: The TCA Cycle
The TCA cycle is the **autonomous energy engine**—the kernel daemon that runs without player intervention. It consumes Acetyl-CoA (from glycolysis or β-oxidation) and oxaloacetate, and outputs:
- **ATP** (via substrate-level and oxidative phosphorylation)
- **Three α-keto acids** as metabolic "instructions": pyruvate (via anaplerotic refill), OAA (the carrier), and α-KG (the key intermediate)

This layer is **always running**. Its throughput is determined by substrate availability, oxygen supply, and enzyme integrity. In SoMe, disrupting Tier 1 (e.g., ischemia, mitochondrial toxins) is equivalent to **kernel panic**—all higher layers lose their foundation.

#### Tier 2 — Bytecode: The α-Keto Acid Pool
The three α-keto acids are **universal intermediate resources** that can be routed to different cell-type-specific "compilers." This is the player's primary lever:

- **Routing α-KG to TCA oxidation** → energy production (eval)
- **Routing α-KG to TET/JmjC** → epigenetic reprogramming (quote)
- **Routing OAA to aspartate synthesis** → nucleotide biosynthesis, immune function
- **Routing pyruvate to lactate** → Warburg mode (speed, but no reprogramming capability)

**Player action:** Adjusting the routing ratios of α-keto acids is the metabolic equivalent of **process scheduling** in an operating system. The player allocates metabolic bandwidth between energy production, biosynthesis, and epigenetic control.

#### Tier 3 — Application: Cell-Type Compilation
Different cell types act as different **compilers** that transform the shared bytecode into cell-specific outputs:

| Cell Type | Input | Output | SoMe Function |
|---|---|---|---|
| **Neuron** | α-KG | Glutamate (neurotransmitter), GABA | Signal transmission, synaptic combat |
| **Astrocyte** | α-KG | Glutamine (neuron support) | Logistics, repair |
| **Immune cell** | α-KG → arginine pathway | Nitric oxide (NO) | Cytotoxic attack |
| **Tumor (IDH-mutant)** | α-KG | **2-HG** (toxic metabolite) | Epigenetic freezing weapon |
| **Tumor (Warburg)** | Pyruvate | Lactate | Acidification, speed boost, no reprogramming |
| **Reprogramming target** | α-KG → TET | Demethylated genome | Cell identity rewrite |

### 4.3 Player Mechanics: Metabolic Process Scheduling

The core gameplay implication: **metabolism is not background—it is an actionable strategy layer.**

Players influence the battlefield by modulating α-KG allocation routes, analogous to an OS process scheduler:

1. **Starvation tactics:** Cut glucose supply → TCA throughput drops → α-KG pool shrinks → enemy cells lose both energy and epigenetic flexibility
2. **Reprogramming fuel:** Allocate α-KG to TET enzymes → unlock differentiation macros → convert tumor cells or reprogram glia to neurons
3. **Anti-Warburg:** Force tumor cells back into oxidative phosphorylation → restore homoiconicity → make them vulnerable to epigenetic intervention
4. **IDH counter:** Block 2-HG production (IDH inhibitor) or supply exogenous α-KG → restore TET function → unfreeze the epigenetic interpreter
5. **Compartment manipulation:** Disrupt mitochondrial membrane potential → release α-KG from matrix to cytosol → shift from "eval" mode to "quote" mode

### 4.4 Design Philosophy

The homoiconicity framework elevates SoMe's metabolic system from "flavor text" to **the deepest strategic layer** in the game:

- **Shallow layer (combat):** Cell A attacks Cell B with cytokines
- **Middle layer (signaling):** Player manipulates signaling pathways to alter cell behavior
- **Deep layer (metabolic):** Player controls the **allocation of self-modification capability itself**—who can rewrite their program, who is frozen, who has degraded to static execution

This creates a unique gameplay depth: the player is not merely commanding units, but **managing the computational substrate** on which all units run. The TCA cycle is the kernel; α-KG is the universal token; epigenetic enzymes are the macro system. Victory comes not from overwhelming force, but from **controlling the interpreter**.

---

## Part V: Narrative Integration

### 5.1 Worldbuilding Implications

The homoiconicity framework provides SoMe with a scientific foundation for several core narrative themes:

1. **"The engine predates the civilization."** The TCA cycle is not a biological invention but a chemical inevitability. Life did not create metabolism; metabolism created life. This reframes the entire SoMe universe: the "characters" are not autonomous agents but emergent programs running on a four-billion-year-old interpreter.

2. **"Cells don't run programs—they rewrite them."** Every cell in the SoMe universe is continuously recompiling itself. Differentiation, adaptation, and disease are all instances of macro expansion, macro injection, or interpreter corruption.

3. **"The tumor chose slavery."** The Warburg effect is a philosophical choice: the tumor trades the freedom of self-modification for the speed of hardcoded execution. This is not a malfunction but a **strategic surrender**—a Faustian bargain at the molecular level.

4. **"2-HG is a poisoned macro."** IDH-mutant tumors don't corrupt the genome; they corrupt the compiler. The source code is intact, but the interpreter silently refuses to run. This is a more insidious form of warfare than DNA damage—it is **epistemic corruption**.

### 5.2 Character & Faction Design Hooks

- **Ischemia faction:** Represents interpreter crash—the system loses both eval and quote. Cells in the ischemic core are frozen programs, unable to execute or self-modify.
- **Penumbra zone:** The system is degraded but recoverable. α-KG is low but not zero; some macros can still expand if fuel is supplied in time.
- **Reprogramming Engineers (players):** Operate by injecting macros and supplying α-KG fuel. Their power is fundamentally about **controlling the compile chain**, not direct combat.
- **Tumor factions:** Two strategic archetypes—Warburg (speed, no flexibility) and IDH-mutant (frozen interpreter, poison macro). Each requires different counter-strategies.
- **Mitochondria as kernel:** The organelle is the runtime environment. Mitochondrial dysfunction = kernel instability. Everything above it becomes unreliable.

---

## Appendix A: Scientific References

| Concept | Key Reference |
|---|---|
| Morowitz thermodynamic inevitality | Morowitz, H.J. (1992). *Beginnings of Cellular Life*. Yale University Press. |
| rTCA as prebiotic pathway | Smith, E. & Morowitz, H.J. (2004). Universality in intermediary metabolism. *PNAS*, 101(36), 13168–13173. |
| α-KG as TET/JmjC cofactor | Loenarz, C. & Schofield, C.J. (2008). Expanding chemical biology of 2-oxoglutarate oxygenases. *Nat. Chem. Biol.*, 4, 152–156. |
| 2-HG as competitive inhibitor | Xu, W. et al. (2011). Oncometabolite 2-hydroxyglutarate is a competitive inhibitor of α-ketoglutarate-dependent dioxygenases. *Cancer Cell*, 19(1), 17–30. |
| Warburg effect | Warburg, O. (1956). On the origin of cancer cells. *Science*, 123(3191), 309–314. |
| Lisp homoiconicity | McCarthy, J. (1960). Recursive functions of symbolic expressions and their computation by machine, Part I. *Comm. ACM*, 3(4), 184–195. |
| Mitochondrial endosymbiosis | Sagan, L. (1967). On the origin of mitosing cells. *J. Theor. Biol.*, 14(3), 225–274. |

---

## Appendix B: Glossary

| Term | Definition |
|---|---|
| **Homoiconicity** | A property of programming languages where the primary representation of programs is also a primitive data structure of the language. Code is data. |
| **α-Keto acid** | A carboxylic acid with a ketone group adjacent to the carboxyl group. The most chemically versatile small carboxylic acid class. |
| **TCA cycle** | Tricarboxylic acid cycle (Krebs cycle). The central metabolic pathway oxidizing acetyl-CoA to CO₂ and reducing equivalents. |
| **rTCA** | Reductive TCA cycle. The reverse-direction variant that fixes CO₂ into organic molecules. Hypothesized prebiotic pathway. |
| **TET enzymes** | Ten-Eleven Translocation dioxygenases. α-KG-dependent enzymes that catalyze DNA demethylation. |
| **JmjC demethylases** | Jumonji domain-containing histone demethylases. α-KG-dependent enzymes that remove histone methylation. |
| **2-HG** | 2-Hydroxyglutarate. An oncometabolite produced by mutant IDH enzymes; competitive inhibitor of α-KG-dependent dioxygenases. |
| **Warburg effect** | The observation that cancer cells preferentially use glycolysis even in the presence of oxygen. |
| **S-expression** | Symbolic expression. The fundamental data structure of Lisp, which is also its code representation. |
| **Macro** | In Lisp, a code-generating construct—a program that writes programs. |

---

*Document Status: Canonical*
*Maintained by: SoMe Design Team*
*Origin: 2026-07-08 主对话深度讨论（凌晨 01:35–01:48，三轮对话）*
*Classification: Foundational Worldbuilding — Metabolic Architecture*
