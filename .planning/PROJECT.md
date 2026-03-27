# tex

## What This Is

A git repository for LaTeX (`.tex`) sources and supporting files—organized so you can open and edit any file in Cursor/VS Code and give coding agents direct access to the same tree. **v1.1** adds **multiple independent project folders** in one repo plus **split / tab PDF preview**. **v1.2** adds **local quality tooling**: `chktex`, `latexindent` (with committed config and editor integration), and a **`latexdiff`-based revision** workflow via Make. Light build hooks (`latexmk`, Make, LaTeX Workshop) keep builds repeatable without a hosted editor.

## Core Value

**Any `.tex` in the repo is editable in the IDE and readable/writable by agents**, with a simple, shared way to compile when you need a PDF.

## Current state (v1.2)

**Shipped:** Milestone **v1.2 — Quality tooling & templates** (2026-03-27): Phases **6–7** delivered linting/formatting docs and `.latexindent.yaml`, VS Code format-on-save for LaTeX, `make format`, and `make diff` for `latexdiff` PDFs under each project’s `build/`. Roadmap and requirements are archived under [`.planning/milestones/v1.2-ROADMAP.md`](milestones/v1.2-ROADMAP.md) and [`v1.2-REQUIREMENTS.md`](milestones/v1.2-REQUIREMENTS.md).

**Earlier releases:** v1.1 (multi-project + live PDF), v1.0 (IDE-first repo) — see [`.planning/MILESTONES.md`](MILESTONES.md).

## Next milestone

**Not defined.** Strong candidate: **template library** (`templates/` with CV, paper, letter, presentation starters — **TMP-01**), plus optional items from archived “Future” lists (e.g. **EDT-02**, **PLT-01**/**PLT-02**). Use `/gsd-new-milestone` to capture requirements and roadmap.

## Requirements

### Validated

- [x] `.tex` sources (and related assets like `.bib`, figures, and class/style files) live in-repo with a layout that is easy to navigate — **Phase 1**
- [x] You can open and edit any `.tex` file in Cursor/VS Code without leaving the repo — **Phase 1**
- [x] Coding agents can read and modify project files as normal workspace files — **Phase 1**
- [x] Light, repeatable local build (`.latexmkrc`, `Makefile`, documented `latexmk` in README); no CI requirement in v1 — **Phase 2**
- [x] Short convention doc for master file + build + edit expectations — **Phase 3** (`AGENTS.md`, README / `.cursor/rules` pointers)
- [x] **Multi-project layout** — `projects/<name>/` with per-project `main.tex`, sample at `projects/sample/` — **Phase 4**
- [x] **Isolated PDF outputs** per project path and ignore rules — **Phase 4**
- [x] **Project index** (`PROJECTS.md` + README) with master paths and build lines — **Phase 4**
- [x] **Per-project artifact policy** in `.gitignore` and `AGENTS.md` — **Phase 4**
- [x] **Committed + documented LaTeX Workshop PDF preview** (tab viewer, onSave / manual build, `% !TEX root` for partials, WSL/remote notes) — **Phase 5**
- [x] **QLT-01–QLT-04** — `chktex` + `latexindent` documented and configured; format-on-save; `.latexindent.yaml` — **Phase 6**
- [x] **REV-01–REV-03** — `latexdiff` via `make diff`; README revision workflow — **Phase 7**

### Active

- [ ] **TMP-01** — Reusable template library (`templates/` directory) with CV, paper, letter, and presentation starters *(candidate next milestone)*

### Out of Scope

- **Overleaf-style hosted web editor or real-time co-authorship** — editor-first; v1.1 allows multiple **local** projects in one git repo
- **Mandatory CI/CD for PDF builds** — optional later (**PLT-01**)
- **Enforcing a specific TeX distribution** — developers use their own local TeX install
- **Mandatory lint/format enforcement** — tools are optional; documented in v1.2

## Context

Personal or small-team LaTeX workspace: versioned sources, editor and agent ergonomics, multiple project roots, PDF preview, and local lint/format/diff helpers — not feature parity with Overleaf’s hosted product.

## Constraints

- **Editor**: Cursor/VS Code — assume normal file-based editing
- **Build**: Local TeX toolchain (`latexmk`, `pdflatex`, `chktex`, `latexindent`, `latexdiff`, etc.) on the machine

## Key Decisions

| Decision | Rationale | Outcome |
|----------|-----------|---------|
| Source-first repo plus light build hooks | Matches “like Overleaf” as project storage while staying in the IDE | Phase 1–2: layout, `.latexmkrc`, `Makefile`, README **Build** |
| No hosted replacement for Overleaf | Keeps scope to repo + editor + agents | Unchanged |
| Multi-project directories + LaTeX Workshop PDF tab | Separation of projects + split PDF while editing | Phase 4–5: `projects/` + `PROJECTS.md` + `.vscode` |
| v1.2 quality tooling optional and local | No CI gate; users choose whether to run `chktex` / format / `latexdiff` | Phase 6–7: README + Makefile + `.latexindent.yaml`; diff PDFs in `build/` |
| File-on-disk `latexdiff` first | Simple, explicit comparison before any git-based automation | `make diff SRC=… CMP=…`; git-based diff deferred |

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
*Last updated: 2026-03-27 after v1.2 milestone completion*
