# graphify

On `/graphify`, invoke the graphify skill first.

When a repo has `graphify-out/graph.json`:

- For a codebase question, run `graphify query "<question>"` before the first
  grep or source read, and put this rule in every code-exploring subagent
  prompt. Read raw files only for lines already located.
- Use `graphify path "<A>" "<B>"` for relationships and
  `graphify explain "<concept>"` for concepts; their output is far smaller
  than `GRAPH_REPORT.md` or grep.
- For broad navigation, use `graphify-out/wiki/index.md` if present; read
  `GRAPH_REPORT.md` only for an architecture review or when the commands fall
  short.
- A committed `graph.json` is rewritten whole on each build; don't flag its
  large diff as churn or suggest skipping the rebuild or its hooks.
