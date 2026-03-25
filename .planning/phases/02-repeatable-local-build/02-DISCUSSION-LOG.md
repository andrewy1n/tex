# Phase 2: Repeatable local build - Discussion Log

> **Audit trail only.** Do not use as input to planning, research, or execution agents.  
> Decisions are captured in `02-CONTEXT.md`.

**Date:** 2026-03-25  
**Phase:** 2-repeatable-local-build  
**Areas discussed:** Primary build command, working directory, latexmkrc, documentation surface, engine default  
**Mode:** Single-turn recommended defaults (no interactive multi-select in session)

---

## Session note

Interactive **present_gray_areas** multi-select was **not** performed in a back-and-forth chat. Defaults were chosen to satisfy **BLD-01**, ROADMAP Phase 2 success criteria, and alignment with Phase 1 **01-CONTEXT.md** and **README.md** (latexmk forward reference).

If you need a different workflow (e.g. **`make` as the only documented interface**, or **no `.latexmkrc`**), edit `02-CONTEXT.md` before `/gsd-plan-phase 2`.

---

## Primary build command & tooling

| Option | Description | Selected |
|--------|-------------|----------|
| `latexmk` as primary | Document `latexmk` with flags; add `.latexmkrc` | ✓ |
| `make` as primary | Document `make pdf` only | |
| Dual primaries | Equal status for `make` and `latexmk` | |

**User's choice:** `latexmk` as the single primary documented command; optional Makefile wrapper only if it delegates to the same invocation.

**Notes:** Matches README prerequisite text and BLD-01 example list.

---

## Working directory

| Option | Description | Selected |
|--------|-------------|----------|
| Repo root | Commands run from directory containing `main.tex` | ✓ |
| Subdirectory | Build from `build/` or similar | |

**User's choice:** Repository root.

---

## `.latexmkrc`

| Option | Description | Selected |
|--------|-------------|----------|
| Commit minimal `.latexmkrc` | Reproducible flags/engine in repo | ✓ |
| Flags in README only | No config file | |

**User's choice:** Commit `.latexmkrc` with pdflatex-oriented defaults.

---

## Where users read the command

| Option | Description | Selected |
|--------|-------------|----------|
| README section | Single “Build” section in `README.md` | ✓ |
| Separate BUILD.md | Split docs | |

**User's choice:** README-only unless length forces otherwise in planning.

---

## Engine default

| Option | Description | Selected |
|--------|-------------|----------|
| pdflatex | Matches current `main.tex` | ✓ |
| xelatex / lualatex | Unicode/fonts | |

**User's choice:** `pdflatex` via `latexmk`; engine switches deferred unless trivially documented in comments.

---

## Claude's Discretion

Exact `latexmk`/`latexmkrc` parameters; optional Makefile presence; README phrasing.

---

## Deferred ideas

- CI, Docker, devcontainer — future phases per PROJECT.md
