# Requirements: v1.2 Quality tooling & templates

**Defined:** 2026-03-27
**Milestone:** v1.2 — Quality tooling & templates
**Core Value:** Add linting, revision-tracking, and reusable templates to improve daily LaTeX authoring ergonomics.

## v1.2 Requirements (this milestone)

### Linting & formatting

- [ ] **QLT-01**: User can run `chktex` on any `.tex` file to catch common LaTeX style issues (unclosed braces, non-breaking spaces, etc.)
- [ ] **QLT-02**: User can configure and run `latexindent` to auto-format `.tex` files (indentation, spacing)
- [ ] **QLT-03**: `latexindent` runs automatically on save for all `.tex` files in the project (VS Code extension or pre-commit hook)
- [ ] **QLT-04**: Documentation in README describes how to install, configure, and use `chktex` and `latexindent`; includes sample configuration file (`.latexindent.yaml`)

### Revision tracking

- [ ] **REV-01**: User can run `latexdiff` to compare two `.tex` files on disk and generate a highlighted diff PDF
- [ ] **REV-02**: Make target (e.g., `make diff SRC=file1.tex CMP=file2.tex`) simplifies the `latexdiff` workflow
- [ ] **REV-03**: Documentation in README describes the `latexdiff` workflow, including examples and common use cases (e.g., comparing draft versions)

## Future (after v1.2)

### Templates

- **TMP-01**: Reusable template library (`templates/` directory) with CV, paper, letter, and presentation starters.

### Additional tooling

- **EDT-02**: Optional shared VS Code tasks (keyboard shortcuts, lint-on-save toggle).
- **PLT-01**: Optional CI PDF build (GitHub Actions).
- **PLT-02**: Optional devcontainer for TeX.

## Out of scope

| Feature | Reason |
|---------|--------|
| Mandatory linting or formatting enforcement | Optional; user chooses integration level |
| Web-based diff viewer | Local `latexdiff` output only |
| Version control integration (auto-diff on commit) | Manual workflow; CI optional in future |

## Traceability

| Requirement | Phase | Status |
|-------------|-------|--------|
| QLT-01 | 6 | Pending |
| QLT-02 | 6 | Pending |
| QLT-03 | 6 | Pending |
| QLT-04 | 6 | Pending |
| REV-01 | 7 | Pending |
| REV-02 | 7 | Pending |
| REV-03 | 7 | Pending |

**Coverage:**

- v1.2 requirements: 7 total
- Mapped to phases: 7 (Phase 6: 4 requirements, Phase 7: 3 requirements)
- Unmapped: 0

---

*Requirements defined: 2026-03-27*
*Roadmap created: 2026-03-27*
