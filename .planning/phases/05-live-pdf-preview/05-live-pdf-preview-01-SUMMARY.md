---
phase: 05-live-pdf-preview
plan: "01"
subsystem: infra
tags: [latex-workshop, vscode, cursor, latexmk]

requires: []
provides:
  - Workspace LaTeX Workshop config aligned with PROJECTS.md latexmk flags
affects: [05-live-pdf-preview-02]

tech-stack:
  added: []
  patterns:
    - "Repo-root LaTeX Workshop tools/recipes use %DOC% with projects/**/*.tex root discovery"

key-files:
  created:
    - .vscode/extensions.json
    - .vscode/settings.json
  modified: []

key-decisions:
  - "Tab PDF viewer, onSave build, workspace-folder latexmk recipe per locked CONTEXT decisions"

patterns-established:
  - "VS Code/Cursor users install James-Yu.latex-workshop; settings live under .vscode/"

requirements-completed: [PRV-01, PRV-02]

duration: 5min
completed: 2026-03-25
---

# Phase 05: live-pdf-preview — Plan 01

**Committed minimal `.vscode/` with LaTeX Workshop recommendation and workspace settings matching PROJECTS.md `latexmk` flags (tab viewer, onSave, root globs, default recipe).**

## Performance

- **Duration:** ~5 min
- **Tasks:** 2
- **Files modified:** 2 created

## Accomplishments

- `extensions.json` recommends `James-Yu.latex-workshop` (D-02).
- `settings.json` encodes D-01 (tab), D-03 (onSave), D-04 (fromWorkspaceFolder, `projects/**/*.tex`, latexmk tool args with `%DOC%`).

## Task Commits

1. **Task 1: Add `.vscode/extensions.json` recommending LaTeX Workshop** — `b57eeb0`
2. **Task 2: Add `.vscode/settings.json` with LaTeX Workshop keys** — `6dd4739`

## Files Created/Modified

- `.vscode/extensions.json` — extension recommendation
- `.vscode/settings.json` — viewer, auto-build, roots, tools, recipes

## Decisions Made

None — followed plan as specified.

## Deviations from Plan

None — plan executed exactly as written.

## Issues Encountered

None

## Next Phase Readiness

README and cross-links in plan 02 can reference committed `.vscode/settings.json` and keys.

## Self-Check: PASSED

---
*Phase: 05-live-pdf-preview*
*Completed: 2026-03-25*
