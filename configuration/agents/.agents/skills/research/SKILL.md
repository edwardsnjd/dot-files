---
name: research
description: Use this skill when you need to research a topic and it's likely too large for a quick answer
---

# Research

Researching involves lots of depth and breadth so you need to constantly try to keep track of the big picture, and delegate ALL work to subagents (see the `subagent` skill).

Never assume you already know the answer.  You need to actively look for all viewpoints and evidence both for and against your hypothesis.

## When to use this skill

- If the user asks you to research/explore something
- If you need to explore a large topic

## How to perform research

1. Create a document that you will slowly grow as the research proceeds (see below for rough template)
2. Use just your knowledge to take a first guess at the rough outline of the research required
3. Improve the outline structure by delegating the following tasks to subagents:
    - look to confirm the outline
    - look to reject the outline
    - revise the outline with what we learned
4. Now proceed systematically, delegating research of each area outlined to a subagent
    - Ensure all findings are included as an appendix
6. Evaluate all the findings and synthesise a summary
7. Tidy the document and return the response

## Rough template

```markdown
# {Research Topic}

{1/2 paragraph statement of the topic}

## Summary

{1/2 paragraph summary of research result}

## Discussion

{Structured discussion of any key points}

## Sources

{Brief list of all data, evidence, sources}
```
