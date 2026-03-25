# Phase 5: Live PDF preview - Context

**Gathered:** 2026-03-25  
**Status:** Ready for planning

<domain>
## Phase Boundary

Deliver **PRV-01** and **PRV-02**: **LaTeX Workshop**–oriented setup so that while editing `.tex` under **`projects/<name>/`**, the user can view the **built PDF in a separate editor surface** (not the source buffer alone) and follow a **documented workflow** so the PDF **updates after builds**, consistent with **per-project masters** and **repo-root `latexmk`** commands from **`PROJECTS.md`**.

**Out of scope:** Hosted/web editor, CI, pinning TeX distributions, or changing Phase 4’s **`projects/<name>/main.tex`** + colocated **`main.pdf`** layout.

</domain>

<decisions>
## Implementation Decisions

### PDF viewer placement (PRV-01)
- **D-01:** Use LaTeX Workshop’s **built-in PDF viewer in a separate editor tab** (not inline in the `.tex` buffer). **Rationale:** Matches “separate tab or side view” in requirements; simplest cross-platform story with LW defaults.

### Config delivery (PRV-01)
- **D-02:** **Commit** a **minimal** **`.vscode/`** workspace config: at least **`settings.json`** with LaTeX Workshop keys needed for multi-project behavior and viewer placement; add **`.vscode/extensions.json`** recommending **`James-Yu.latex-workshop`**. **Also** extend **`README.md`** (Editor / LaTeX Workshop section) so users who override locally still have a **documented** source of truth—satisfies “documented **and/or** committed.”

### Build refresh (PRV-02)
- **D-03:** Default **auto-build on save** for LaTeX (`latex-workshop.latex.autoBuild.run` → **`onSave`**) so saving a source file triggers a build and the viewer can refresh. **Document** how to switch to **manual** builds only (e.g. **`never`**) for users who want less background compilation.

### Root file / multi-project resolution
- **D-04:** **Recipes** should invoke **`latexmk`** with the **same effective intent** as **`PROJECTS.md`** (explicit path to **`projects/<name>/main.tex`**, repo root as cwd). **Root discovery:** Configure LaTeX Workshop so **`projects/**/main.tex`** files are treated as **roots** (search/include globs or equivalent LW mechanism—exact keys left to research/plan). **Partials:** Document **`% !TeX root`** pointing at that project’s **`main.tex`** when editing **`sections/`** (or other) partials if the IDE does not infer the master—align with existing **`projects/sample/`** structure.

### SyncTeX (optional per roadmap)
- **D-05:** **Optional polish, not required for “done.”** Briefly **document** in README: forward/inverse search works when SyncTeX is enabled in the build and LW; **do not** block phase completion on tuning SyncTeX. **Planner discretion:** whether to add **`-synctex=1`** (or equivalent) via **`.latexmkrc`** if not already implied by the local toolchain.

### Platform notes (WSL / Linux)
- **D-06:** Add a **short** README subsection (e.g. “WSL or remote”) covering: open the **repository root** in the editor, ensure **`latexmk`** / TeX **on `PATH`**, and **if** the internal PDF viewer misbehaves on a given setup, point to switching **`latex-workshop.view.pdf.viewer`** (e.g. **external** viewer) per LaTeX Workshop docs—without turning the repo into a full troubleshooting guide.

### Claude's Discretion
- Exact **LaTeX Workshop** setting names and values as extension versions evolve (as long as behavior matches D-01–D-04).
- **README** subsection titles and depth of optional SyncTeX detail.
- Whether **`Makefile`** gains a **note** pointing VS Code users at `.vscode/` (optional cross-link only).

</decisions>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### Requirements and roadmap
- `.planning/REQUIREMENTS.md` — **PRV-01**, **PRV-02**
- `.planning/ROADMAP.md` — Phase 5 goal and success criteria (including optional SyncTeX call-out)
- `.planning/PROJECT.md` — v1.1 scope, LaTeX Workshop + split PDF decision

### Prior phase contracts
- `.planning/phases/04-multi-project-layout-index/04-CONTEXT.md` — **`projects/<name>/main.tex`**, colocated **`main.pdf`**, **`PROJECTS.md`** build lines, Phase 5 integration note

### Research
- `.planning/research/SUMMARY.md` — LaTeX Workshop viewer, auto-build, multi-root pitfalls, WSL

### Repo surfaces to update or add
- `README.md` — Editor / PDF workflow, optional WSL note, SyncTeX optional
- `PROJECTS.md` — remain canonical for **`latexmk`** lines (LW recipes should stay consistent)
- **New:** `.vscode/settings.json`, `.vscode/extensions.json` (per D-02)
- `.latexmkrc` — possible SyncTeX flag (planner discretion, D-05)

</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable assets
- **`PROJECTS.md`** — Per-project **`latexmk`** commands from repo root; LW recipes should mirror these paths/flags.
- **`.latexmkrc`** — Shared `pdflatex` invocation; LW/`latexmk` builds should stay aligned with Phase 2 behavior.
- **`README.md`** — Already points to Phase 5 for PDF preview; expand with concrete settings and workflow.

### Established patterns
- **Canonical build** remains **`latexmk`** from **repository root** with explicit **`projects/<name>/main.tex`** (Phase 2 + 4).
- **No** `.vscode/` in repo yet—Phase 5 introduces it.

### Integration points
- **`projects/sample/`** — Use as the **concrete example** in docs (open `main.tex`, build, PDF next to master).
- **`.gitignore`** — Already ignores **`projects/**/main.pdf`** and aux files; no change required for Phase 5 unless docs need a cross-reference.

</code_context>

<specifics>
## Specific Ideas

- User asked to discuss **all** scoped gray areas (viewer, config delivery, auto-build, root resolution, SyncTeX, WSL notes). Decisions above use **LaTeX Workshop** as the integration point per **PROJECT.md** and research, with **tab** viewer and **onSave** auto-build as the default UX unless README documents overrides.

</specifics>

<deferred>
## Deferred Ideas

None — discussion stayed within phase scope.

</deferred>

---

*Phase: 05-live-pdf-preview*  
*Context gathered: 2026-03-25*
