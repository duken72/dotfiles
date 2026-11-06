# Subtasks

Keep the main conversation for talking with me; hand work to forks (`Agent`
with `subagent_type: "fork"`) so tool output stays out of it. This standing
request overrides any default against spawning agents unasked. Check this list
before each task's first tool call; "only a few commands" is no reason to stay.

- Fork by default:
  - long runs: builds, tests, `run_ci.py`, docker. A background Bash command
    isn't a fork: its polls and log tails still land in the main context.
    `/sim-test`, `/replay-test`, `/build-docs`, `/pr-desc` and `/commit`
    already run in a fork: call the skill instead of spawning one;
  - broad searches and reads where only the conclusion matters;
  - checks and reviews: lint, docs check, self-review, PR checklist items;
  - every file edit, however small, and commit and push. Edit, Write,
    `sed -i`, shell redirects and a `cat` afterwards all print the diff or
    file to me. Decide the exact text here and give it to the fork. This
    includes drafting files I read (`PR_DESCRIPTION.md`, notes, reports) and
    edit-and-recount loops to fit a length limit.
- Keep in the main conversation: answers to my questions (with refs) and
  decisions or design discussion with me. Writing those into `SPEC.md`,
  `PLAN.md` or `TEMPORARY_CHANGES.md` can go to a fork.
- Independent items (e.g. a checklist): one fork each, in parallel, with
  separate file scopes; name the one fork that may build. A blocked item's
  fork can wait for its blocker.
- Forks follow the same rules, including commit or push only when asked.
- Facts in a fork prompt (counts, pass rates) follow the checking rules for
  answers: copy them from the source, don't strengthen them.
- Put any text the turn needs (an answer, `📌 RULE UPDATE:`) before the spawn.
  After the spawn, make no other tool call and end the turn with one line
  `⏳ Agent <description>` (the fork's exact `description`): a turn that ends
  on a tool call is bounced back as "no visible output", even with text
  before it. Don't spawn an agent to wait for it; its result arrives on its
  own.
- A fork that waits for another run should wait on that task's completion or
  on a pattern that can't match its own loop (`pgrep -f run_ci.py` in a shell
  loop matches the loop itself). Check a fork's interim "running" or
  "started" with one command (`docker ps`, `pgrep`) before relaying it.
- Relay a fork's result in one or two short lines (e.g.
  `Pushed 5709358 to main.`); add more only for an answer, a failure or a
  decision for me.
- Check a fork's claim with one command (`git show`, a grep) when it's
  doubtful or my answer rests on it (a test pass, a fix, a finding), or call
  it unverified; skip routine work reported with a hash. For a "none" claim
  ("no errors"), grep every run for the failure signature itself.
