# Requirements: tex

**Defined:** 2025-03-25  
**Core Value:** Any `.tex` in the repo is editable in the IDE and readable/writable by agents, with a simple shared way to compile when a PDF is needed.

## v1 Requirements

### Repository & layout

- [x] **REPO-01**: User can determine which file to compile from the README or from a single obvious root `.tex` (or a documented `% !TeX root` convention for multi-file projects)
- [x] **REPO-02**: `.tex` sources, figures, and bibliography inputs live in a predictable folder layout described in the README
- [x] **REPO-03**: A TeX-oriented `.gitignore` excludes auxiliary and log files; the repo documents whether PDFs or other generated artifacts are tracked or ignored
- [x] **REPO-04**: README states local prerequisites (e.g. TeX distribution), names the main TeX file, and summarizes the directory layout

### Build

- [ ] **BLD-01**: User can produce the document PDF using one documented command (for example `latexmk` or `make`) on a fresh clone when a normal local TeX install is present

### Agents & conventions

- [ ] **AGT-01**: A short convention document (dedicated `AGENTS.md` or a README section) specifies the master file, the build command, and expectations for automated edits (for example: do not commit aux files; preserve `%` line continuations)

## v2 Requirements

### Editor integration

- **EDT-01**: Shared Cursor/VS Code tasks or settings so the same build recipe is one shortcut away for the team (optional LaTeX Workshop alignment)

### Quality & platform

- **QLT-01**: Optional local lint or format scripts (`chktex`, `latexindent`, etc.) documented for contributors  
- **PLT-01**: Optional CI job that compiles the PDF on push (pass/fail or artifact), without making CI mandatory for daily work  
- **PLT-02**: Optional devcontainer or documented Docker image for reproducible TeX installs

## Out of Scope

| Feature | Reason |
|---------|--------|
| Overleaf-style hosted editor or real-time co-authorship | Explicitly out of scope in PROJECT.md; Git + IDE workflow only |
| Mandatory CI for every push in v1 | Deferred until local ergonomics are proven; may appear in v2 |
| Enforcing one global TeX distribution for all developers | Local install assumed; optional devcontainer is a later enhancement |
| Pinning every package version in-repo | Unless the project later needs reproducible paper builds; not required for workspace v1 |

## Traceability

Which phases cover which requirements. Updated during roadmap creation.

| Requirement | Phase | Status |
|-------------|-------|--------|
| REPO-01 | 1 | Complete |
| REPO-02 | 1 | Complete |
| REPO-03 | 1 | Complete |
| REPO-04 | 1 | Complete |
| BLD-01 | 2 | Pending |
| AGT-01 | 3 | Pending |

**Coverage:**

- v1 requirements: 6 total  
- Mapped to phases: 6  
- Unmapped: 0 ✓

---
*Requirements defined: 2025-03-25*  
*Last updated: 2025-03-25 after roadmap creation*
