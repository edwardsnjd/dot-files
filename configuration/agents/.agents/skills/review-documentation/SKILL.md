---
name: review-documentation
description: Review the quality of some documentation
---

## Overview

Diátaxis is a systematic framework for authoring technical documentation, developed to solve problems of content (what to write), style (how to write it), and architecture (how to organise it). It identifies four distinct user needs and maps each to a corresponding documentation type, placing them in a structured relationship rather than treating them as an arbitrary list:

- **Tutorials** are learning-oriented lessons: practical, guided experiences where a novice does something meaningful under an instructor's direction, prioritising confidence and repeatable success over completeness or explanation.
- **How-to guides** are goal-oriented directions written from the user's perspective, showing a competent practitioner how to solve a specific real-world problem rather than merely demonstrating what a tool can do.
- **Reference** material is information-oriented technical description — austere, consistent, and structured to mirror the product itself, giving users the accurate facts they consult (rather than read) while working.
- **Explanation** is understanding-oriented discursive material that provides context, background, and reasoning (design decisions, history, alternatives), read away from active work to deepen and connect knowledge.

It also frames documentation use as a natural cycle — users move from a learning-oriented phase (tutorials), to a goal-oriented phase (how-to guides), consulting reference material throughout, and eventually reflecting via explanation once away from the task:

1. Tutorials + Reference
2. How-to guides + Reference
3. Explanation

## Approach and Rationale

The framework's core insight is that documentation users have fundamentally different needs depending on their situation, and each need demands a different kind of writing. Diátaxis organises these needs along two axes:

- **action vs. cognition** - whether the content guides doing or informs knowing
- **acquisition vs. application** - whether the user is studying a skill or applying one already held.

Crossing these axes produces a "compass" that assigns any piece of content to exactly one of four quadrants:

| Informs...  | Serves...             | Belongs to...  |
|-------------|-----------------------|----------------|
| Action      | Acquisition of skill  | Tutorial       |
| Action      | Application of skill  | How-to guide   |
| Cognition   | Application of skill  | Reference      |
| Cognition   | Acquisition of skill  | Explanation    |

Diátaxis treats this as a decision tool, not just a taxonomy — when a page feels awkward or hard to write, asking "action or cognition?" and "acquisition or application?" reveals which quadrant it actually belongs to and often exposes drift where multiple needs have been mixed into one document. The framework is deliberately lightweight: it imposes no tooling or implementation constraints and is intended to be applied incrementally rather than through an upfront restructuring project.

## Applying the Framework

**Single document**

1. Guide with prompts to ascertain the goal on the two axes
2. State the resulting document type
3. Review the document with respect to the decided type

**Overall**

Diátaxis discourages big top-down documentation overhauls in favour of small, iterative improvements: pick a piece of existing content, assess which quadrant it serves, decide on one improvement, and act on it, then repeat.  A common practical pattern is organising documentation folders directly around the four types (tutorials/, how-to/, reference/, explanation/), so that physical structure mirrors function, with any page spanning more than one quadrant flagged for splitting.  Mention that if asked to consider the big picture.
