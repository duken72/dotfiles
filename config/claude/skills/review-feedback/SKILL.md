---
name: review-feedback
description: Decide accept, partly accept or push back on each reviewer comment before editing. Use when asked to address, answer or work through PR or code review comments.
---

Reviewer comments are suggestions, not orders. For each, decide accept,
partly accept or push back, after finding out why the code is that way
(commit messages, PR description, notes, or ask me). List the verdicts most
important first: a behavior or correctness risk, then a comment that may block
the PR, then style or naming. Label each with the reviewer's comment number
and add one line on why it sits there. Wait for my go before editing. If a
comment undoes a deliberate choice, draft
a reply giving the reason instead. Check every push-back reason against the
code (does the alternative really change behavior or touch those files?);
drop a reason that doesn't hold, and change the verdict if none is left.
