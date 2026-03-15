---
description: Manage a proposed change using a "TODO" markdown file
---
Manage the outline, defined tasks, collaboration, and progress for a piece of work via a single markdown file.

# Description

Externalising all progress on a piece of work into a markdown file is great because:

- important details aren't buried or lost in conversation history
- it's easy to stop and start work on it without losing context
- it's easy to collaborate with a user or other agents

# Steps

1. Set up the shared file and tell the user you're using it for all notes
2. Treat the file as your shared memory, decision log, design notes, planning area, and task list/history.

## 1. How to set up the shared file

1. Define `<description>` as what the user want to work on: $@
2. If `<description>` isn't defined then ask them (DO NOT PROCEED IF UNCLEAR)
3. Make a short kebab case `<name>` capturing essence of `<description>`
4. Define `<todos>` as the file name `TODO.<name>.md`
5. Ensure our single working file exists: `touch <path>`
6. Tell the user you're working in the file `<path>`
7. Treat the file as your memory for anything interesting about this proposed work:
    - intended change
    - design changes
    - tasks to implement this change (as `- [ ] ...` markdown checklist)
    - progress on tasks (`- [x] ...` ticked off tasks)
8. If the file `<path`> exists read it, else populate with the following template
    > # TODO: `<name>`
    >
    > ## Summary
    >
    > ## Desired outcome
    >
    > ## Decisions
    >
    > ## Plan
    >
    > - [ ] Task 1
    > - [ ] Task 2
    > etc.

## 2. How to use the file

- Work with the user to complete each section (or do one at a time if asked)
- Capture and sequence agreed work in a markdown list of tasks: `- [ ] Task ...`
- Work through the tasks in order, marking them as follows:
    - `- [ ] Task ...` = an untouched task
    - `- [!] Task ...` = a task that's in progress (i.e. a claimed task)
    - `- [x] Task ...` = a task that's been completed
