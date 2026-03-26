---
quick_id: "001"
slug: per-project-build-dir
completed: 2026-03-25
---

# Summary: Per-project `build/` directory

**Outputs:** `projects/sample/build/main.pdf` (and aux/log) via `latexmk -outdir=projects/sample/build`; IDE uses `latex-workshop.latex.outDir` `%DIR%/build` so `%OUTDIR%` matches.

## Files touched

- `.vscode/settings.json`, `Makefile`, `README.md`, `PROJECTS.md`, `AGENTS.md`, `.gitignore`

## Verification

- `latexmk ... -outdir=projects/sample/build projects/sample/main.tex` produces PDF under `projects/sample/build/`.
