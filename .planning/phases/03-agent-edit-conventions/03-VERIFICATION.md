---
phase: 03-agent-edit-conventions
verified: 2026-03-25T00:00:00Z
status: passed
score: 3/3 roadmap success criteria
---

# Phase 3: Agent & edit conventions — Verification Report

**Phase goal:** Humans and coding agents share one explicit contract for what to compile, how to build, and how to edit safely.

**Status:** passed

## Goal achievement

### Roadmap success criteria

| # | Criterion | Status | Evidence |
|---|-----------|--------|----------|
| 1 | Dedicated `AGENTS.md` or README section states the master/root TeX file | ✓ | Root **`AGENTS.md`** states **`main.tex`** at repository root; README **`## Agents`** links to `AGENTS.md` |
| 2 | That doc repeats the build command or points unambiguously to the README section that defines it | ✓ | **`AGENTS.md`** points to **`README.md`** and heading **`## Build`** (by reference; no duplicated `latexmk` block per D-19) |
| 3 | Doc states expectations for automated edits (e.g. do not commit auxiliary files; preserve `%` line continuations) | ✓ | **`AGENTS.md`** covers aux/log/synctex, **`%`** continuations, and no root **`main.pdf`** |

### Requirements (AGT-01)

| ID | Status | Notes |
|----|--------|-------|
| AGT-01 | ✓ | Dedicated **`AGENTS.md`**: master file, build by reference to README **`## Build`**, automation expectations |

### Plan frontmatter requirement IDs

All plans list **AGT-01**; deliverables match **`must_haves`** in **03-01** and **03-02** PLAN frontmatter.

## Human verification

None — conventions verified by file inspection and automated greps from plans.

## Gaps summary

No gaps found. Phase goal achieved.

## Self-check

- [x] `test -f AGENTS.md` && `grep -q 'main.tex' AGENTS.md` && `grep -q 'README.md' AGENTS.md` && `grep -q '## Build' AGENTS.md`
- [x] `grep -q 'AGENTS.md' README.md` && `grep -A20 'Repository layout' README.md | grep -q 'AGENTS.md'`
- [x] `grep -q 'AGENTS.md' .cursor/rules`
