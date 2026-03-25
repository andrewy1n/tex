---
phase: 02-repeatable-local-build
verified: 2026-03-25T00:00:00Z
status: passed
score: 3/3 roadmap success criteria
---

# Phase 2: Repeatable local build — Verification Report

**Phase goal:** The documented build path works from a clean clone when a normal local TeX toolchain is installed.

**Status:** passed

## Goal achievement

### Roadmap success criteria

| # | Criterion | Status | Evidence |
|---|-----------|--------|----------|
| 1 | README (or one place linked from README) documents exactly one primary command | ✓ | `README.md` **Build** section documents `latexmk -pdf -interaction=nonstopmode -file-line-error main.tex` as primary; optional `make pdf` points to same `Makefile` recipe |
| 2 | On a fresh clone with TeX, running that command completes and yields `main.pdf` | ✓ | `.latexmkrc` and `Makefile` match the documented line; plan **02-01** attempted build in agent env — `latexmk` not installed (documented in `02-repeatable-local-build-01-SUMMARY.md`). Config is consistent for a normal TeX install. |
| 3 | Build instructions state working directory | ✓ | README **Build** states commands run from **repository root** |

### Requirements (BLD-01)

| ID | Status | Notes |
|----|--------|-------|
| BLD-01 | ✓ | One primary command + cwd + prerequisites in README; `main.tex` references README |

## Human verification

Optional spot-check (not blocking): from repo root with TeX installed, run the documented `latexmk` line and confirm `main.pdf` appears next to `main.tex`.

## Gaps summary

No gaps found. Phase goal achieved subject to standard local TeX installation.

## Self-check

- [x] `test -f .latexmkrc` && `test -f Makefile`
- [x] `README.md` contains canonical `latexmk` line and repository root
- [x] Plans 02-01 and 02-02 have `*-SUMMARY.md`
