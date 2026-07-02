---
name: delegating
description: Delegate a task to a subagent so you can focus on coordination
---
Spawn yourself as a sub-agent via bash to perform a task: $@

# Delegating to a subagent

## When to use this skill

- Instructed to delegate
- Task has clear boundaries (e.g. "read these 3 files")
- Task needs isolation (e.g. "summarise this file")
- You can pass all required context explicitly
- You have a constrained, specific objective

## How to delegate

1. Identify a tiny task that can be completed quickly
2. Write prompt with Goal, Files, Scope
3. Run `pi --print` with appropriate arguments:
  - If the user specifies a model, use `--provider` and `--model` accordingly
  - Add a large, pessimistic `timeout` since the subagent might take a long time (e.g. 5 minutes or longer)
4. Check response for errors
5. On failure: retry once with simpler scope, or stop and give up

## Critical: Zero context

Subagents see **nothing** from your session. You must pass:
- Prior findings
- File paths to examine
- Explicit goals

## Anti-patterns

- ❌ Don't delegate a task too large for a single agent to quickly complete - Break it into smaller tasks
- ❌ Don't pass file contents in prompt — Use @file references instead
- ❌ Don't ask for a batch of work - Iterate over tasks individually
- ❌ Don't delegate the delegation — Coordinate yourself instead

## Size limits

Keep prompts under **~1KB**:
- 1 specific task, not "process all items"
- File paths, not file contents

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
