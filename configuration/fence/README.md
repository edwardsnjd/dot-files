# Fence Sandbox Configuration

[Fence](https://github.com/fencesandbox/fence) is a macOS application sandboxing tool
that restricts filesystem and network access for applications.

This directory contains Fence profiles for various tools:

| Profile | Purpose |
|---------|---------|
| `fence.jsonc` | Base profile — code-strict template, core sandbox for coding tools (Copilot, pi agent, git, LLM) |
| `fence-podman.jsonc` | Podman — extends base, allows localhost for Podman socket |
| `fence-nb.jsonc` | Note-taking — extends base, allows Workflowy and notes directory read/write |
| `fence-web-research.jsonc` | Web research — extends base, allows all outbound connections for web-search and web-fetch |

**Key resources:**
- Fence project: <https://github.com/fencesandbox/fence>
- JSON Schema: <https://raw.githubusercontent.com/Use-Tusk/fence/main/docs/schema/fence.schema.json>
- Code template: <https://github.com/Use-Tusk/fence/blob/main/internal/templates/code.json>
- Code-strict template: <https://github.com/Use-Tusk/fence/blob/main/internal/templates/code-strict.json>