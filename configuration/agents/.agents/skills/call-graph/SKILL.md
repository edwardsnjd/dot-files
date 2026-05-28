---
name: call-graph
description: Builds a Graphviz .dot call-dependency graph from source files, grouped by declarations (file/interface/class/object) with visibility-aware styling and a legend.
---

# Call Graph Skill

Generate a **function call dependency graph** as Graphviz `.dot` for one or more source files.

## When to use

- User asks for call dependencies, call paths, or function relationship visualization.
- User wants architecture visibility by declaration scope (file/interface/class/object).
- User wants overload-aware and visibility-aware diagrams.

## Output contract

1. Output is a valid Graphviz `digraph`.
2. Every declared function gets its own node.
3. Every overload gets a separate node (distinguish by full signature).
4. Local/nested functions get their own nodes (qualified by parent function when useful).
5. Constructor dependencies get their own container, with a node for each of their called functions
6. Group containers should be declaration-based:
   - `file <Name>`
   - `interface <Name>`
   - `class <Name>` (or `data class`, `inner class` as applicable)
   - `object <Name>`
   - `companion object`
   - `dependency <Name>`
7. Do **not** create an extra “top-level functions” box; top-level functions are implicitly in the file container.
8. Visibility coloring is relative to the containing declaration:
   - **public/exposed** member: `palegreen`
   - **private/internal implementation**: `mistyrose`
   - **dependency functions**: `lightgray`
9. Include a dedicated legend box with:
   - one sample node of each color
   - one labeled solid arrow example (`calls`)
   - one labeled dashed arrow example (`implemented by`)

       http://www.catb.org/~esr/writings/cathedral-bazaar/cathedral-bazaar/

## Edge conventions

- **Solid edge**: function `A` directly calls function `B`.
- **Dashed edge**: declaration contract relation (e.g., interface method to implementation).
- Label legend arrows so readers can decode edge semantics quickly (but don't usually label call edges to avoid visual clutter).

## Process

1. Parse declarations in target file(s): interfaces, classes, objects, companion objects, top-level funcs, dependencies.
2. Enumerate all function declarations, including overloads and local functions.
3. Build nodes with full signatures to avoid overload ambiguity.
4. Build edges from function bodies for intra-file direct calls.
5. Add contract edges (interface -> implementation) when visible in scope.
6. Organize nodes into nested clusters that mirror declaration nesting.
7. Apply visibility coloring and add legend cluster.
8. Sanity-check: no missing declarations, no merged overloads, no orphaned legend.

## Naming and labeling rules

- Prefer concise but disambiguating signatures:
  - `findExamsBy(key: EncounterKey)`
  - `findExamsBy(keys: List<EncounterKey>)`
- Local functions can be parent-qualified:
  - `checkExamsMatch::total(e: ByEncounter<Exam>)`
- Avoid redundant wording like “nested” in labels when nesting is already visual.
