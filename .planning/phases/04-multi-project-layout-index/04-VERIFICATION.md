---
phase: 04-multi-project-layout-index
verified: 2026-03-25T00:00:00Z
status: passed
score: 4/4 roadmap success criteria
---

# Phase 4: Multi-project layout & index — Verification Report

**Phase goal:** The repo supports more than one LaTeX project, each with its own master file and outputs that do not clobber other projects, with clear documentation for humans and agents.

**Status:** passed

## Goal achievement

### Roadmap success criteria

| # | Criterion | Status | Evidence |
|---|-----------|--------|----------|
| 1 | Directory convention exists and is written down (`projects/<name>/`, obvious master per project) | ✓ | **`projects/sample/main.tex`** exists; **`04-CONTEXT`** / **`PROJECTS.md`** / **`README.md`** describe the convention |
| 2 | Build outputs isolated so normal builds do not overwrite another project’s PDF | ✓ | Colocated **`projects/<name>/main.pdf`** model; **`.gitignore`** includes **`projects/**/main.pdf`** |
| 3 | Project index lists each project, master file, and build instructions | ✓ | **`PROJECTS.md`** table; **`README.md`** links to it with example line for `sample` |
| 4 | `.gitignore` and `AGENTS.md` explain per-project artifacts | ✓ | **`.gitignore`** D-26 rules; **`AGENTS.md`** **`projects/**/main.pdf`** policy; **`README.md`** “What we track vs ignore” |

### Requirements (PRJ-01–PRJ-04)

| ID | Status | Notes |
|----|--------|-------|
| PRJ-01 | ✓ | `projects/<name>/` documented; `projects/sample/` is the reference layout |
| PRJ-02 | ✓ | Distinct output path `projects/sample/main.pdf`; Makefile/`latexmk` use explicit path |
| PRJ-03 | ✓ | **`PROJECTS.md`** + **`README.md`** navigation |
| PRJ-04 | ✓ | Per-project PDF ignore + **`AGENTS.md`** + README prose |

### Plan must-haves (spot-check)

**04-01:** Migrated tree; no root `main.tex`; Makefile references `projects/sample/main.tex`; `.gitignore` has `projects/**/main.pdf` and figure negation.

**04-02:** **`PROJECTS.md`** lists sample + `latexmk` line; **`README.md`** contains **`projects/`** and **`PROJECTS.md`**; **`AGENTS.md`** covers **`projects/`** and pointers without duplicating full `latexmk` blocks.

## Human verification

Optional: open **`PROJECTS.md`**, **`README.md`**, **`AGENTS.md`** — paths consistent; no claim that the only master is `main.tex` at repo root.

## Gaps summary

No gaps found. Phase goal achieved.

## Self-check

- [x] `test ! -f main.tex && test -f projects/sample/main.tex`
- [x] `grep -q 'projects/sample/main.tex' Makefile && grep -q 'latexmk' Makefile`
- [x] `grep -q 'projects' .gitignore && grep -q 'main.pdf' .gitignore`
- [x] `test -f PROJECTS.md && grep -q 'latexmk -pdf' PROJECTS.md`
- [x] `grep -q 'PROJECTS.md' README.md && grep -q 'projects/' README.md && grep -q '## Build' README.md`
- [x] `grep -q 'projects/' AGENTS.md && grep -qi 'PROJECTS.md\|README' AGENTS.md && grep -qi 'main.pdf' AGENTS.md`
