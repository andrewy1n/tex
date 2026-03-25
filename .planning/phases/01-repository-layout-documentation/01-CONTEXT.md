# Phase 1: Repository layout & documentation - Context

**Gathered:** 2025-03-25  
**Status:** Ready for planning

<domain>
## Phase Boundary

Deliver a clear **compile root**, **predictable folder layout**, a **TeX-oriented `.gitignore`** with an explicit **artifact policy**, and a **README** that names prerequisites, the main `.tex` file, and the layout—so a human or agent can orient without tribal knowledge. Does **not** include the build command implementation (Phase 2) or `AGENTS.md` (Phase 3).

</domain>

<decisions>
## Implementation Decisions

### Master file & repository tree
- **D-01:** Use a **single primary compile root** at the repository root: `main.tex` (name fixed unless renamed once in README).
- **D-02:** Standard folders: `figures/` for images, `bib/` for bibliography files (or a single `references.bib` at root—planner picks one convention and README documents it); optional `sections/` or `chapters/` for `\input`/`\include` partials when the document grows.
- **D-03:** **v1 is one document per repo**, not a multi-paper `papers/<name>/` monorepo. If multiple papers are needed later, that becomes a new milestone or backlog item—not Phase 1 scope creep.

### Artifact policy (PDFs & generated files)
- **D-04:** **Ignore** LaTeX auxiliary files (`.aux`, `.log`, `.out`, `.toc`, `.synctex.gz`, etc.) and **ignore the built output PDF** produced next to `main.tex` (or under an agreed output dir once Phase 2 adds it).
- **D-05:** **Figure PDFs** used as sources may live under `figures/` and **may be tracked** when they are part of the source material; README states that tracked PDFs are intentional sources, not build outputs.
- **D-06:** README includes a short **“What we track vs ignore”** bullet so REPO-03 is explicit without reading `.gitignore` line-by-line.

### README depth & audience
- **D-07:** **Short README** for v1: purpose one-liner, **name of main `.tex` file**, **ASCII or markdown tree** of top-level layout, **one-line prerequisite** (e.g. “TeX Live or equivalent with `latexmk`”), and **link to TeX Live** (or distro-neutral) install docs—not a full WSL tutorial unless you add it later as a subsection.
- **D-08:** Optional **Cursor/VS Code** note: one line pointing to LaTeX Workshop as optional; no obligation to document every extension setting in Phase 1.

### `.gitignore` baseline
- **D-09:** Start from the **standard GitHub `TeX.gitignore`** pattern set (or equivalent comprehensive TeX ignore list), then **only** add narrow exceptions (e.g. `!figures/**/*.pdf`) if figure PDFs must be tracked.
- **D-10:** Do **not** hand-roll a minimal ignore list from scratch—reduces missed aux patterns and matches research/PITFALLS guidance.

### Claude's Discretion
- Exact README section headings and wording; whether bibliography is `bib/references.bib` vs root `references.bib`; small naming (`figures/` vs `fig/`); optional one-line “clone → open in Cursor” blurb.

</decisions>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### Planning scope & requirements
- `.planning/PROJECT.md` — Vision, editor-first scope, out-of-scope (Overleaf, mandatory CI v1)
- `.planning/REQUIREMENTS.md` — REPO-01 through REPO-04 acceptance text
- `.planning/ROADMAP.md` — Phase 1 goal, success criteria, requirements mapping

### Research & hygiene rationale
- `.planning/research/SUMMARY.md` — Stack and repo-hygiene implications
- `.planning/research/ARCHITECTURE.md` — Typical LaTeX-in-git layout and build-flow separation
- `.planning/research/PITFALLS.md` — Aux files, wrong compile root, PDF/binary policy

### External (informative, not vendored in repo)
- [GitHub TeX.gitignore](https://raw.githubusercontent.com/github/gitignore/main/TeX.gitignore) — baseline ignore patterns (pin a commit or date in README if reproducibility matters)

No separate ADRs in-repo yet—requirements and research above are the contract.

</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable Assets
- None—repository is greenfield for LaTeX sources (only `.planning/` and `.cursor/rules` exist today).

### Established Patterns
- None in application/source tree; follow decisions and canonical refs above.

### Integration Points
- Phase 2 will add the **documented build command** that assumes this layout; Phase 3 will reference the same **master file** and paths in `AGENTS.md` or README.

</code_context>

<specifics>
## Specific Ideas

- User wants this repo to behave **like Overleaf** only as **versioned project storage**—layout should make any `.tex` easy to open in Cursor and for agents to target without guessing the master file.

</specifics>

<deferred>
## Deferred Ideas

- **Multi-paper layout** (`papers/<name>/`) — future milestone if needed
- **Full WSL/PATH cookbook** — optional README subsection later, not Phase 1 gate
- **CI / devcontainer** — v2+ per PROJECT.md

</deferred>

---

*Phase: 01-repository-layout-documentation*  
*Context gathered: 2025-03-25*
