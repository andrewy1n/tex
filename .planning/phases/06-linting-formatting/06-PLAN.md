# Phase 6: Linting & formatting — Plan

**Phase:** 6
**Goal:** Users can lint and auto-format LaTeX files using standard tools integrated with their workflow

**Requirements:** QLT-01, QLT-02, QLT-03, QLT-04

## Plan Overview

**Wave 1 (4 tasks):**
1. Create `.latexindent.yaml` configuration file with sensible defaults
2. Update `.vscode/settings.json` with latexindent formatter settings and auto-format on save
3. Update README with `## Linting` section (chktex documentation and examples)
4. Update README with `## Formatting` section (latexindent documentation and examples)

**Wave 2 (2 tasks — optional, driven by QLT-03 "on save" requirement):**
5. Add `make format` target to Makefile
6. Test end-to-end: auto-format on save works in VS Code for sample project

## Task Breakdown

### Wave 1: Core Tooling Setup

**Task 1.1: Create `.latexindent.yaml`**
- **Input:** Existing repo structure, project files in `projects/*/`
- **Output:** `.latexindent.yaml` at repo root
- **Spec:**
  - Indent level: 4 spaces
  - Environments to align: `align`, `equation`, `gather`, `tabular`
  - Line length: 120 characters (sensible default, customizable)
  - Include comments documenting each option
  - Example: proper indentation and alignment of a multi-line environment
- **Success:** File exists, valid YAML, readable by `latexindent`, includes helpful comments

**Task 1.2: Update `.vscode/settings.json` with formatter config**
- **Input:** Existing `.vscode/settings.json` from v1.1 (has LaTeX Workshop settings)
- **Output:** Updated `.vscode/settings.json` with latexindent settings
- **Spec:**
  - Add `"[latex]": { "editor.defaultFormatter": "...", "editor.formatOnSave": true }`
  - Set `latexindent.indentPars: true` (indent parameters)
  - Set `latexindent.args: ["-w"]` (write in place)
  - Document VS Code extension requirement in commit message
  - Example configuration block with comments
- **Success:** File is valid JSON, formatter extension noted in comments, user can auto-format on save

**Task 1.3: Add README `## Linting` section**
- **Input:** Current README.md from v1.1
- **Output:** Updated README with new `## Linting` section
- **Spec:**
  - Install `chktex` (homebrew, apt, etc.)
  - Command: `chktex projects/sample/main.tex`
  - Example output showing common issues (unclosed braces, non-breaking spaces)
  - Note: optional, informational tool (not auto-run)
  - Links to chktex documentation
- **Success:** Section is clear, examples work, user can immediately run chktex

**Task 1.4: Add README `## Formatting` section**
- **Input:** Current README.md (after task 1.3)
- **Output:** Updated README with new `## Formatting` section
- **Spec:**
  - Install `latexindent` (usually bundled with TeX Live, or via CPAN)
  - Reference `.latexindent.yaml` at repo root
  - Command: `latexindent -w projects/sample/main.tex` (manual) or auto-format on save (VS Code)
  - Before/after example showing indentation changes
  - Note: Works with all `projects/*/` by default
  - VS Code extension reference + settings location
- **Success:** Section is clear, examples show real before/after, user can format manually or via VS Code

### Wave 2: Integration & Verification (Optional)

**Task 2.1: Add `make format` target**
- **Input:** Existing Makefile with `pdf` and `clean` targets
- **Output:** Updated Makefile with `format` target
- **Spec:**
  - `make format PROJECT=sample` runs `latexindent -w` on `projects/$(PROJECT)/**/*.tex`
  - Default `PROJECT=sample`
  - Example: `latexindent -w projects/$(PROJECT)/**/main.tex` and any subfiles
  - Success message: "Formatted <N> files"
- **Success:** Make target exists, works with multiple projects, respects PROJECT variable

**Task 2.2: Smoke test**
- **Input:** Phase 6 completed (all tasks 1.1–1.4 done)
- **Output:** Verification that auto-format works end-to-end
- **Spec:**
  - Open `projects/sample/main.tex` in VS Code
  - Make an intentional formatting violation (bad indentation)
  - Save file → auto-format runs → file corrected
  - Verify `.latexindent.yaml` is applied (check indentation matches config)
  - Run `chktex projects/sample/main.tex` → shows output (informational)
- **Success:** Auto-format on save works, chktex runs successfully, both tools integrate

## Dependencies

- Wave 1 independent (can run in parallel)
- Wave 2 depends on Wave 1 (verification requires settings in place)

## Verification Gates

- [ ] `.latexindent.yaml` created, valid, and readable
- [ ] `.vscode/settings.json` updated with formatter settings
- [ ] README Linting section complete and clear
- [ ] README Formatting section complete and clear
- [ ] (Optional) `make format` target works
- [ ] (Optional) VS Code auto-format on save verified

## Success Criteria (from ROADMAP)

1. ✓ User can run `chktex` on any `.tex` file and receive a list of common style issues — Covered by README Linting + task 1.3
2. ✓ User can configure `latexindent` with committed `.latexindent.yaml` and run it — Covered by task 1.1 + 1.4
3. ✓ User can enable auto-formatting on save via VS Code settings — Covered by task 1.2 + 1.4
4. ✓ README documents installation, configuration, and usage — Covered by tasks 1.3 + 1.4

---

**Total effort:** 4–6 tasks, ~2–4 hours
**Risk:** Low (standard tools, no infrastructure changes)
