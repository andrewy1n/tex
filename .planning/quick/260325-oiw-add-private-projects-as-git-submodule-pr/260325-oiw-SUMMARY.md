# Quick Task 260325-oiw — Summary

**Description:** Add private projects as git submodule (`projects/private`), docs, Makefile vars

## Done

- **Makefile:** `PROJECT ?= sample`; `MASTER` / `OUTDIR` derived as `projects/$(PROJECT)/main.tex` and `projects/$(PROJECT)/build`. Enables `make pdf PROJECT=private/CV` once a submodule exists at `projects/private` with `CV/main.tex`.
- **README:** Section “Private projects (submodule)” with `git submodule add … projects/private`, build example, clone note.
- **PROJECTS.md:** Documents `make pdf PROJECT=<path>` and links to README.
- **AGENTS.md:** Masters may live under multi-segment paths (e.g. `projects/private/CV/main.tex`).
- **No submodule recorded in this repo:** Adding `git submodule add` requires your private remote URL; run locally when ready.

## Verification

- `make pdf` and `make clean` run successfully for default `PROJECT=sample`.
