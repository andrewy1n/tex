# Phase 6: Linting & formatting - Context

**Gathered:** 2026-03-27
**Status:** Ready for planning
**Mode:** Auto-generated (--auto mode)

<domain>

## Phase Boundary

**Goal:** Users can lint and auto-format LaTeX files using standard tools integrated with their workflow.

**Requirements (QLT-01 through QLT-04):**
- QLT-01: User can run `chktex` to catch common LaTeX style issues
- QLT-02: User can configure and run `latexindent` to auto-format `.tex` files
- QLT-03: `latexindent` runs automatically on save
- QLT-04: Documentation in README + sample `.latexindent.yaml` configuration

**Success Criteria:**
1. User can run `chktex` on any `.tex` file and receive a list of common style issues
2. User can configure `latexindent` with a committed `.latexindent.yaml` config and run it to auto-format files
3. User can enable auto-formatting on save via VS Code settings or pre-commit hook
4. README documents installation, configuration, and usage with clear examples

</domain>

<decisions>

## Implementation Decisions

### Auto-formatting: VS Code extension (recommended)

**Decision:** Implement auto-formatting via VS Code extension (`latexindent` extension) + committed workspace settings in `.vscode/settings.json`.

**Why:** Matches existing v1.1 pattern (committed LaTeX Workshop settings); works per-project; no pre-commit dependency; user can toggle via settings.

**How to apply:** Configure `.vscode/settings.json` with `latexindent.path` and `latexindent.args`, set `editor.formatOnSave: true` for LaTeX files (scoped).

### Configuration file: `.latexindent.yaml` in repo root

**Decision:** Single `.latexindent.yaml` at repo root, inherited by all projects under `projects/`.

**Why:** Consistent formatting across all LaTeX files in the repo; simpler than per-project config.

**How to apply:** Create `.latexindent.yaml` with sensible defaults (indent by 4 spaces, align environments). Commit to repo.

### chktex: Manual invocation + documentation

**Decision:** Document `chktex` as a manual CLI tool; no auto-run on save. Users can run via Make target or terminal.

**Why:** `chktex` output is informational (not auto-fixable); adding a linter extension adds complexity. Manual is sufficient for a personal repo.

**How to apply:** Add `README ## Linting` section with `chktex projects/sample/main.tex` example. No VS Code extension required.

### Scope: Single phase

**Decision:** Both `chktex` and `latexindent` in Phase 6. Revision tracking (`latexdiff`) deferred to Phase 7.

**Why:** Linting and formatting are tightly coupled (both improve file quality); `latexdiff` is distinct (revision tracking, not daily authoring).

### Out of Scope

- Pre-commit hook setup (optional — users can add if desired)
- CI linting (optional later)
- Mandatory enforcement (linting is optional per user preference)

</decisions>

<code_context>

## Existing Code Insights

**Committed settings pattern:** v1.1 established `.vscode/settings.json` with LaTeX Workshop config. Phase 6 extends this with formatter settings.

**Makefile:** Existing `make pdf` and `make clean` targets. Phase 6 can add `make format` if useful.

**README structure:** v1.0–v1.1 documented build, multi-project, and PDF preview. Phase 6 adds `## Linting` and `## Formatting` sections.

**`.gitignore`:** Existing pattern ignores `*.log`, `*.aux`, etc. No changes needed for linting/formatting tooling.

</code_context>

<specifics>

## Specific Ideas

1. **`.latexindent.yaml` defaults:** Use 4-space indents, align environments (`align`, `equation`, etc.), optional per-project overrides via comments.

2. **Make target:** Add `make format` that runs `latexindent -w` on all `.tex` files in the current project.

3. **README sections:**
   - `## Linting` — Install `chktex`, run `chktex projects/<name>/main.tex`
   - `## Formatting` — Configure `.latexindent.yaml`, enable auto-format on save in VS Code

4. **Sample output:** Show example `chktex` warnings and `latexindent` before/after in README.

</specifics>

<deferred>

## Deferred Ideas

- Pre-commit hooks (users can add if desired)
- CI linting checks (Phase 7 / v1.3)
- Automatic CI formatting (separate concern)
- LaTeX-specific spell check (`cspell`; future phase)

</deferred>
