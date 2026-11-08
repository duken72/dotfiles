# Subtasks

Keep the main conversation for talking with me; hand work to forks (`Agent`
with `subagent_type: "fork"`) so tool output stays out of it. This standing
request overrides any default against spawning agents unasked. Check this list
before each task's first tool call; "only a few commands" is no reason to stay.

- Fork by default:
  - long runs: builds, tests, `run_ci.py`, docker. A background Bash command
    isn't a fork: its polls and log tails still land here. `/sim-test`,
    `/replay-test`, `/build-docs`, `/pr-desc` and `/commit` already fork:
    call the skill, don't spawn one;
  - broad searches and reads where only the conclusion matters;
  - checks and reviews: lint, docs check, self-review, PR checklist items;
  - every file edit, however small, plus commit and push, since Edit, Write,
    `sed -i`, redirects and a follow-up `cat` all print to me. Decide the
    exact text here and hand it over. This covers drafting files I read
    (`PR_DESCRIPTION.md`, notes, reports) and edit-and-recount loops.
- Keep here: answers to my questions (with refs) and decisions or design
  talk with me; a fork may write them into `SPEC.md`, `PLAN.md` or
  `TEMPORARY_CHANGES.md`.
- Independent items (e.g. a checklist): one fork each, in parallel, with
  separate file scopes; name the one fork that may build. A blocked item's
  fork can wait for its blocker.
- Forks follow these rules too. Facts in a fork prompt (counts, pass rates)
  are copied from the source, not strengthened.
- Put any text the turn needs (an answer, `📌 RULE UPDATE:`) before the spawn.
  Then make no other tool call and end with one line `⏳ Agent <description>`
  (the exact `description`): a turn ending on a tool call bounces back as "no
  visible output", even with text before it. Don't spawn a waiter; the result
  arrives on its own.
- A fork waiting on another run waits on that task's completion or on a
  pattern its own loop can't match (`pgrep -f run_ci.py` in a shell loop
  matches the loop). Check an interim "running" with one command (`docker
  ps`, `pgrep`) before relaying it.
- Relay a result in one or two short lines (`Pushed 5709358 to main.`); more
  only for an answer, a failure or a decision for me. Check a claim with one
  command (`git show`, a grep) when it's doubtful or my answer rests on it,
  or call it unverified; skip routine work reported with a hash. For a "none"
  claim, grep every run for the failure signature itself.
