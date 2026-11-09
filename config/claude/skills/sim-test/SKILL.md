---
name: sim-test
description: Run adasvf vparking_app simulation smoke tests with scripts/run_ci.py and report pass/fail per sim config with the failing validation checks. Use when asked to run a sim test, smoke test, sim config or scenario in the adasvf repo.
argument-hint: "[sim config | all] [extra run_ci.py flags]"
context: fork
agent: general-purpose
model: sonnet
---

Run simulation-mode tests of `vparking_app` with `scripts/run_ci.py` in the
adasvf repo (the current working directory, or its main checkout `~/WS/adasvf`)
and report the results.

Arguments: $ARGUMENTS

1. Read `~/WS/adle-vf/claude/adasvf-vparking_sim.md` first.
2. Pick the runs:
   - A config, or a group described in words (e.g. "Smoke_012", "all AR
     scenarios", "all SELECT park-in cases"): match it case-insensitively
     against the config names from `./scripts/run_ci.py -m=sim --ls-inputs`,
     within `scenarios/` unless the user names another folder (`unverified/`,
     `hil_imports/`). Name parts: `AR`, `Select`, `Comfort`, `Summon`;
     `NoseIn`/`NoseOut`; `Perpendicular`/`Angular`/`Parallel`; `Parking` =
     park-in, `Parkout` = park-out, `ParkinParkout` = both; `_L`/`_R` = slot
     side. Run every match, in order, one `./scripts/run_ci.py -rc -m=sim
     --input=<config>` run each. Only when the request names one config and
     several match, run none and report the matches.
   - `all` or no config: every config under `scenarios/` (from `--ls-inputs`),
     one `-rc -m=sim` run each, in order. Don't use `--quick`: it also replays
     a dataset.
   - Pass any other flags through unchanged (`--speed=X`, `--timeout=S`,
     `--car-type=...`, `--no-save-video`, `--display`).
3. Run on the host, never inside the container. Each run first rebuilds the app
   (fast, or full if a desc.yml or the file list changed), then tries 8x, 4x,
   2x, 1x until one attempt passes. A run can take over 10 minutes: start it
   with Bash `run_in_background: true`, writing its output to a log file, and
   wait for the completion notification. Don't poll or tail the log in a loop.
   Runs in one repo queue on a lock, so start them one after the other.
4. Read the results. The script prints `Created folder: <dir>` per attempt
   (`~/ci-results/<ts>_LOCAL_<commit>/sim_<carType>_<config>_<X>x/`). Per
   config, read the last attempt's `metadata.json` (`exit_code`, 0 = pass) and
   `Validation/sim.json`. For a failed attempt, read its FAIL check lines
   (`grep -- '-> FAIL' app.log`) and the whole `[SM][HighLevelVParkingState]`
   transition sequence in `app.log`, not only the last state line.
5. Report tersely, with no interim status messages. One line per config:
   `<config file name without folder and .yml> passed at <X>x.`, or on failure
   `<name> failed (<speed>: <exit code>, ...): <each failing check as name actual vs target±tolerance>.`
   Then one line `Results: <folder of the last attempt>`. On a build failure,
   instead quote the first compiler error. Nothing else unless the user's
   arguments ask for details. These lines are the whole report: the main
   session relays them unchanged.

Don't edit sim configs or code to make a test pass.
