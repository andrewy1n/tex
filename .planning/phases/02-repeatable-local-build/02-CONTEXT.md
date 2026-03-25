# Phase 2: Repeatable local build - Context

**Gathered:** 2026-03-25  
**Status:** Ready for planning

> **Session note:** Context was captured in **single-turn** mode (no interactive gray-area multi-select in chat). Decisions below are **recommended defaults** aligned with Phase 1 (`01-CONTEXT.md`), README, BLD-01, and ROADMAP Phase 2. **Edit this file** before `/gsd-plan-phase 2` if you want a different engine, a `make`-first workflow, or no `.latexmkrc`.

<domain>
## Phase Boundary

Deliver **one documented primary command** that produces **`main.pdf`** from **`main.tex`** on a **fresh clone** when a normal local TeX distribution is installed. Document **working directory** expectations. **Out of scope:** CI, devcontainers, pinning TeX versions, multi-document builds, and agent-facing prose (Phase 3).

</domain>

<decisions>
## Implementation Decisions

### Primary build command (BLD-01)
- **D-11:** The **single primary** documented command is **`latexmk`** driving **`main.tex`** at the repository root. Canonical invocation for docs and scripts:  
  `latexmk -pdf -interaction=nonstopmode -file-line-error main.tex`  
  (from repo root). This matches the README prerequisite line that Phase 2 would document `latexmk`.
- **D-12:** **Working directory:** run commands from the **repository root** (where `main.tex` lives). README must state this explicitly.
- **D-13:** Commit a **`.latexmkrc`** (or equivalent `latexmk` project config) so the same flags/engine are reproducible without relying on shell history. Defaults: **`pdflatex`** engine, PDF output, non-stop mode; suitable for the current minimal `article` in `main.tex`.
- **D-14:** **Optional `Makefile`** is allowed **only** as a thin wrapper (e.g. `make pdf`) that invokes the **same** `latexmk` line as **D-11**—not a parallel divergent recipe. If the Makefile is omitted, **`latexmk` alone** satisfies BLD-01.

### Documentation surface
- **D-15:** Add a **“Build”** (or **“Compile”**) section to **`README.md`** that states the **exact** primary command, that TeX Live/MiKTeX/MacTeX must be installed first, and that the command is run from repo root. No separate `BUILD.md` unless planner splits for length—default is README-only.

### Engine & future switches
- **D-16:** Default engine **`pdflatex`** through `latexmk`. Switching to `xelatex`/`lualatex` is **out of band** for this phase unless a one-line `latexmkrc` comment documents how to change `$pdf_mode` / engine—no requirement to support those engines in verification for Phase 2.

### Claude's Discretion
- Exact `.latexmkrc` syntax and variable names; whether a **`Makefile`** is added or omitted; minor README wording; optional **`-silent`** vs verbose for local UX.

</decisions>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### Requirements & roadmap
- `.planning/REQUIREMENTS.md` — **BLD-01** (one documented command; `latexmk` or `make` exemplar)
- `.planning/ROADMAP.md` — Phase 2 goal, success criteria, dependency on Phase 1
- `.planning/PROJECT.md` — Core value, local TeX on developer machine, optional CI later

### Prior phase contract
- `.planning/phases/01-repository-layout-documentation/01-CONTEXT.md` — `main.tex` compile root (D-01), artifact paths (D-04, D-05), README role
- `.planning/phases/01-repository-layout-documentation/01-VERIFICATION.md` — Phase 1 verification (establishes baseline tree)

### Repo files that define the build target
- `main.tex` — entry document
- `README.md` — will gain the build section in this phase
- `.gitignore` — `main.pdf` ignored at root; build must still produce it locally

### Research (informative)
- `.planning/research/STACK.md` — Tooling notes if present
- `.planning/research/PITFALLS.md` — Common LaTeX-in-git pitfalls

No external ADRs in-repo beyond the above.

</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable assets
- `main.tex` — minimal `article`; no bibliography wiring yet; build should succeed with `pdflatex`/`latexmk` without extra packages beyond base TeX.

### Established patterns
- **No** `Makefile`, **no** `.latexmkrc` yet—Phase 2 introduces them per decisions above.
- Root-level PDF output matches `.gitignore` `/main.pdf` rule.

### Integration points
- README “Build” section replaces the Phase 1 placeholder (“exact build command will be documented in Phase 2”).
- Phase 3 `AGENTS.md` will later point at the same command/README section—keep wording stable and copy-paste friendly.

</code_context>

<specifics>
## Specific Ideas

- User wants **Overleaf-like** behavior only as **versioned project storage**; the build must be **one obvious command** from a clean clone, not a tribal script.

</specifics>

<deferred>
## Deferred Ideas

- **CI job** compiling PDF — v2 / PROJECT.md Out of Scope for v1
- **Devcontainer / Docker** for TeX — v2+ optional
- **`xelatex`/`lualatex` as default** — only if document needs grow; not required for Phase 2 verification

</deferred>

---

*Phase: 02-repeatable-local-build*  
*Context gathered: 2026-03-25*
