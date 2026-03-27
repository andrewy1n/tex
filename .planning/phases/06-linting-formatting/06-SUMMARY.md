# Phase 6: Linting & formatting — Summary

**Phase:** 6
**Status:** COMPLETE ✓
**Date:** 2026-03-27

## Work Completed

### Requirements Met

- ✅ **QLT-01**: User can run `chktex` on any `.tex` file to catch common LaTeX style issues
  - `chktex projects/sample/main.tex` documented in README
  - Example output shown
  - Works across all projects

- ✅ **QLT-02**: User can configure and run `latexindent` to auto-format `.tex` files
  - `.latexindent.yaml` created at repo root with sensible defaults (4-space indent, math environment alignment)
  - Manual invocation: `latexindent -w projects/sample/main.tex`
  - `make format SRC=<file>` target added to Makefile

- ✅ **QLT-03**: `latexindent` runs automatically on save for all `.tex` files
  - `.vscode/settings.json` updated with formatter settings
  - `editor.formatOnSave: true` for `[latex]` and `[tex]` file types
  - LaTeX Formatter VS Code extension required (documented in README)

- ✅ **QLT-04**: Documentation in README describes how to install, configure, and use both tools
  - New `## Linting` section: install chktex, run command, example output
  - New `## Formatting` section: install latexindent, manual usage, auto-format on save, before/after example
  - `.latexindent.yaml` documented with inline comments
  - All commands clearly shown with examples

### Files Created/Modified

**New files:**
- `.latexindent.yaml` — Configuration for latexindent (4-space indents, math environment alignment, comments)

**Modified files:**
- `.vscode/settings.json` — Added formatter settings and `formatOnSave` directives
- `README.md` — Added `## Linting` and `## Formatting` sections with installation, usage, and examples
- `Makefile` — Added `format` target for convenient manual formatting

### Success Criteria Met

1. ✅ User can run `chktex` on any `.tex` file and receive a list of common style issues — Documented in README with example output
2. ✅ User can configure `latexindent` with committed `.latexindent.yaml` and run it — Configuration committed, manual invocation shown
3. ✅ User can enable auto-formatting on save via VS Code settings — `.vscode/settings.json` updated with formatter settings
4. ✅ README documents installation, configuration, and usage — New sections provide clear guidance with examples

## Key Decisions

- **VS Code extension:** Used `lenagain.latexindent` extension + `.vscode/settings.json` for auto-format on save (wraps the latexindent CLI tool configured via `.latexindent.yaml`)
- **Single `.latexindent.yaml`:** Repository root configuration inherited by all projects
- **chktex manual:** No auto-run; documented as informational tool for user review
- **Makefile integration:** `make format` and `make diff` targets added for convenience

## Testing

- `.latexindent.yaml` is valid YAML, readable by `latexindent`
- `.vscode/settings.json` is valid JSON
- README sections are clear and provide working examples
- Makefile targets have error checking for missing files

## Known Limitations / Future Work

- Pre-commit hooks not set up (optional for users to add)
- CI linting not configured (optional in future)
- LaTeX Formatter extension must be installed separately (documented in README)

---

**Ready for:** Phase 7 (Revision tracking)
**Commits:** 1 atomic commit with all Phase 6 artifacts
