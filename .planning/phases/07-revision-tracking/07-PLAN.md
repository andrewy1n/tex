# Phase 7: Revision tracking — Plan

**Phase:** 7
**Goal:** Users can compare two LaTeX documents and generate highlighted diff PDFs for revision workflows

**Requirements:** REV-01, REV-02, REV-03

## Plan Overview

**Wave 1 (3 tasks):**
1. Add `make diff` target to Makefile
2. Update README with `## Revision Tracking` section
3. Create example workflow documentation

## Task Breakdown

### Wave 1: Revision Tracking Setup

**Task 1.1: Add `make diff` target to Makefile**
- **Input:** Existing Makefile with `pdf` and `clean` targets
- **Output:** Updated Makefile with `diff` target
- **Spec:**
  - Signature: `make diff SRC=<file1> CMP=<file2> [PROJECT=<name>]`
  - Default `PROJECT=sample` if not specified
  - Validate that both SRC and CMP files exist before running
  - Run `latexdiff --flatten $SRC $CMP > diff.tex`
  - Compile diff with `latexmk -pdf -outdir=projects/$(PROJECT)/build diff.tex`
  - Output: `projects/$(PROJECT)/build/diff-<timestamp>.pdf`
  - Error handling: Clear message if SRC or CMP missing
- **Success:** Make target works, generates diff PDF with changes highlighted

**Task 1.2: Add README `## Revision Tracking` section**
- **Input:** Current README.md (after Phase 6)
- **Output:** Updated README with new `## Revision Tracking` section
- **Spec:**
  - Install `latexdiff` (bundled with TeX Live or via package manager)
  - Basic workflow: Save version, make edits, compare
  - Command: `make diff SRC=draft-v1.tex CMP=main.tex`
  - Explain output PDF shows inserted text (highlighted) and deleted text (struck through)
  - Example use case: comparing draft versions before submitting
  - Common variations: `make diff SRC=projects/sample/v1/main.tex CMP=projects/sample/v2/main.tex`
  - Note: Works with any `.tex` files on disk, not tied to git
- **Success:** Section is clear, examples show realistic workflows, user can immediately use `make diff`

**Task 1.3: Create example diff workflow (optional)**
- **Input:** Phase 6 completed (linting/formatting in place)
- **Output:** Example files or demonstration in docs
- **Spec:**
  - Create a simple example: `projects/sample/example-v1.tex` and `example-v2.tex` with intentional differences
  - Show `make diff SRC=example-v1.tex CMP=example-v2.tex` producing a diff PDF
  - Document the output: what changes appear highlighted
  - Optional: Include before/after snippet in README to give user visual reference
- **Success:** Example is clear, user can see real diff output before using tool on their own files

## Dependencies

- Task 1.1 independent (update Makefile)
- Task 1.2 depends on 1.1 (document the Make target)
- Task 1.3 optional, depends on 1.1 and 1.2 (verification)

## Verification Gates

- [ ] `make diff SRC=... CMP=...` target works
- [ ] README Revision Tracking section complete and clear
- [ ] (Optional) Example files or documentation with sample diff output

## Success Criteria (from ROADMAP)

1. ✓ User can run `latexdiff` to compare two `.tex` files and generate a highlighted diff PDF — Covered by task 1.1
2. ✓ User can use a Make target to simplify the workflow — Covered by task 1.1 + 1.2
3. ✓ README documents the `latexdiff` workflow with examples — Covered by task 1.2 + 1.3

---

**Total effort:** 3 tasks (2–3 hours)
**Risk:** Low (standard tool, no infrastructure changes, no dependencies on Phase 6)
**Depends on:** Phase 6 (conceptually, for sequential execution; technically independent)
