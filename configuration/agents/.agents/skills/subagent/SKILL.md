---
name: subagent
description: Delegate a clear task to a subagent
---

# Delegating to a subagent

## When to use this skill

Use this skill when you have a well-defined task that doesn't require all your context OR when you are explicitly asked to delegate.

## How to delegate to a subagent

1. **Be clear about what needs to be done**
   - State the goal explicitly
   - Include any relevant context
   - Specify any constraints or requirements

2. **Specify the scope**
   - What files to touch or create
   - What behavior to implement
   - What not to do (out of scope)

3. **Define acceptance criteria**
   - How to verify the task is complete
   - What tests or checks should pass

4. **Start the agent and wait for it's response**
   - Run a bash command like: `pi --print PROMPT`
   - Where PROMPT has all the required context
      - Use bash heredoc with quoted delimiter for multiline
   - The response of that command on stdout is the subagent's response

## Example

**Generate a snippet of code**

`pi --print <<-'PROMPT'
Write a JS function that validates email addresses. It should:
- Check for proper format (user@domain.tld)
- Reject empty strings
- Return true/false
PROMPT`

**Investigate something small**

`pi --print <<-'PROMPT'
Look for all usages of the function fooBar(...).
Return the callgraph as a nested markdown list for ease of reading.
PROMPT`
