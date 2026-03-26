# Quick Task 260325-oiw: Add private projects as git submodule

**Mode:** quick

## Tasks

1. **Makefile** — `PROJECT ?= sample`; build `projects/$(PROJECT)/main.tex` and matching `-outdir`. Default remains sample.
2. **Docs** — `README.md`, `PROJECTS.md`, `AGENTS.md`: optional submodule at `projects/private`, how to add (`git submodule add`), clone with `submodule update --init`, example `make pdf PROJECT=private/CV`.
3. **STATE / summary** — SUMMARY.md; update STATE.md Quick Tasks table.

**Note:** Do not run `git submodule add` without a remote URL; document the user command instead.
