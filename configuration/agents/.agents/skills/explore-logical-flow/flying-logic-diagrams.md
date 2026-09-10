# Flying Logic: Diagram Types and Visual Semantics

## Core premise

Flying Logic is a graph-based visual-thinking tool, principally designed to support the Theory of Constraints (TOC) Thinking Processes. Its central claim is that complex problems, proposed changes, conflicts, and plans can be made reviewable by recording them as explicit, testable networks of cause and effect rather than as prose or manually laid-out diagrams.

A diagram contains **entities** (rectangular statements about reality), **edges** (directed arrows), optional **junctors** (operator circles such as AND/OR), and **groups** (visual containers). An entity’s coloured header denotes its **class**, i.e. its role in the current diagram type. Flying Logic automatically lays out the graph; the author models the logic.

### Arrow semantics

| Reasoning mode | Arrow direction and reading | Combination semantics |
|---|---|---|
| **Sufficient Cause** | `A → B` reads: “If A, then B”; A is sufficient to cause B. | Multiple direct arrows into B mean **OR**: either (or both) incoming causes can cause B. An **AND junctor** means the joined causes must occur together to cause the effect. |
| **Necessary Condition** | `A → B` is read *against* the visual arrow direction: “In order to obtain B, A is necessary.” Equivalently: “If not A, then not B.” | The entity operator is normally **AND**: multiple predecessor conditions are jointly required. An **OR junctor** represents alternative ways to supply a necessary condition. |

A **back edge** is a thicker arrow used to show a causal feedback loop (e.g. a vicious or virtuous circle). It documents the relationship but is excluded from Flying Logic’s confidence/weight calculation.

## Typical TOC workflow

A typical TOC workflow is: **CRT** (identify the core problem) → **Cloud** (find a win-win injection) → **FRT** (validate its effects and prevent harm) → **PRT** (find missing prerequisites) → **TRT** (sequence execution). An S&T Tree is the more comprehensive organisation-scale mechanism for tying strategy to justified tactics.

> Example: In an engineering delivery context, a CRT might connect “review queue grows” and “production incidents recur” to a shared driver such as “changes bypass a stable integration gate.” A Cloud can surface the conflict between “ship immediately” and “require verification”; an FRT tests a proposed automated gate; a PRT identifies prerequisites such as reproducible environments and test ownership; and a TRT sequences the actual implementation work.

## Current Reality Tree (CRT)

**Purpose:** Find what to change: trace a set of undesirable symptoms back to the most influential common root cause—the system constraint or **Core Driver**. It is usually drawn bottom-to-top, from root causes to symptoms.

**Reasoning:** Sufficient Cause. Arrows run **cause → effect** and read “If cause, then effect.” Incoming direct arrows are alternative independent causes (OR); use an AND junctor when several causes are jointly necessary for an effect.

**Entity classes:**

- **Un-Desirable Effect (UDE):** A condition the system would clearly be better without; usually the presenting symptom.
- **Precondition:** A neutral, external fact or contextual condition beyond significant control; a root cause with successors and no predecessors.
- **Action:** A neutral controllable cause; has successors and no predecessors.
- **Intermediate Effect:** A neutral causal consequence; normally has both predecessors and successors.
- **Desirable Effect (optional):** Used when analysing a core strength rather than a problem.

## Evaporating Cloud / Conflict Resolution Diagram

**Purpose:** Resolve an apparent conflict without settling for a zero-sum outcome or compromise. It separates two incompatible **Wants** (positions) from the legitimate **Needs** and shared **Common Objective** behind them, then tests the assumptions that make the conflict appear unavoidable.

**Reasoning:** Necessary Condition. The Cloud is conventionally read left-to-right, while arrows point right-to-left toward the Common Objective: “In order to satisfy the need, we must obtain the want.” One of the two arrows from **Conflict** to a Want is negated (red), modelling mutual exclusivity. An inserted solution uses an OR junctor to provide an alternative route.

**Entity classes:**

- **Want:** A chosen position or action each side seeks; the two Wants appear mutually exclusive.
- **Need:** The underlying requirement each Want is intended to satisfy.
- **Common Objective:** The higher-level shared outcome for which both Needs are necessary.
- **Conflict:** The condition expressing why both Wants cannot simultaneously be obtained.
- **Solution:** An injection/option for mutual gain that breaks a dependency or the perceived conflict.

## Future Reality Tree (FRT)

**Purpose:** Test what to change *to*: model a proposed solution’s intended causal path to desired outcomes, expose unwanted side effects, and add mitigating or alternative actions. It is normally drawn bottom-to-top, from injections to outcomes.

**Reasoning:** Sufficient Cause. Arrows run **cause → consequence**, read “If A, then B,” and use the same OR-by-multiple-incoming-arrows / AND-junctor convention as the CRT. Back edges can represent deliberate positive reinforcing loops. A **negative branch** is a causal path from an injection to a UDE and is either prevented proactively or mitigated reactively.

**Entity classes:**

- **Solution:** The initial proposed injection, often imported from an Evaporating Cloud.
- **Action:** An additional controllable intervention required to complete or protect the solution path.
- **Precondition:** A fact of the existing environment that must hold.
- **Intermediate Effect:** A neutral predicted consequence.
- **Desirable Effect (DE):** A positive intended outcome.
- **Un-Desirable Effect (UDE):** A predicted adverse consequence to avoid or mitigate.
- **Need / Common Objective (optional):** May be carried over from a Cloud to show why the solution matters.

## Prerequisite Tree (PRT)

**Purpose:** Determine how to cause a chosen change by identifying the obstacles that must be removed and the milestones that overcome them. The root milestones become the work that must start first.

**Reasoning:** Necessary Condition. Usually read top-to-bottom from the Objective while arrows point bottom-to-top. Read each relation as: “In order to obtain A, it is necessary to overcome B,” or “In order to overcome B, it is necessary to obtain C.” Multiple milestones can be jointly necessary; OR junctors express alternative milestones.

**Entity classes:**

- **Objective:** The outcome to achieve; normally the terminal/top entity.
- **Overcome:** A necessary condition currently absent—worded as an obstacle already overcome. `True` means the obstacle no longer blocks progress.
- **Milestone:** An accomplishment that overcomes an obstacle; lower-level/root milestones are the earliest actionable achievements.

## Transition Tree (TRT)

**Purpose:** Turn goals or PRT milestones into an executable, ordered causal plan—everything required to make the goal true, not merely the things currently missing.

**Reasoning:** Sufficient Cause. Arrows run **cause/action → effect/next state** and read “If A, then B.” AND junctors capture prerequisites that must coexist before an action is eligible; multiple direct incoming causes are OR alternatives.

**Entity classes:**

- **Goal:** A target state or end condition.
- **Action:** A controllable step in the execution sequence.
- **Precondition:** A relevant existing condition outside the planner’s control.
- **Intermediate Effect:** A neutral state produced en route to the goal.
- **Desirable Effect (optional):** A positive collateral benefit.
- **Un-Desirable Effect (optional):** An unavoidable adverse effect later steps must address.

## Strategy & Tactics Tree (S&T)

**Purpose:** Convert a highest-level organisational goal into a multi-level, justified implementation hierarchy. Each level connects why an outcome matters to how it will be realised, down to fundamental actions.

**Reasoning:** Necessary-condition-oriented dependency hierarchy. It is normally read top-to-bottom from the highest Strategy, while arrows point bottom-to-top toward it. A Strategy has one implementing Tactic; a Tactic may decompose into two or more subordinate Strategies. Alternative tactics can be represented with OR relationships.

**Entity classes:**

- **Strategy:** The “why”: a goal or justification for a step. The highest Strategy is the system goal.
- **Tactic:** The “how”: the implementation for its parent Strategy. A complete tree ends in fundamental Tactics.
- **Necessary:** Why the Tactic must be implemented to achieve its parent Strategy.
- **Sufficient:** Why the Tactic will work to achieve its parent Strategy.
- **Parallel:** A “parallel assumption” addressing objections outside necessity/sufficiency, such as whether the Strategy already exists or the Tactic is feasible.

Together, the five classes form one justified **Step**.

## Other built-in diagram domains

Flying Logic also supports non-TOC graph domains. For example, the **Flowchart** domain uses **Begin**, **Operation**, **Decision**, **Input**, **Output**, and **End** entities; arrows represent process flow, decision branches can be labelled, and back arrows can represent loops. The tool’s general graph model can also be used for concept maps, evidence-based analysis, roadmaps, and other relationship networks.
