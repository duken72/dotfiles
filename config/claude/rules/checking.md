# Checking claims

Check a claim before you make it, also one repeated from your own earlier
answers or notes (re-check it, or keep its caveat: "meant to be X; briefly Y
when Z"). Before saying:

- "X already does this": check X goes through the same code path.
- what a check or metric counts (validation target, counter, timer): read
  where it accumulates and under which condition.
- code "rejects" or "fails on" an input: read what the caller does with that
  result (error, fallback, skip).
- what a config flag or value does: grep its uses, not only where it's
  parsed.
- a change breaks something: check when that thing runs (pipeline triggers,
  schedules, branch filters).
- two runs can go in parallel: check every shared resource, not only the
  build folder (host mounts such as `/tmp` and their sockets, host-network
  ports, lock files); if one is unchecked, say "not verified".
- a claim about live state that corrects a plan (PID 1, what's running, a
  file's value): check it with one command.
- one branch lacks another's changes: run `git log A..B` both ways; a file
  diff doesn't show the direction.
- how to fix behavior on a feature branch: fetch its base and check
  `git log HEAD..origin/<base> -- <file>`.
- two files differ or are copies: compare them without comments (`cmp` flags
  a comment-only difference).
- a variable is "always" or "never" something (non-negative, set, in range):
  check every write and the edge cases between them (a target changing
  mid-ramp, a lagging accumulator). Search case-insensitively across all file
  types: generated accessors (`getParking_state()`), positional initializers
  and `.fidl` files don't spell the field name as written.
- something "isn't defined" or "isn't in the repo": search with `grep -a`
  and without `2>/dev/null`; grep silently skips a source file with a stray
  non-ASCII byte as binary.
- a design alternative won't work or costs more (e.g. making a type atomic):
  read that type's definition.
