# Roadmap: tex — v1.2 Quality tooling & templates

LaTeX linting, formatting, and revision tracking for improved daily authoring ergonomics.

## Phases

- [ ] **Phase 6: Linting & formatting** - `chktex` linting and `latexindent` formatting with docs and optional auto-run
- [ ] **Phase 7: Revision tracking** - `latexdiff` workflow with Make integration and documentation

## Phase Details

### Phase 6: Linting & formatting

**Goal**: Users can lint and auto-format LaTeX files using standard tools integrated with their workflow

**Depends on**: Phase 5 (committed LaTeX Workshop configuration)

**Requirements**: QLT-01, QLT-02, QLT-03, QLT-04

**Success Criteria** (what must be TRUE):
1. User can run `chktex` on any `.tex` file and receive a list of common style issues (unclosed braces, spacing problems, etc.)
2. User can configure `latexindent` with a committed `.latexindent.yaml` config and run it to auto-format files
3. User can enable auto-formatting on save via VS Code settings or pre-commit hook, with documentation describing both approaches
4. README documents how to install, configure, and use both `chktex` and `latexindent` with clear examples

**Plans**: TBD

### Phase 7: Revision tracking

**Goal**: Users can compare two LaTeX documents and generate highlighted diff PDFs for revision workflows

**Depends on**: Phase 6 (linting/formatting established)

**Requirements**: REV-01, REV-02, REV-03

**Success Criteria** (what must be TRUE):
1. User can run `latexdiff` command-line to compare two `.tex` files and generate a highlighted diff PDF
2. User can use a Make target (e.g., `make diff SRC=file1.tex CMP=file2.tex`) to simplify the `latexdiff` workflow
3. README documents the `latexdiff` workflow with examples of common use cases (comparing draft versions, tracking changes)

**Plans**: TBD

## Progress

| Phase | Plans Complete | Status | Completed |
|-------|----------------|--------|-----------|
| 6. Linting & formatting | 0/? | Not started | — |
| 7. Revision tracking | 0/? | Not started | — |

---

**Generated:** 2026-03-27
**Milestone:** v1.2 — Quality tooling & templates
**Coverage:** 7/7 requirements mapped
