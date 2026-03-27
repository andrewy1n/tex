# Phase 7: Revision tracking - Context

**Gathered:** 2026-03-27
**Status:** Ready for planning
**Mode:** Auto-generated (--auto mode)

<domain>

## Phase Boundary

**Goal:** Users can compare two LaTeX documents and generate highlighted diff PDFs for revision workflows.

**Requirements (REV-01 through REV-03):**
- REV-01: User can run `latexdiff` to compare two `.tex` files on disk and generate a highlighted diff PDF
- REV-02: Make target (e.g., `make diff SRC=file1.tex CMP=file2.tex`) simplifies the workflow
- REV-03: Documentation in README describes the `latexdiff` workflow with examples

**Success Criteria:**
1. User can run `latexdiff` command-line to compare two `.tex` files and generate a highlighted diff PDF
2. User can use a Make target to simplify the `latexdiff` workflow
3. README documents the `latexdiff` workflow with examples of common use cases

**Depends on:** Phase 6 (linting/formatting established as the quality baseline)

</domain>

<decisions>

## Implementation Decisions

### Primary use case: Compare file versions on disk

**Decision:** Implement `make diff SRC=file1.tex CMP=file2.tex` Make target. Optional git-based diff workflow noted in README but not primary.

**Why:** User indicated file-based comparison as primary use case; aligns with local-first, repo-agnostic workflow.

**How to apply:** Add Make target that invokes `latexdiff $SRC $CMP > diff.tex && latexmk -pdf -outdir=build diff.tex`.

### Output location: `build/diff-<timestamp>.pdf`

**Decision:** Generate diff PDF in `build/` directory alongside project PDFs, with timestamp to avoid collisions.

**Why:** Keeps artifacts isolated from sources; timestamp allows multiple diffs without overwriting.

**How to apply:** Use `date +%s` in Make target to generate unique filenames.

### Scope: File-based diff only

**Decision:** No git-based diff (e.g., commit-to-commit) in Phase 7. If user wants git integration later, that's a Phase 8 / v1.3 candidate.

**Why:** File-based covers the primary use case; simpler documentation and workflow. Git-based adds complexity without immediate need.

### Documentation: README section + examples

**Decision:** Add `## Revision Tracking` section in README with:
- How to install `latexdiff`
- Simple `make diff SRC=... CMP=...` example
- Example output showing tracked changes (inserted/deleted text highlighted)
- Common workflow: save draft, make edits, run diff to see changes

**Why:** Matches existing README structure (Build, LaTeX Workshop, etc.); provides clear entry point for users.

### Out of Scope

- Web-based diff viewer
- Git integration (optional later)
- Auto-diff on commit hooks
- Diff for non-LaTeX files (focus on `.tex`)

</decisions>

<code_context>

## Existing Code Insights

**Makefile structure:** Existing `pdf` and `clean` targets accept `PROJECT` variable. Phase 7 adds `diff` target that also respects `PROJECT` for per-project builds.

**Build output:** Existing `projects/<name>/build/` directory collects PDFs and artifacts. Phase 7 diffs also land in `build/`.

**README:** v1.0–v1.1 documented build, projects, and PDF preview. Phase 7 adds revision tracking documentation.

**LaTeX Workshop:** v1.1 set up PDF preview. Phase 7 doesn't require changes to editor config.

</code_context>

<specifics>

## Specific Ideas

1. **Make target signature:** `make diff SRC=<file1> CMP=<file2> [PROJECT=<name>]`
   - If `PROJECT` not specified, assume `sample`
   - Validate both files exist before running `latexdiff`

2. **Latexdiff invocation:** `latexdiff --flatten $SRC $CMP > diff.tex` then compile with `latexmk`
   - `--flatten` imports packages to avoid external dependencies
   - Output goes to `projects/$PROJECT/build/diff-$(date +%s).pdf`

3. **README example:**
   ```
   ## Revision Tracking

   Use `latexdiff` to compare two versions of your LaTeX document.

   **Install:** `brew install latexdiff` (macOS) or `apt-get install latexdiff` (Linux)

   **Usage:** `make diff SRC=projects/sample/draft-v1.tex CMP=projects/sample/draft-v2.tex`

   Output: `projects/sample/build/diff-<timestamp>.pdf` highlighting all changes.
   ```

4. **Common workflow example:**
   - Save current document as `v1.tex`
   - Make edits (e.g., `main.tex`)
   - Run `make diff SRC=v1.tex CMP=main.tex`
   - Review highlighted diff PDF for changes

</specifics>

<deferred>

## Deferred Ideas

- Git-based diff (commit-to-commit, branch-to-branch)
- CI/CD integration (auto-generate diffs on PR)
- Word/character-level diff granularity options
- Diff for `.bib` and other file types
- Web-based diff viewer

</deferred>
