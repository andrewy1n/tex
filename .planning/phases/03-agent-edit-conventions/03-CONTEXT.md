# Phase 3: Agent & edit conventions - Context

**Gathered:** 2026-03-25  
**Status:** Ready for planning

<domain>
## Phase Boundary

Deliver **one explicit human+agent contract** for **compile root**, **how to build** (by reference to the existing README), and **safe automation expectations**—via a dedicated **`AGENTS.md`** plus small integration points in **README** and **`.cursor/rules`**. **Out of scope:** changing the build recipe itself (Phase 2), CI/lint/devcontainer (v2+), or expanding README Build content beyond a pointer to it from `AGENTS.md`.

</domain>

<decisions>
## Implementation Decisions

### Documentation surface (AGT-01)
- **D-17:** Add a dedicated **`AGENTS.md`** at the **repository root** as the primary convention document. **`README.md`** gets a **short pointer** to `AGENTS.md` (one line or a very small subsection)—not a second full copy of the agent contract.

### Relationship to `.cursor/rules`
- **D-18:** Keep existing **GSD / stack / profile** content in **`.cursor/rules`** as-is. Add **only a short pointer** to **`AGENTS.md`** for LaTeX-specific agent editing expectations—**do not** duplicate a long LaTeX rule set inside `.cursor/rules` (single source of truth: `AGENTS.md`).

### Build command echo (single source of truth)
- **D-19:** In **`AGENTS.md`**, describe the build **by reference only**: point to **`README.md`** and the **Build** section (e.g. markdown heading `## Build` / fragment `#build`). **Do not** paste the full `latexmk` / `make` blocks into `AGENTS.md`; README remains the canonical place for exact commands and flags.

### Automation / edit expectations (depth)
- **D-20:** State **roadmap-minimum** automation expectations: **do not commit** LaTeX auxiliary/log/synctex noise; **preserve `%` line continuations** where they matter; **do not commit** root **`main.pdf`** (ignored build output per project policy). No expanded checklist (no UTF-8 policy, `\input` boundary rules, or “run latexmk after edits” as mandatory prose in v1 unless planner adds them later as optional notes—**not** required by this context).

### Claude's Discretion
- Exact `AGENTS.md` section titles and ordering; exact README placement and wording of the pointer; whether the README link uses a file path or `#build` anchor; minor tone (imperative vs neutral).

</decisions>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### Requirements & roadmap
- `.planning/REQUIREMENTS.md` — **AGT-01** (convention doc: master file, build, automation expectations)
- `.planning/ROADMAP.md` — Phase 3 goal, success criteria, dependency on Phase 2
- `.planning/PROJECT.md` — Core value, editor-first scope, v1 constraints

### Prior phase contracts
- `.planning/phases/01-repository-layout-documentation/01-CONTEXT.md` — `main.tex` compile root, `bib/`, `figures/`, artifact policy
- `.planning/phases/02-repeatable-local-build/02-CONTEXT.md` — primary `latexmk` invocation, README Build as canonical command surface, Makefile as thin wrapper

### Repo files to align with
- `README.md` — **Build** section (canonical commands); **Main file** section
- `main.tex` — documented compile root / master file
- `.gitignore` — ignored aux files and root `main.pdf`
- `Makefile` — `make pdf` wraps same `latexmk` as README
- `.latexmkrc` — project defaults referenced from README
- `.cursor/rules` — existing injected content; **only** add pointer per **D-18**

</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable assets
- **`README.md`** — already documents **primary `latexmk` command**, **`make pdf`**, working directory (repo root), and **`main.tex`** as compile root; `AGENTS.md` should reference this rather than duplicating.
- **`Makefile`** / **`.latexmkrc`** — implementation detail for humans; agents follow README + `AGENTS.md` policy.

### Established patterns
- **Single primary build story** in README (Phase 2); **`AGENTS.md`** extends with **agent-specific** hygiene and pointers, not a parallel build spec.
- **`main.tex`** already mentions build via `README.md` in body text—keep mental model consistent: README is the build manual.

### Integration points
- New **`AGENTS.md`** at repo root; **`README.md`** gains a visible link; **`.cursor/rules`** gains a minimal “see `AGENTS.md`” LaTeX/agent note.

</code_context>

<specifics>
## Specific Ideas

- User chose **minimal** edit-expectations depth (**4a**): stay at roadmap success-criteria level unless a later phase expands contributor policy.

</specifics>

<deferred>
## Deferred Ideas

None — discussion stayed within phase scope.

</deferred>

---

*Phase: 03-agent-edit-conventions*  
*Context gathered: 2026-03-25*
