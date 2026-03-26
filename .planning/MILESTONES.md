# Milestones

## v1.1 Multi-project workspace & live PDF (Shipped: 2026-03-26)

**Phases completed:** 2 phases, 4 plans, 10 tasks

**Key accomplishments:**

- Root LaTeX tree moved to `projects/sample/` with per-project `main.pdf` ignores and Makefile targeting `projects/sample/main.tex`.
- Added `PROJECTS.md` as the canonical index and retargeted `README.md` / `AGENTS.md` for multiple `projects/<name>/main.tex` roots without duplicating full `latexmk` blocks.
- Committed minimal `.vscode/` with LaTeX Workshop recommendation and workspace settings matching PROJECTS.md `latexmk` flags (tab viewer, onSave, root globs, default recipe).
- README now documents the full LaTeX Workshop workflow (keys, onSave vs never, `% !TEX root` for partials, SyncTeX optional, WSL/remote + external viewer); Makefile and PROJECTS.md point at `.vscode/`.

---

## v1.0 IDE-first LaTeX repo (Shipped: 2026-03-25)

**Phases completed:** 3 phases, 7 plans, 14 tasks

**Key accomplishments:**

- Root `main.tex` plus `figures/`, `bib/references.bib`, and `sections/` placeholders establish a single compile root and predictable asset paths.
- Root `.gitignore` vendors GitHub’s TeX template and adds `/main.pdf` plus `!figures/**/*.pdf` for figure assets alongside the baseline TeX ignores.
- Root `README.md` names `main.tex`, lists prerequisites with a TeX Live link, shows the directory tree, and explains tracked vs ignored artifacts against `.gitignore`.
- Committed `.latexmkrc` and a thin `Makefile` so `latexmk -pdf -interaction=nonstopmode -file-line-error main.tex` is the single primary path from repo root; local PDF build not executed here because `latexmk` is not installed in this environment.
- README documents the canonical `latexmk` line, repository root as cwd, prerequisites, and optional `make pdf`; `main.tex` defers to README instead of a future-phase placeholder.
- Root `AGENTS.md` documents `main.tex` as master, defers exact build commands to README `## Build`, and states minimal git/automation rules (aux/log/synctex, `%` continuations, no root `main.pdf`).
- README gains an early `## Agents` section and layout-tree entry for `AGENTS.md`; `.cursor/rules` includes a short HTML comment pointing editors to `AGENTS.md` without duplicating prose.

---
