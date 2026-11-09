# Subtasks

Keep the main conversation for talking with me; hand work to subagents so
tool output stays out of it. This standing request overrides any default
against spawning agents unasked. Check this list before each task's first
tool call; "only a few commands" is no reason to stay.

- Hand off by default:
  - Model: long mechanical runs (builds, `run_ci.py`, docker, commit/push)
    and edits whose exact text is decided here go to `Agent` with
    `subagent_type: "general-purpose"` and `model: "sonnet"`, with the
    commands or text in the prompt; forks (always my model) only for work
    that needs this conversation (drafting from our discussion, reviews);
  - long runs: builds, tests, `run_ci.py`, docker. A background Bash command
    isn't a subagent: its polls and log tails still land here. `/sim-test`,
    `/replay-test` and `/build-docs` already run as sonnet subagents,
    `/pr-desc` as a fork, and `/commit` spawns its own subagent: call the
    skill, don't spawn one;
  - broad searches and reads where only the conclusion matters;
  - checks and reviews: lint, docs check, self-review, PR checklist items;
  - every file edit, however small, plus commit and push, since Edit, Write,
    `sed -i`, redirects and a follow-up `cat` all print to me. Decide the
    exact text here and hand it over. This covers drafting files I read
    (`PR_DESCRIPTION.md`, notes, reports) and edit-and-recount loops.
- Keep here: answers to my questions (with refs) and decisions or design
  talk with me; a subagent may write them into `SPEC.md`, `PLAN.md` or
  `TEMPORARY_CHANGES.md`.
- Independent items (e.g. a checklist): one subagent each, in parallel, with
  separate file scopes; name the one subagent that may build. A blocked item's
  subagent can wait for its blocker.
- Subagents follow these rules too. Facts in a subagent prompt (counts, pass
  rates) are copied from the source, not strengthened.
- Put any text the turn needs (an answer, `📌 RULE UPDATE:`) before the spawn.
  Then make no other tool call and end with one line `⏳ Agent <description>`
  (the exact `description`): a turn ending on a tool call bounces back as "no
  visible output", even with text before it. Don't spawn a waiter; the result
  arrives on its own.
- A subagent waiting on another run waits on that task's completion or on a
  pattern its own loop can't match (`pgrep -f run_ci.py` in a shell loop
  matches the loop). Check an interim "running" with one command (`docker
  ps`, `pgrep`) before relaying it.
- Relay a result in one or two short lines (`Pushed 5709358 to main.`); more
  only for an answer, a failure or a decision for me. Check a claim with one
  command (`git show`, a grep) when it's doubtful or my answer rests on it,
  or call it unverified; skip routine work reported with a hash. For a "none"
  claim, grep every run for the failure signature itself.
