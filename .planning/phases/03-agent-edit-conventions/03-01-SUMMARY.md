---
phase: 03-agent-edit-conventions
plan: 01
subsystem: docs
tags: [latex, agents, conventions]

requires:
  - phase: 02-repeatable-local-build
    provides: README Build as canonical command surface
provides:
  - Root AGENTS.md with master file, README Build pointer, git/edit hygiene
affects: []

tech-stack:
  added: []
  patterns:
    - "Single convention doc at repo root; build by reference to README ## Build only"

key-files:
  created:
    - AGENTS.md
  modified: []

key-decisions:
  - "Build section points to README.md ## Build with markdown link; no duplicated latexmk blocks"

patterns-established:
  - "AGENTS.md is the human+agent contract for compile root and automation expectations"

requirements-completed: [AGT-01]

duration: 5min
completed: 2026-03-25
---

# Phase 3: Agent & edit conventions — Plan 01 summary

**Root `AGENTS.md` documents `main.tex` as master, defers exact build commands to README `## Build`, and states minimal git/automation rules (aux/log/synctex, `%` continuations, no root `main.pdf`).**

## Performance

- **Duration:** ~5 min
- **Started:** 2026-03-25
- **Completed:** 2026-03-25
- **Tasks:** 1
- **Files modified:** 1 (created)

## Accomplishments

- Added `AGENTS.md` with master/compile root, build-by-reference, and git/automation expectations aligned with D-17, D-19, D-20.

## Task commits

1. **Task 1: Add root AGENTS.md** — (no git repository in workspace; commit skipped if unavailable)

## Files created/modified

- `AGENTS.md` — Agent and human conventions for this LaTeX repo

## Decisions made

None beyond plan — followed CONTEXT and locked decisions.

## Deviations from plan

None — plan executed as written.

## Issues encountered

None.

## Self-Check: PASSED

---
*Phase: 03-agent-edit-conventions · Plan 01*
