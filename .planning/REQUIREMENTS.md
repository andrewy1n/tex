# Requirements: tex

**Defined:** 2026-03-25  
**Milestone:** v1.1 — Multi-project workspace & live PDF  
**Core Value:** Any `.tex` in the repo is editable in the IDE and readable/writable by agents, with a simple shared way to compile when you need a PDF — extended with multiple isolated LaTeX projects and a separate PDF preview while editing.

## v1.1 Requirements (this milestone)

### Multi-project layout

- [x] **PRJ-01**: The repository defines a **documented convention** for multiple LaTeX projects (e.g. `projects/<project-name>/` each with its own master `.tex`, figures, and bibliography assets as needed). — **Done in Phase 4**
- [x] **PRJ-02**: **Each project builds independently** — running the documented build for one project does not overwrite another project’s PDF/output under normal use (distinct output paths or names are specified). — **Done in Phase 4**
- [x] **PRJ-03**: A **project index** (README section and/or `PROJECTS.md`) lists each project, its **master file**, and **how to build** it from the repo. — **Done in Phase 4**
- [x] **PRJ-04**: **`.gitignore`** and **`AGENTS.md`** (or equivalent docs) describe **per-project** build products (PDF, aux, logs), not only a single root `main.pdf`. — **Done in Phase 4**

### Live PDF preview (editor)

- [ ] **PRV-01**: **Documented and/or committed editor configuration** so the user can open the **built PDF in a separate view** (e.g. editor tab or side panel — not only viewing PDF inside the same buffer as source).
- [ ] **PRV-02**: **Documented workflow** so the PDF **updates after a build** (e.g. auto-build on save and/or explicit build + viewer refresh), appropriate for this repo’s multi-project layout.

## Future (after v1.1)

### Editor integration

- **EDT-02**: Optional shared tasks beyond LaTeX Workshop defaults (team shortcuts, lint-on-save).

### Quality & platform

- **QLT-01**: Optional `chktex` / `latexindent` documentation.
- **PLT-01**: Optional CI PDF build.
- **PLT-02**: Optional devcontainer for TeX.

## Out of scope

| Feature | Reason |
|--------|--------|
| Hosted web editor or real-time co-authoring (Overleaf product) | Still editor + git; v1.1 only adds **local** multi-project layout and IDE PDF viewing |
| Mandatory CI | Optional later |
| Pinning a single global TeX distribution | Local install assumed |

## Traceability

| Requirement | Phase | Status |
|-------------|-------|--------|
| PRJ-01 | 4 | Complete |
| PRJ-02 | 4 | Complete |
| PRJ-03 | 4 | Complete |
| PRJ-04 | 4 | Complete |
| PRV-01 | 5 | Pending |
| PRV-02 | 5 | Pending |

**Coverage:**

- v1.1 requirements: 6 total  
- Mapped to phases: 6  
- Unmapped: 0 ✓

---
*Requirements defined: 2026-03-25*  
*Last updated: 2026-03-25 — PRJ-01–PRJ-04 validated after Phase 4*
