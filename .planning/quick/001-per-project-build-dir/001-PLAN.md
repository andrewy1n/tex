---
quick_id: "001"
slug: per-project-build-dir
type: quick
---

# Quick task: Per-project `build/` output

## Objective

Put all latexmk outputs (PDF, aux, log, etc.) under **`projects/<name>/build/`** instead of next to `main.tex`, for the sample project and LaTeX Workshop.

## Changes

- `.vscode/settings.json`: `latex-workshop.latex.outDir` → `%DIR%/build` (with existing `-outdir=%OUTDIR%`).
- `Makefile`: `-outdir=projects/sample/build` for `pdf` and `clean`.
- `README.md`, `PROJECTS.md`, `AGENTS.md`: document layout and commands.
- `.gitignore`: `projects/**/build/`.
