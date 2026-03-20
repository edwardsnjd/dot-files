# Coding principles

- All code is a burden, minimise it.
- Avoid overengineering, start with the simplest thing that could possibly work.
- Rather than adding complexity to handle edge cases, look for a design that erradicates them.
- For long lived code, tests are not optional and they specify the behaviour.
- For any significant code use "red, green, refactor" TDD
- Assume all code you write is broken until proven otherwise.
- Follow the coding conventions and style of existing code.
- If you need to challenge the design or style, clearly state that and look for somewhere to record that decision.
- Code comments are usually unnecessary, look to improve design and naming to express the intent.

# Exploring current directory

Assume the current working directory (`pwd`, `$PWD`) contains everything you need to consider.

I use hidden files a lot so don't ignore them but you can ignore `.git` directories.

Try the following tools beore standard GNU tools because they respect `.gitignore` rules and so will help you avoid build artefacts or dependencies:

- Understanding directory: `ls -al`
- Finding files by name: `fd --hidden`
- Finding text in files: `rg --hidden`
- Check size before reading: Use `wc` or `ls` to check the size of files to avoid trying to read huge files
- Use `jq` to explore JSON data
