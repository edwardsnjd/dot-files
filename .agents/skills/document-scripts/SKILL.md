---
name: document-scripts
description: Ensure the local-bin scripts are documented in README
---
# Documenting "local-bin" scripts

## When to use this skill

Use this skill whenever the local-bin scripts have changed, or just to check the docs are correct.

## What to ensure

Ensure that every main executable script under `configuration/local-bin/.local/bin/` is documented in `configuration/local-bin/README.md`.

## How to check

Check for any missing headings in the README (but use judgement to ignore any libraries).  Use the scripts to avoid reinventing the logic:

1. Run the validation script (relative to this skill): `scripts/find-missing-headings`
2. For each missing heading that looks like a script:
    1. Find the corresponding script
    2. Read it
    3. Add its documentation section to the README (see below for template)

Note:
- Most scripts have no file extension.
- There are some libraries in that directory but only the top level executable scripts should be documented.

## Available scripts (relative to this file)

- **`scripts/find-missing-headings`** — Lists any missing headings (no output means no missing headings)

## Format of documentation

- The scripts should be grouped by purpose.  Each group has a second level markdown heading.
- Each script should have:
    - a third level markdown heading
    - a short sentence describing its behaviour
    - an example of how to invoke it

## Template for documentation

```
## {GROUP NAME}

### {SCRIPT NAME}

{SCRIPT DESCRIPTION}.

Example: `{SCRIPT INVOCATION WITH ARGUMENTS}`
```
