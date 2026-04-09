---
name: subagent
description: Delegate a task to a new subagent so you can focus on coordination
---

# Delegating to a subagent

## When to use this skill

- Instructed to delegate
- Task has clear boundaries (e.g. "read these 3 files")
- Task needs isolation (e.g. "summarise this file")
- You can pass all required context explicitly
- You have a constrained, specific objective

## When NOT to use this skill

- **Analyzing your sessions/logs** — Read files directly
- **Batch processing** — Use iterative workflow instead
- **"Figure out what to do"** — If you don't know, neither will they

## Critical: Zero context

Subagents see **nothing** from your session. You must pass:
- Prior findings
- File paths to examine
- Explicit goals

## Anti-patterns

- ❌ "Process all scripts" — Do ONE
- ❌ Pass file contents in prompt — Use @file references
- ❌ Don't validate responses — Check for errors
- ❌ Delegate the delegation — Coordinate yourself
- ❌ "Figure it out" — You already know the task

## Size limits

Keep prompts under **~1KB**:
- 1 specific task, not "process all items"
- File paths, not file contents
- 1-5 files to examine

## How to delegate

1. Break into tiny tasks (one at a time)
2. Write prompt with Goal, Files, Scope
3. Run `pi --print <<-'EOF'` with your prompt
4. Check response for errors
5. On failure: retry once with simpler scope, or handle manually

## Iterative workflow

For many items, process one at a time:

```bash
pi --print <<-'EOF'
Analyze: abn
File: configuration/local-bin/.local/bin/abn
Goal: Add to README if missing
EOF

# Check result. If failed:
# - Retry with narrower scope, OR
# - Handle manually
```

## Minimal prompt template

```
**Goal:** {what to do}

**Files:**
- {path}: {why}

**Scope:** {do this, not that}
```

## Examples

**Find something**
```bash
pi --print <<-'EOF'
Find all calls to fooBar() in the codebase.
Return a list grouped by file.
EOF
```

**Write something**
```bash
pi --print <<-'EOF'
Write an email validator function:
- Check format (user@domain.tld)
- Return true/false
EOF
```

**Investigate with context**
```bash
pi --print <<-'EOF'
You are debugging the auth module.

**Goal:** Find why login fails for users with 2FA.

**Prior:** User reports "works without 2FA, fails with it".

**Files:**
- auth/login.js: main login logic
- auth/totp.js: 2FA handling

**Scope:** Focus on 2FA code path only.

**Output:** List of potential causes ranked by likelihood.
EOF
```
