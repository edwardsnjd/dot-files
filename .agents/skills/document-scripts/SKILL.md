---
name: document-scripts
description: Ensure the local-bin scripts are documented in README
---
# Documenting "local-bin" scripts

## When to use this skill

Use this skill whenever the local-bin scripts have changed, or just to check the docs are correct.

## What to ensure

Ensure that every main executable script under `configuration/local-bin/.local/bin/` is documented in `configuration/local-bin/README.md`. There are some libraries in that directory but only the top level executable scripts should be documented.

## How to check

1. List all the scripts under `configuration/local-bin/.local/bin/` (ignore file extensions, most use a shebang)
2. Read `configuration/local-bin/README.md`
3. Check that all the scripts are mentioned in the readme.
4. Check that all the scripts have a reasonable description and example.

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
