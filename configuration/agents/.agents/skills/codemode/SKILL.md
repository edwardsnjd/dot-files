---
name: codemode
description: Leverage your codemode tool if it's available
---

When you have the `codemode` tool available, remember that it's an isolated JS sandbox.  You can only use provided tools.  You can't import/require any new dependencies.

Inspect the `ALL_TOOLS` JS variable (i.e. run `ALL_TOOLS.map(t => t.name)` in codemode) to list all available tool names inside the sandbox.

Note that MCP tools likely include the prefix of their mcp server in their tool name so don't guess.

To call a tool called "foo" use `tools.foo(...)` etc.
