# Contributing

This repository contains configuration files (dotfiles) and a collection of utility scripts.  The following guidelines aim to maintain consistency and reliability across different environments.

## 🛠 Build, Lint, and Test

### Shell Scripts (Bash)
- **Linting**: Use `shellcheck` for all shell scripts. It is the primary tool for catching common errors and ensuring best practices.
  ```bash
  shellcheck configuration/local-bin/.local/bin/<script>
  ```
- **Testing**:
  - Many scripts (e.g., `pie-bar`, `pie-column`) have internal tests triggered by the `--test` flag.
    ```bash
    ./configuration/local-bin/.local/bin/<script> --test
    ```
  - These internal tests use `shunit2`. Ensure `shunit2` is available in your PATH.
  - Test functions should follow the `testName` convention and use `assertEquals`, `assertNotEquals`, etc.
- **Verification**: Always verify CLI utilities by running them with sample input. Use redirection and pipes to test common usage patterns.

### Development Tools & Dependencies
- Common dependencies include: `git`, `sed`, `awk`, `grep`, `jq`, `tokei`, `fzf`, `bat`, `curl`.
- When a dependency is missing, prefer alerting the user or checking for it in the script's `DEPENDENCIES` section.

## 🎨 Code Style Guidelines

### General Principles
- **Indentation**: Use **2 spaces** for all file types (Bash, JS, JSON, VimL, etc.).
- **Consistency**: Mimic the style of surrounding code. Check existing scripts in `configuration/local-bin/.local/bin/` for reference.

### Bash Scripting (The Core of this Repo)
- **Shebang**: Use `#!/usr/bin/env bash` for maximum portability.
- **Strict Mode**: Every script should start with:
  ```bash
  set -o nounset  # Treat unset variables as an error
  set -o errexit   # Exit immediately if a command exits with a non-zero status
  set -o pipefail  # The return value of a pipeline is the status of the last command to exit with a non-zero status
  ```
- **Structure**:
  1. **Documentation Header**: (See below)
  2. **Strict Mode**
  3. **Main Function**: Use `function Main() { ... }`.
  4. **Implementation Functions**: Descriptive names in `UpperCamelCase`.
  5. **Utility Functions**: Small helpers.
  6. **Call Main**: `Main "$@"` should be the last line.
- **Documentation Header**: Use a standardized block with the following sections (as required):
  - `NAME`: Name and headline.
  - `SYNOPSIS`: Quick syntax reference.
  - `USAGE`: Detailed command-line patterns.
  - `OPTIONS`: Flag and parameter explanations.
  - `DEPENDENCIES`: List of external tools.
  - `ENVIRONMENT`: Any required or optional environment variables.
  - `EXAMPLE`: Clear usage examples.
- **Help Generation**: Use the `UsageSedScript` pattern found in `largest-outline.sh` to parse and display the header as help text.
- **Section Extraction**: Large scripts often embed secondary logic (AWK scripts, JQ filters) in a commented section at the bottom. Use the `GetSection` helper function with `sed` to extract these sections at runtime.
- **Variable Scope**: Always use `local` for variables within functions to avoid namespace pollution.
- **Conditionals**: Prefer `[[ ... ]]` over `[ ... ]`. Use `[[ -z $var ]]` for empty checks.
- **Argument Parsing**: Use a `while` loop with `case` for flag parsing in the `Main` or specific command functions.
- **Piping & Redirection**: Prefer pipes for data flow. Use `process substitution` (e.g., `<(command)`) instead of temporary files where possible.
- **Common Tools**:
  - `awk`: Use for field extraction and simple calculations.
  - `sed`: Use for line manipulation and text replacement.
  - `jq`: Use for all JSON processing.
  - `fzf`: Use for interactive selection interfaces.

### JavaScript / Node.js
- **Imports**: Use ESM `import`/`export`.
- **Naming**: `camelCase` for functions and variables. `SCREAMING_SNAKE_CASE` for global constants.
- **Environment**: Use `#! /usr/bin/env node`.

### Vim Configuration
- Maintain the 2-space indentation.
- Group settings logically (Buffers, Search, Tabs, etc.).
- Use `plugin/` for logic and `after/compiler/` for compiler-specific settings.

## 💾 Git & Commit Standards
- **Conventional Commits**: Use clear prefixes:
  - `feat:` for new scripts or features.
  - `fix:` for bug fixes.
  - `docs:` for README or header updates.
  - `chore:` for maintenance or bumping versions.
- **Commit Logic**:
    - Group related changes (e.g., a script change and its README update) into a single commit.
    - Aim for small, atomic commits.

## 📂 Repository Layout
- `configuration/`: The heart of the repo, containing configs for almost every tool (Alacritty, Bash, Git, Tmux, Vim, etc.).
- `configuration/local-bin/.local/bin/`: This is where utility scripts live. Adding a script here usually requires adding it to the `README.md` in `configuration/local-bin/`.
- `tools/`: Installation scripts for system-wide tool setups.

## 🤝 Interaction with this Repository
- **Exploration**: Before creating a new script, search `configuration/local-bin/.local/bin/` to see if a similar utility already exists.
- **Readability**: Keep scripts focused and modular. If a script grows too large, break it into functions.
- **Documentation**: Update the central `README.md` at `configuration/local-bin/README.md` whenever adding or renaming scripts.
