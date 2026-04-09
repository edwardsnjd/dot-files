---
name: subagent
description: Delegate a task to a new subagent so you can focus on coordination
---

# Delegating to a subagent

## When to use this skill

Use this when:

- Instructed to delegate something
- Task has well-defined boundaries (e.g. "read these 3 files")
- Task needs to be isolated from other work (e.g. "summarise this very long file")
- You explicitly pass all required context
- You have a clear, constrained objective

## How to delegate to a subagent

1. **Break down complex tasks into a sequence of small tasks**
   - Act as a coordinator, and plan out a sequence of small tasks
   - IMPORTANT: Use a subagent to help you break down the tasks!
   - Break down any complex tasks into small tasks
   - IMPORTANT: Only ask subagents to perform small targeted tasks, DO NOT just pass your entire complex task to a subagent

2. **Be clear about what needs to be done**
   - State the goal explicitly
   - Include any relevant context
   - Specify any constraints or requirements

3. **Specify the scope**
   - What files to touch or create
   - What behavior to implement
   - What not to do (out of scope)

4. **Define acceptance criteria**
   - How to verify the task is complete
   - What tests or checks should pass

5. **Start the agent and wait for its response**
   - Run the bash command: `pi --print PROMPT`
   - Where `PROMPT` completely describes the task to perform, and all required context
      - Use bash heredoc with quoted delimiter for multiline prompts
   - Pass ALL required context explicitly (subagents get zero context) in `PROMPT`
   - The response of that command on stdout is the subagent's response

## Critical: Prompt contains all context

**Known Issue**: Subagents spawn with zero context. Each subagent cannot see:
- Previous tool calls made by you
- Files read by other subagents
- Prior conclusions or findings
- Any context not explicitly passed in the prompt

**Required Workaround**: You must explicitly include in each subagent invocation:
1. A "Prior Context" section with all previous findings
2. Current project structure and key file paths
3. Relevant code snippets (imports, method signatures)
4. List of specific files the subagent should read

## Examples

**Generate a snippet of code**

```bash
pi --print <<-'EOF'
Write a JS function that validates email addresses. It should:
- Check for proper format (user@domain.tld)
- Reject empty strings
- Return true/false
EOF
```

**Investigate something small**

```bash
pi --print <<-'EOF'
Look for all usages of the function fooBar(...).
Return the callgraph as a nested markdown list for ease of reading.
EOF
```

**Complex investigation with context**

```bash
pi --print <<-'EOF'
You are a Field Investigator analyzing the {component} in {project}.

**Prior Context:**
- Previous investigation found: {list key findings}
- Related files: {list of prior discovered files}

**Files to Examine:**
- {file1}: {why}
- {file2}: {why}

**Your Task:**
{specific, constrained objective}

**Constraints:**
- Only look at: {allowed scope}
- Do NOT explore: {forbidden scope}

**Output:**
{specific format required}
EOF
```
