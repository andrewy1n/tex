---
phase: 05-live-pdf-preview
verified: 2026-03-25T00:00:00Z
status: passed
score: 3/3 roadmap success criteria
---

# Phase 5: Live PDF preview — Verification Report

**Phase goal:** While editing `.tex`, the user can keep the **PDF in a separate editor view** (tab/side) and have it **refresh after builds** using documented LaTeX Workshop settings.

**Status:** passed

## Goal achievement

### Roadmap success criteria

| # | Criterion | Status | Evidence |
|---|-----------|--------|----------|
| 1 | Committed or documented settings enable a **non-inline** PDF viewer (separate tab or panel) | ✓ | **`.vscode/settings.json`** sets `latex-workshop.view.pdf.viewer` to **`tab`**; **README** documents the key and points to committed files |
| 2 | **Documented workflow** for refreshing the PDF after build (auto-build on save and/or explicit build), multi-project layout | ✓ | **README** `## LaTeX Workshop (PDF preview)` — `onSave` default, **`never`** alternative, **`% !TEX root`** for **`projects/sample/sections/`**; **`.vscode/settings.json`** matches **PROJECTS.md** `latexmk` flags |
| 3 | Optional **SyncTeX** called out if enabled | ✓ | **README** `### SyncTeX (optional)` with **synctex** substring; no over-promising |

### Requirements (PRV-01, PRV-02)

| ID | Status | Notes |
|----|--------|-------|
| PRV-01 | ✓ | Committed **`.vscode/`** + README prose for separate PDF view (`tab`, `external` fallback) |
| PRV-02 | ✓ | README documents save-triggered rebuild and manual **`never`** path; **PROJECTS.md** ties recipes to table `latexmk` lines |

### Plan must-haves (spot-check)

**05-01:** **`.vscode/extensions.json`** recommends **`James-Yu.latex-workshop`**; **`.vscode/settings.json`** contains tab viewer, onSave, workspace-folder build, `projects/**/*.tex`, `latexmk` tool args with **`%DOC%`**, default recipe **`latexmk (repo)`**.

**05-02:** **README** has exact headings **`## LaTeX Workshop (PDF preview)`**, **`### SyncTeX (optional)`**, **`### WSL or remote`**; grep-verifiable keys; **`Makefile`** comment references **`.vscode/`**; **PROJECTS.md** mentions **LaTeX Workshop** and **`.vscode/settings.json`**.

## Human verification

Optional: install **LaTeX Workshop**, open repo root in Cursor/VS Code, save a `.tex` under **`projects/sample/`** and confirm PDF tab behavior matches expectations in your environment.

## Gaps summary

No gaps found. Phase goal achieved.

## Self-check

- [x] `test -f .vscode/extensions.json && test -f .vscode/settings.json`
- [x] `grep -q '"latex-workshop.view.pdf.viewer": "tab"' .vscode/settings.json`
- [x] `grep -q '^## LaTeX Workshop (PDF preview)$' README.md`
- [x] `grep -q '### WSL or remote' README.md && grep -q '### SyncTeX (optional)' README.md`
- [x] `grep -qE '^#.*\.vscode' Makefile || grep -q '\.vscode/' Makefile`
- [x] `grep -q 'LaTeX Workshop' PROJECTS.md && grep -q '.vscode/settings.json' PROJECTS.md`
