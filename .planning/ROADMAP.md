# Roadmap: tex

## Overview

Extend the v1.0 IDE-first LaTeX repo with **multiple independent “projects”** in one git tree (Overleaf-like separation, still local + editor) and **live / split PDF viewing** in Cursor/VS Code while editing.

## Milestones

- ✅ **v1.0 — IDE-first LaTeX repo** — Phases 1–3 ([snapshot](milestones/v1.0-ROADMAP.md), shipped 2026-03-25)
- 🚧 **v1.1 — Multi-project workspace & live PDF** — Phases 4–5 (in progress)

## Current work

**v1.1** — Define and ship multi-project layout, then LaTeX Workshop–based PDF preview and refresh workflow.

## Phases (v1.1)

### Phase 4: Multi-project layout & index

**Goal:** The repo supports **more than one LaTeX project**, each with its own master file and outputs that do not clobber other projects, with clear documentation for humans and agents.

**Depends on:** v1.0 complete  
**Requirements:** PRJ-01, PRJ-02, PRJ-03, PRJ-04

**Success criteria** (what must be TRUE):

1. A **directory convention** exists (and is written down) for projects — e.g. `projects/<name>/` with a single obvious master `.tex` per project.
2. **Build outputs** for each project are isolated (separate PDF paths or output dirs) so normal builds do not overwrite another project’s PDF.
3. **Project index** in README and/or `PROJECTS.md` lists each project, master file, and build instructions (from repo root or per project as documented).
4. **`.gitignore`** and **`AGENTS.md`** explain per-project artifacts (not only root `main.pdf`).

**Plans:** TBD

---

### Phase 5: Live PDF preview

**Goal:** While editing `.tex`, the user can keep the **PDF in a separate editor view** (tab/side) and have it **refresh after builds** using documented LaTeX Workshop settings.

**Depends on:** Phase 4 (project roots known)  
**Requirements:** PRV-01, PRV-02

**Success criteria** (what must be TRUE):

1. **Committed or documented** `.vscode` / Cursor settings enable a **non-inline** PDF viewer (separate tab or panel) for built PDFs.
2. **Documented workflow** for **refreshing** the PDF after build (e.g. auto-build on save, or build shortcut + viewer update) for the multi-project layout.
3. Optional: **SyncTeX** forward/inverse search called out if enabled — not mandatory for “done.”

**Plans:** TBD

---

## v1.0 (archived)

<details>
<summary>✅ v1.0 IDE-first LaTeX repo — SHIPPED 2026-03-25</summary>

- [x] Phase 1: Repository layout & documentation — 3/3 plans — 2026-03-25
- [x] Phase 2: Repeatable local build — 2/2 plans — 2026-03-25
- [x] Phase 3: Agent & edit conventions — 2/2 plans — 2026-03-25

</details>

## Progress

| Phase | Milestone | Plans | Status | Completed |
| ----- | --------- | ----- | ------ | --------- |
| 1. Repository layout & documentation | v1.0 | 3/3 | Complete | 2026-03-25 |
| 2. Repeatable local build | v1.0 | 2/2 | Complete | 2026-03-25 |
| 3. Agent & edit conventions | v1.0 | 2/2 | Complete | 2026-03-25 |
| 4. Multi-project layout & index | v1.1 | 0/TBD | Not started | — |
| 5. Live PDF preview | v1.1 | 0/TBD | Not started | — |
