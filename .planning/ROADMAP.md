# Roadmap: tex

## Overview

Establish a source-first LaTeX git workspace: predictable layout and README, TeX-oriented hygiene (`.gitignore` and artifact policy), one documented CLI build path from a clean clone, then a short agent/human convention doc aligned with that build contract.

## Phases

**Phase Numbering:**
- Integer phases (1, 2, 3): Planned milestone work
- Decimal phases (2.1, 2.2): Urgent insertions (marked with INSERTED)

- [x] **Phase 1: Repository layout & documentation** - Entry point, folder layout, `.gitignore`, and README onboarding (completed 2026-03-25)
- [ ] **Phase 2: Repeatable local build** - One documented command produces the PDF on a fresh clone
- [ ] **Phase 3: Agent & edit conventions** - Master file, build command, and automation expectations in one short doc

## Phase Details

### Phase 1: Repository layout & documentation
**Goal**: Anyone opening the repo can find the compile root, understand where sources and assets live, and see prerequisites and git policy without digging through history.
**Depends on**: Nothing (first phase)
**Requirements**: REPO-01, REPO-02, REPO-03, REPO-04
**Success Criteria** (what must be TRUE):
  1. Reader can identify what to compile from the README or from a single obvious root `.tex`, or from a documented `% !TeX root` convention for multi-file projects.
  2. `.tex` sources, figures, and bibliography inputs sit in a predictable layout that the README describes.
  3. A TeX-oriented `.gitignore` excludes auxiliary and log files; the README states whether PDFs and other generated artifacts are tracked or ignored.
  4. README lists local prerequisites (e.g. TeX distribution), names the main TeX file, and summarizes the directory layout.
**Plans**: 3/3 plans complete

Plans:
- [x] 01-01-PLAN.md — Repository skeleton, `main.tex` at root, `figures/`, `bib/references.bib`, `sections/`
- [x] 01-02-PLAN.md — GitHub `TeX.gitignore` baseline + project PDF / `figures/` overrides
- [x] 01-03-PLAN.md — README: prerequisites, main file, layout tree, artifact track/ignore policy

### Phase 2: Repeatable local build
**Goal**: The documented build path works from a clean clone when a normal local TeX toolchain is installed.
**Depends on**: Phase 1
**Requirements**: BLD-01
**Success Criteria** (what must be TRUE):
  1. README (or the same single place linked from README) documents exactly one primary command to build the PDF (e.g. `latexmk` or `make`).
  2. On a fresh clone with a typical local TeX install, running that command completes successfully and yields the expected PDF artifact.
  3. Build instructions mention working directory expectations if the command must be run from a specific folder.
**Plans**: TBD

### Phase 3: Agent & edit conventions
**Goal**: Humans and coding agents share one explicit contract for what to compile, how to build, and how to edit safely.
**Depends on**: Phase 2
**Requirements**: AGT-01
**Success Criteria** (what must be TRUE):
  1. A dedicated `AGENTS.md` or a clearly labeled README section states the master/root TeX file.
  2. That doc repeats the same build command (or points unambiguously to the README section that defines it).
  3. The doc states expectations for automated edits (e.g. do not commit auxiliary files; preserve `%` line continuations where relevant).
**Plans**: TBD

## Progress

**Execution Order:**
Phases execute in numeric order: 1 → 2 → 3

| Phase | Plans Complete | Status | Completed |
|-------|----------------|--------|-----------|
| 1. Repository layout & documentation | 3/3 | Complete | 2026-03-25 |
| 2. Repeatable local build | 0/TBD | Not started | - |
| 3. Agent & edit conventions | 0/TBD | Not started | - |
