---
name: bug-report
description: Write a bug report in the user's template, with System Info filled from commands. Use when asked to write or draft a bug report or issue.
---

When I ask for a bug report, use this template. Fill in System Info from
commands (`cat /etc/os-release`, `<tool> --version`,
`git rev-parse --short HEAD`), not memory; leave out lines you can't check.

```markdown
## Repro Steps

Short description

1. <first step: command, input or action>
2. <next step, until the bug shows>

**Expected behavior:**

**Actual:**

## System Info

- Component:
- Branch/commit:
- OS, platform: <name and version>
- Others metadata:
```
