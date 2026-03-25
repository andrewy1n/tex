# Agent and edit conventions

This file is the primary contract for humans and coding agents working in this repository.

## Master / compile root

The LaTeX master document is **`main.tex`** at the **repository root** (the same directory as `README.md`).

## Build

Do not duplicate full command blocks here. For exact `latexmk` / `make` invocations and flags, follow **[README.md](README.md)** and the section whose heading is **`## Build`** (see also [README.md — Build](README.md#build)).

## Git and automated edits

- Do **not** commit LaTeX auxiliary or log files (for example `.aux`, `.log`, `.out`, `.synctex.gz`) or other generated noise listed in **`.gitignore`**.
- **Preserve** TeX **`%` line-continuation** usage: do not merge or reflow lines in ways that break intentional continuations.
- Do **not** commit the **root** **`main.pdf`** next to `main.tex` (that file is build output and is ignored by project policy).

For the full ignore list, see **`.gitignore`**.
