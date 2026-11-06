# Checking claims

Check a claim before you make it, including one repeated from your own earlier
answers or notes (re-check it, or keep its caveat: "meant to be X; briefly Y
when Z"). Read the code that decides the claim, not only where a name appears:

- Code behavior: "X already does this" needs the same code path; a counter,
  metric or check counts only where and when it accumulates; a "rejected"
  input depends on what the caller does with the result; a config value does
  what its uses do, not what its parser says; judge a design alternative only
  after reading the type's definition.
- Runtime and state: a change breaks something only if that thing runs then
  (triggers, schedules, branch filters); parallel runs need every shared
  resource checked (mounts, sockets, ports, lock files) or "not verified";
  check live state that corrects a plan with one command.
- Git and files: run `git log A..B` both ways for which branch lacks what,
  and `git log HEAD..origin/<base> -- <file>` before fixing a feature branch;
  compare files without comments, since `cmp` flags comment-only changes.
- Searching: an "always" or "never" claim needs every write and the edge cases
  between them; search case-insensitively across all file types (generated
  accessors like `getParking_state()`, `.fidl` files). For "not defined", use
  `grep -a` without `2>/dev/null`; grep skips a file with a stray non-ASCII
  byte as binary.
