---
name: replay-test
description: Replay recorded datasets through adasvf vparking_app with scripts/run_ci.py, optionally with --validation interface logs, and report the result. Use when asked to run a replay test or replay a dataset in the adasvf repo.
argument-hint: "[dataset | all] [--validation] [extra run_ci.py flags]"
context: fork
agent: general-purpose
model: sonnet
---

Run replay-mode tests of `vparking_app` with `scripts/run_ci.py` in the adasvf
repo (the current working directory, or its main checkout `~/WS/adasvf`) and
report the results.

Arguments: $ARGUMENTS

1. Pick the runs:
   - A dataset: a name or `~/data/<name>`, or part of a name matched against
     `./scripts/run_ci.py -m=replay --ls-inputs`. Run
     `./scripts/run_ci.py -rc -m=replay --input=<dataset>`. If a name matches
     several datasets, run none and report the matches.
   - No dataset: leave out `--input`; run_ci.py takes the newest.
   - `all`: one run per listed dataset, in order.
   - Pass any other flags through unchanged (`--validation`, `--timeout=S`,
     `--car-type=...`, `--no-mt`, `--no-save-video`, `--display`).
2. Run on the host, never inside the container. Each run first rebuilds the
   app. A run can take over 10 minutes: start it with Bash
   `run_in_background: true`, writing its output to a log file, and wait for
   the completion notification. Don't poll or tail the log in a loop. Runs in
   one repo queue on a lock, so start them one after the other.
3. With `--validation`, the script turns on `ENABLE_IFACE_LOG` in
   `workspace/common/include/common/models/common/abstractinterface.h` and
   `EnableAIParkingPipeline` in
   `workspace/parkingslotfinder/config/parkingslotfinder_config.yml`, rebuilds
   most of the app, and turns both off at the end. Afterwards check that
   `git status` shows neither file as modified; report it if one is.
4. Read the results in
   `~/ci-results/<ts>_LOCAL_<commit>/replay_<carType>_<dataset>/` (the script
   prints `Created folder: <dir>`): `metadata.json` (`exit_code`,
   `duration_s`), `app.log`, `video.mp4`, and with `--validation` the
   `Validation/*.json` interface logs (list them with sizes, and pass on any
   "cut in half" warning from the run output). Exit code 124 means the timeout
   (default 300 s) stopped the app.
5. Report tersely, with no interim status messages. One line per dataset:
   `<dataset> passed (<duration> s).`, or on failure
   `<dataset> failed (exit <code>): <last error line of app.log>.` Then one
   line `Results: <results folder>`. With `--validation`, add one line with the
   number of `Validation/*.json` logs and any warning. Nothing else unless the
   user's arguments ask for details. These lines are the whole report: the main
   session relays them unchanged.

Don't edit code or configs to make a test pass.
