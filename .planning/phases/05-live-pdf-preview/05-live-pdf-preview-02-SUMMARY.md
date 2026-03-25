---
phase: 05-live-pdf-preview
plan: "02"
subsystem: infra
tags: [latex-workshop, readme, documentation]

requires:
  - phase: 05-live-pdf-preview-01
    provides: ".vscode/settings.json and extensions.json for cross-reference"
provides:
  - Documented LaTeX Workshop workflow in README; Makefile and PROJECTS.md pointers to .vscode
affects: []

tech-stack:
  added: []
  patterns:
    - "README lists exact latex-workshop.* keys; partials use % !TEX root for projects/sample/sections"

key-files:
  created: []
  modified:
    - README.md
    - Makefile
    - PROJECTS.md

key-decisions:
  - "SyncTeX and WSL sections kept short per D-05/D-06; external viewer documented as escape hatch"

patterns-established:
  - "PROJECTS.md states LW recipes mirror table latexmk intent"

requirements-completed: [PRV-01, PRV-02]

duration: 10min
completed: 2026-03-25
---

# Phase 05: live-pdf-preview — Plan 02

**README now documents the full LaTeX Workshop workflow (keys, onSave vs never, `% !TEX root` for partials, SyncTeX optional, WSL/remote + external viewer); Makefile and PROJECTS.md point at `.vscode/`.**

## Performance

- **Duration:** ~10 min
- **Tasks:** 2
- **Files modified:** 3

## Accomplishments

- Replaced placeholder editor section with `## LaTeX Workshop (PDF preview)` and required subsections.
- Repository layout tree lists `.vscode/settings.json` and `extensions.json`.
- Makefile comment and PROJECTS.md paragraph link committed LW config to canonical `latexmk` lines.

## Task Commits

1. **Task 1: README LaTeX Workshop section** — `b837c32`
2. **Task 2: Makefile + PROJECTS.md cross-links** — `4690e8c`

## Files Created/Modified

- `README.md` — workflow documentation (PRV-01/02, D-02–D-06)
- `Makefile` — comment referencing `.vscode/`
- `PROJECTS.md` — LaTeX Workshop vs table commands

## Decisions Made

None — followed plan as specified.

## Deviations from Plan

None — plan executed exactly as written.

## Issues Encountered

None

## Next Phase Readiness

Phase 5 documentation and config are complete; users can follow README + committed settings.

## Self-Check: PASSED

---
*Phase: 05-live-pdf-preview*
*Completed: 2026-03-25*
