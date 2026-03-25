# tex

## What This Is

A git repository for LaTeX (`.tex`) sources and supporting files—organized so you can open and edit any file in Cursor/VS Code and give coding agents direct access to the same tree. **v1.1** adds **multiple independent project folders** in one repo (local “Overleaf-like” separation) plus **split / tab PDF preview** while editing. Light build hooks (`latexmk`, Make, LaTeX Workshop) keep builds repeatable without a hosted editor.

## Core Value

**Any `.tex` in the repo is editable in the IDE and readable/writable by agents**, with a simple, shared way to compile when you need a PDF.

## Current state (v1.0)

**Shipped:** Milestone **v1.0 — IDE-first LaTeX repo** (2026-03-25): repo layout and onboarding README, TeX-oriented `.gitignore`, one documented `latexmk` / `make pdf` path from the repo root, and **`AGENTS.md`** plus README / **`.cursor/rules`** pointers for humans and coding agents. v1 requirements are archived in [`.planning/milestones/v1.0-REQUIREMENTS.md`](milestones/v1.0-REQUIREMENTS.md).

## Current Milestone: v1.1 Multi-project workspace & live PDF

**Goal:** Support **several LaTeX projects in one repo** with clear layout and docs, and **live PDF viewing in a separate editor window/panel** (LaTeX Workshop) while editing sources.

**Target features:**

- **Multi-project layout** — Directory convention (e.g. `projects/<name>/`), isolated PDF/aux outputs, project index, updated ignore rules and `AGENTS.md`.
- **Live / split PDF preview** — Separate PDF tab or side view; PDF refreshes after build (auto-build on save and/or documented build workflow).

**Key context:** Still **not** a hosted Overleaf replacement; all editing stays in Cursor/VS Code + local TeX. Research: [`.planning/research/SUMMARY.md`](research/SUMMARY.md).

## Requirements

### Validated

- [x] `.tex` sources (and related assets like `.bib`, figures, and class/style files) live in-repo with a layout that is easy to navigate — **Validated in Phase 1: Repository layout & documentation**
- [x] You can open and edit any `.tex` file in Cursor/VS Code without leaving the repo — **Validated in Phase 1**
- [x] Coding agents can read and modify project files as normal workspace files — **Validated in Phase 1**
- [x] Light, repeatable local build (`.latexmkrc`, `Makefile`, documented `latexmk` in README); no CI requirement in v1 — **Validated in Phase 2: Repeatable local build**
- [x] Short convention doc for master file + build + edit expectations — **Validated in Phase 3: Agent & edit conventions** (`AGENTS.md`, README/`.cursor/rules` pointers)

### Active

_(None — v1 milestone requirements validated.)_

### Out of Scope

- **Overleaf-style hosted web editor or real-time co-authorship** — editor-first; not a web product (v1.1 **does** allow multiple **local** projects in one git repo)
- **Mandatory CI/CD for PDF builds** — optional later
- **Enforcing a specific TeX distribution** — developers use their own local TeX install

## Context

Personal or small-team LaTeX workspace. The aim is versioned sources plus editor and agent ergonomics — v1.1 adds multi-project ergonomics and PDF preview, not feature parity with Overleaf’s hosted product.

## Constraints

- **Editor**: Cursor/VS Code — assume normal file-based editing
- **Build**: Local TeX toolchain (`latexmk`, `pdflatex`, etc.) on the machine

## Key Decisions

| Decision | Rationale | Outcome |
|----------|-----------|---------|
| Source-first repo plus light build hooks | Matches “like Overleaf” as project storage while staying in the IDE | Phase 1: layout + README + `.gitignore`; Phase 2: `.latexmkrc`, `Makefile`, README **Build** |
| No hosted replacement for Overleaf | Keeps scope to repo + editor + agents | v1.0: editor-first repo + agents; no change |
| Multi-project directories + LaTeX Workshop PDF tab | User wants Overleaf-like separation and split PDF while editing | v1.1: `projects/` convention + `.vscode` / docs |

## Evolution

This document evolves at phase transitions and milestone boundaries.

**After each phase transition** (when completing a phase and updating planning artifacts):

1. Requirements invalidated? → Move to Out of Scope with reason
2. Requirements validated? → Move to Validated with phase reference
3. New requirements emerged? → Add to Active
4. Decisions to log? → Add to Key Decisions
5. "What This Is" still accurate? → Update if drifted

**After each milestone** (when completing and archiving a shipped version):

1. Full review of all sections
2. Core Value check — still the right priority?
3. Audit Out of Scope — reasons still valid?
4. Update Context with current state

---
*Last updated: 2026-03-25 — milestone v1.1 initialized (requirements + roadmap)*
