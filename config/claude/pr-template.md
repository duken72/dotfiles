# PR description template

Rules for filling it in:

- Hard limit: the whole description is at most 4000 characters (count it before posting). If over, cut in this order: the changed-files list down to highlights, then Future extensions, then prose in Description.
- Keep every section heading, in this order. Write `N/A` rather than dropping a section.
- Changed files: list them all if roughly 10 or fewer; otherwise list only the most important ones and end with `... and N more (see Files tab)`.
- Type of change: keep all options, tick the ones that apply.
- Checklist: tick only what was actually done; leave the rest unticked instead of deleting them. "After merging" items stay unticked.
- Testing instructions must be exact commands / steps a reviewer can copy, plus the expected result.

```markdown
## Story

<Work item / ticket ID and title, with link. One line on why this is needed.>

## Description

<2-4 sentences: what changed and why, and any design decision worth a reviewer's attention.>

**Changed files**

- `path/to/file` — what changed
- `path/to/other` — what changed

## Testing instructions

1. <build / setup command>
2. <run command or manual step>

Expected: <what the reviewer should see>

## Type of change

- [ ] Bug fix
- [ ] New feature
- [ ] Refactoring (no functional change)
- [ ] Documentation
- [ ] Tests
- [ ] Build / CI / config
- [ ] Breaking change

## Checklist

**Before merging**

- [ ] Builds and unit tests pass locally
- [ ] New / changed behaviour is covered by tests
- [ ] Formatting and static analysis are clean
- [ ] Documentation updated
- [ ] Self-reviewed; no debug code or unrelated changes

**After merging**

- [ ] Verify the pipeline on the target branch is green
- [ ] Notify people affected by the change (dependent branches, config / interface users)

## Future extensions / TODO

- <follow-up not covered by this PR, with ticket ID if one exists>
```
