---
name: build-docs
description: Build the adasvf Sphinx documentation in the adasvf-ci docker image and report its warnings and errors. Use when asked to build or check the docs in the adasvf repo.
argument-hint: "[component or doc path to focus on]"
context: fork
---

Build the adasvf docs (`documentation-adasvf` CMake preset, target `Sphinx`)
and report the result.

Arguments: $ARGUMENTS

1. From the repo root, run the build in the `adasvf-ci` image (it has Sphinx,
   Doxygen and CMake; the host doesn't). Exclude both `graphify-out/` folders
   on the command line, never in the shared `CMakePresets.json`: Sphinx treats
   warnings as errors and fails on their `GRAPH_REPORT.md` files, and
   `**/graphify-out/**` doesn't match the top-level folder.

   ```bash
   OV=$(python3 -c "import json; print(json.load(open('CMakePresets.json'))['configurePresets'][0]['cacheVariables']['SPHINX_CONFIG_OVERRIDE'])")
   OV="$OV,graphify-out/**,**/graphify-out/**"
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
   and the path of the built `index.html`
   (`find build/documentation/vinfast_adas -name index.html -path '*html*' | head -1`).

Don't fix the docs unless asked.
