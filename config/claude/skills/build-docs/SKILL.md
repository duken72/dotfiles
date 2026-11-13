---
name: build-docs
description: Build the adasvf Sphinx documentation in the adasvf-ci docker image and report its warnings and errors. Use when asked to build or check the docs in the adasvf repo.
argument-hint: "[component or doc path to focus on]"
context: fork
agent: general-purpose
model: sonnet
---

Build the adasvf docs (`documentation-adasvf` CMake preset, target `Sphinx`)
and report the result.

Arguments: $ARGUMENTS

1. From the repo root, run the build in the `adasvf-ci` image (it has Sphinx,
   Doxygen and CMake; the host doesn't). Exclude on the command line, never in
   the shared `CMakePresets.json`, the files Sphinx would fail on (it treats
   warnings as errors):
   - both `graphify-out/` folders, for their `GRAPH_REPORT.md` files;
     `**/graphify-out/**` doesn't match the top-level folder;
   - temporary `.md` files at the repo root: untracked ones, the fixed names
     (`PR_DESCRIPTION.md`, `TODO.md`, `PLAN.md`, `SPEC.md`,
     `TEMPORARY_CHANGES.md`), and every `.md`/`.rst` path that
     `TEMPORARY_CHANGES.md` names. They start at H1 and sit in no toctree,
     and a pushed `TEMP:` commit can make them tracked. Only these: a new
     untracked page in a doc folder must still build.

   ```bash
   OV=$(python3 -c "import json; print(json.load(open('CMakePresets.json'))['configurePresets'][0]['cacheVariables']['SPHINX_CONFIG_OVERRIDE'])")
   OV="$OV,graphify-out/**,**/graphify-out/**"
   for f in $(git ls-files --others --exclude-standard -- ':(glob)*.md') \
       PR_DESCRIPTION.md TODO.md PLAN.md SPEC.md TEMPORARY_CHANGES.md \
       $(grep -o '`[^`]*\.\(md\|rst\)`' TEMPORARY_CHANGES.md 2>/dev/null | tr -d '`'); do OV="$OV,$f"; done
   docker run --rm --user vscode -v "$PWD":/mount -w /mount adasvf-ci \
       bash -c 'cmake --preset documentation-adasvf "-DSPHINX_CONFIG_OVERRIDE=$1" && cmake --build --preset documentation-adasvf' _ "$OV"
   ```

   It can take several minutes: run it with Bash `run_in_background: true`,
   writing its output to a log file, and wait for the completion notification.
   If CMake complains that the cache in `build/documentation/vinfast_adas/` was
   made for another source path, report it; don't delete the folder without
   asking.
2. Report: success or failure; every warning and error with file and line (only
   those under the argument's path if one is given, plus a count of the rest);
   and links to open the built docs, as full `file://` URLs. On WSL
   (`$WSL_DISTRO_NAME` set), write each one as
   `file://wsl.localhost/$WSL_DISTRO_NAME<absolute path>`, so the Windows
   browser can open it; elsewhere, write it as `file://<absolute path>`:
   - the start page, `file://<repo root>/build/documentation/vinfast_adas/sphinx/index.html`
     (not the first `index.html` that `find` returns, which can be a subpage);
   - one per changed doc page: for each `.rst` or `.md` file under a `doc/`
     folder in `git status --porcelain` or `git diff --name-only
     origin/<base>...HEAD`, the page is the source path with `.html` under
     `build/documentation/vinfast_adas/sphinx/` (e.g.
     `workspace/motionplanner/doc/testing.rst` →
     `.../sphinx/workspace/motionplanner/doc/testing.html`). Give only links
     whose file exists.

Don't fix the docs unless asked.
