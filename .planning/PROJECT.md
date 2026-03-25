# tex

## What This Is

A git repository for LaTeX (`.tex`) sources and supporting files—organized so you can open and edit any file in Cursor/VS Code and give coding agents direct access to the same tree. Light build hooks (for example Makefile, `latexmk`, or editor tasks) keep local builds repeatable without turning this into a hosted editor.

## Core Value

**Any `.tex` in the repo is editable in the IDE and readable/writable by agents**, with a simple, shared way to compile when you need a PDF.

## Requirements

### Validated

- [x] `.tex` sources (and related assets like `.bib`, figures, and class/style files) live in-repo with a layout that is easy to navigate — **Validated in Phase 1: Repository layout & documentation**
- [x] You can open and edit any `.tex` file in Cursor/VS Code without leaving the repo — **Validated in Phase 1**
- [x] Coding agents can read and modify project files as normal workspace files — **Validated in Phase 1**

### Active

- [ ] Light, repeatable local build (script, `latexmk`, Makefile, and/or editor tasks); no requirement for CI in v1 — *Phase 2*
- [ ] Short convention doc for master file + build + edit expectations — *Phase 3*

### Out of Scope

- **Overleaf-style hosted web editor or real-time co-authorship** — editor-first; not a web product
- **Mandatory CI/CD for PDF builds** — optional later
- **Enforcing a specific TeX distribution** — developers use their own local TeX install

## Context

Personal or small-team LaTeX workspace. The aim is versioned sources plus editor and agent ergonomics, not feature parity with Overleaf.

## Constraints

- **Editor**: Cursor/VS Code — assume normal file-based editing
- **Build**: Local TeX toolchain (`latexmk`, `pdflatex`, etc.) on the machine

## Key Decisions

| Decision | Rationale | Outcome |
|----------|-----------|---------|
| Source-first repo plus light build hooks | Matches “like Overleaf” as project storage while staying in the IDE | Phase 1: layout + README + `.gitignore` done; build hooks in Phase 2 |
| No hosted replacement for Overleaf | Keeps scope to repo + editor + agents | — Pending |

## Evolution

This document evolves at phase transitions and milestone boundaries.

**After each phase transition** (via `/gsd-transition`):

1. Requirements invalidated? → Move to Out of Scope with reason
2. Requirements validated? → Move to Validated with phase reference
3. New requirements emerged? → Add to Active
4. Decisions to log? → Add to Key Decisions
5. "What This Is" still accurate? → Update if drifted

**After each milestone** (via `/gsd-complete-milestone`):

1. Full review of all sections
2. Core Value check — still the right priority?
3. Audit Out of Scope — reasons still valid?
4. Update Context with current state

---
*Last updated: 2026-03-25 after Phase 1 complete*
