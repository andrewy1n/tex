---
phase: 04-multi-project-layout-index
plan: 01
subsystem: infra
tags: latex, gitignore, makefile, multi-project

requires:
  - phase: 01-repository-layout-documentation
    provides: root layout and baseline docs
provides:
  - projects/sample/ as migrated compile tree with main.tex, bib, figures, sections
  - Per-project PDF ignore rules and Makefile targeting sample master
affects:
  - 04-02 documentation plans
  - Phase 5 LaTeX Workshop (project paths)

tech-stack:
  added: []
  patterns:
    - "Colocated main.pdf per projects/<name>/ with projects/**/main.pdf gitignore"

key-files:
  created:
    - projects/sample/main.tex
  modified:
    - .gitignore
    - Makefile

key-decisions:
  - "Retained root !figures/**/*.pdf alongside !projects/**/figures/**/*.pdf for D-05/D-26"

patterns-established:
  - "Sample project lives under projects/sample/; builds from repo root use explicit path"

requirements-completed:
  - PRJ-01
  - PRJ-02
  - PRJ-04

duration: 15min
completed: 2026-03-25
---

# Phase 4: Multi-project layout — Plan 01 Summary

**Root LaTeX tree moved to `projects/sample/` with per-project `main.pdf` ignores and Makefile targeting `projects/sample/main.tex`.**

## Performance

- **Duration:** ~15 min
- **Started:** 2026-03-25
- **Completed:** 2026-03-25
- **Tasks:** 3
- **Files modified:** 5 (renames + edits)

## Accomplishments

- Preserved history with `git mv` for `main.tex`, `bib/`, `figures/`, `sections/` into `projects/sample/`.
- `.gitignore` ignores `projects/**/main.pdf` and negates `projects/**/figures/**/*.pdf`.
- `Makefile` `pdf` and `clean` invoke `latexmk` against `projects/sample/main.tex`.

## Task Commits

1. **Task 1: Create `projects/sample/` and move root LaTeX sources** — `6b1e983` (feat)
2. **Task 2: Generalize `.gitignore` for per-project PDFs and figure PDFs** — `2ef57fe` (chore)
3. **Task 3: Point `Makefile` at `projects/sample/main.tex` and verify build** — `2ee1f18` (build)

## Files Created/Modified

- `projects/sample/main.tex` — Sample project master; body points to README Build
- `projects/sample/bib/`, `figures/`, `sections/` — Migrated asset dirs
- `.gitignore` — D-26 per-project PDF + figure negation
- `Makefile` — D-27 explicit `projects/sample/main.tex`

## Decisions Made

- Followed CONTEXT D-23–D-28; kept legacy `!figures/**/*.pdf` for possible root `figures/` reintroduction.

## Deviations from Plan

None - plan executed as written.

## Issues Encountered

- `latexmk` not installed in the execution environment (exit 127); Makefile and grep checks verified; user should run `latexmk` locally to confirm `projects/sample/main.pdf`.

## User Setup Required

None.

## Next Phase Readiness

- Plan **04-02** can add `PROJECTS.md` and update README/AGENTS now that paths and Makefile exist.

---
*Phase: 04-multi-project-layout-index*
*Completed: 2026-03-25*
