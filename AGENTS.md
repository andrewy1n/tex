# Agent and edit conventions

This file is the primary contract for humans and coding agents working in this repository.

## Master / compile root

Each LaTeX project has its own master under **`projects/<path>/main.tex`** (path may include segments, e.g. **`projects/private/CV/main.tex`** when a private repo is mounted as a submodule at **`projects/private`**). The reference **`sample`** project uses **`projects/sample/main.tex`**. Discover which projects exist via **[PROJECTS.md](PROJECTS.md)** or from user/task context.

## Build

Do not duplicate full command blocks here. For exact `latexmk` / `make` invocations and flags, follow **[README.md](README.md)** and the section whose heading is **`## Build`**, and **[PROJECTS.md](PROJECTS.md)** for per-project master paths and copy-paste commands (see also [README.md — Build](README.md#build)).

## Git and automated edits

- Do **not** commit LaTeX auxiliary or log files (for example `.aux`, `.log`, `.out`, `.synctex.gz`) or other generated noise listed in **`.gitignore`**.
- **Preserve** TeX **`%` line-continuation** usage: do not merge or reflow lines in ways that break intentional continuations.
- Do **not** commit built PDFs or other latexmk output: treat **`projects/<name>/build/`** as the per-project output tree (ignored), and do not commit legacy **`projects/**/main.pdf`** next to a master if present.

For the full ignore list, see **`.gitignore`**.
