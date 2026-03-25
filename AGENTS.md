# Agent and edit conventions

This file is the primary contract for humans and coding agents working in this repository.

## Master / compile root

Each LaTeX project has its own master under **`projects/<name>/main.tex`**. The reference **`sample`** project uses **`projects/sample/main.tex`**. Discover which projects exist via **[PROJECTS.md](PROJECTS.md)** or from user/task context.

## Build

Do not duplicate full command blocks here. For exact `latexmk` / `make` invocations and flags, follow **[README.md](README.md)** and the section whose heading is **`## Build`**, and **[PROJECTS.md](PROJECTS.md)** for per-project master paths and copy-paste commands (see also [README.md — Build](README.md#build)).

## Git and automated edits

- Do **not** commit LaTeX auxiliary or log files (for example `.aux`, `.log`, `.out`, `.synctex.gz`) or other generated noise listed in **`.gitignore`**.
- **Preserve** TeX **`%` line-continuation** usage: do not merge or reflow lines in ways that break intentional continuations.
- Do **not** commit built PDFs next to project masters, including under **`projects/**/main.pdf`** (for example **`projects/sample/main.pdf`**); those files are build output and are ignored by project policy.

For the full ignore list, see **`.gitignore`**.
