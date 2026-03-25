# Research summary — v1.1 (multi-project + live PDF)

**Date:** 2026-03-25  
**Scope:** Additive milestone on top of v1.0 single-root LaTeX repo.

## Stack / editor

- **LaTeX Workshop** (`James-Yu.latex-workshop`) is the standard VS Code/Cursor integration: build recipes, PDF viewer, SyncTeX.
- **PDF viewer placement** is controlled by settings such as `latex-workshop.view.pdf.viewer` (e.g. `tab` opens PDF in a separate editor tab; other options include external viewer or browser depending on version and platform).
- **Auto-build** uses `latex-workshop.latex.autoBuild.run` (`onSave`, `onFileChange`, `never`, etc.) so the PDF can refresh after builds without manual CLI each time.

## Features (table stakes)

- Separate **PDF panel/tab** while editing `.tex` (not the same as the source buffer).
- **Per-folder or per-root** recipes so multiple masters in one repo can each build to their own PDF path.
- **SyncTeX** (optional polish): click-to-source between PDF and `.tex` when enabled in TeX and viewer.

## Architecture (repo)

- **Overleaf-like “projects” in git:** use **one directory per project** (e.g. `projects/<name>/`) each containing `main.tex` (or a single obvious master), `figures/`, `bib/`, etc.
- **Avoid output collisions:** either separate output dirs per project (`build/<name>/` or `projects/<name>/out/`) or distinct PDF names; document the convention in README/`AGENTS.md`.
- **`.vscode/settings.json`** (workspace): `latex-workshop.latex.rootFile` or multi-root patterns — use `% !TeX root` or explicit recipe `args` per project when needed.

## Pitfalls

- **Single global `main.tex` at repo root** conflicts with multiple masters — v1.1 should migrate or nest legacy root content under `projects/...` and update docs.
- **`.gitignore`:** root `/main.pdf` rule must generalize to per-project PDFs (e.g. `projects/**/main.pdf` or `**/main.pdf` with care for tracked figure PDFs).
- **WSL/path issues:** PDF viewer and `latexmk` paths occasionally differ; document “open folder at repo root” and TeX on PATH.

## Recommendation for roadmap

1. **Layout first:** `projects/` convention, migrate current sample, index doc, ignore rules.
2. **Editor second:** committed `.vscode` (or documented user settings) for viewer + auto-build per project.
