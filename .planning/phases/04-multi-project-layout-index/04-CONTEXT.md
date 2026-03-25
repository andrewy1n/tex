# Phase 4: Multi-project layout & index - Context

**Gathered:** 2026-03-25  
**Status:** Ready for planning

<domain>
## Phase Boundary

The repo supports **more than one LaTeX project**, each under **`projects/<name>/`** with its own **`main.tex`**, **non-colliding** build outputs (`main.pdf` per project), and **documented** layout for humans and agents: **`.gitignore`**, **`AGENTS.md`**, **`README.md`**, and a **project index** (`PROJECTS.md`). **Out of scope:** LaTeX Workshop / PDF preview settings (Phase 5); CI; devcontainers.

**Migration:** The current root-level sample (`main.tex`, `figures/`, `bib/`, `sections/` as applicable) moves into **`projects/sample/`**; the repo root no longer holds a master `.tex` after this phase’s implementation.

</domain>

<decisions>
## Implementation Decisions

### Project tree and master naming (PRJ-01)
- **D-21:** **Convention:** each project lives in **`projects/<project-name>/`**. Document naming rules (e.g. **lowercase kebab-case** short names).
- **D-22:** **Master file:** each project **`projects/<name>/main.tex`** is the single obvious compile root for that project. Non-`main.tex` masters are **out of scope** for this milestone unless added later with explicit index + `% !TeX root` policy; do not plan for them in Phase 4 unless execution uncovers a hard requirement.

### Legacy root migration (PRJ-01, PRJ-02)
- **D-23:** **Move** existing **`main.tex`**, **`figures/`**, **`bib/`**, **`sections/`** (if present) into **`projects/sample/`**. Do **not** duplicate a full copy at repo root; root holds **docs + tooling** (e.g. `README.md`, `AGENTS.md`, `Makefile`, `.latexmkrc`, `.gitignore`) only.
- **D-24:** **`projects/sample`** is the **reference layout** for new projects: same subfolders (`figures/`, `bib/`, etc.) as today’s documented tree, nested under the project folder.

### Build outputs and isolation (PRJ-02)
- **D-25:** **Output placement:** each project builds **`main.pdf`** **next to** that project’s **`main.tex`** (colocated, same model as v1.0 root).
- **D-26:** **`.gitignore`:** ignore **project-built** PDFs **`projects/**/main.pdf`** (or equivalent) and preserve **exceptions** for intentional figure PDFs under **`projects/**/figures/**/*.pdf`** (mirror prior **`!figures/**/*.pdf`** intent for the new paths).
- **D-27:** **Documented build from repo root:** canonical commands use **`latexmk`** with an **explicit path** to the master, e.g.  
  `latexmk -pdf -interaction=nonstopmode -file-line-error projects/sample/main.tex`  
  (working directory = repository root), aligned with Phase 2’s “from repo root” story.
- **D-28:** **Root `.latexmkrc`** remains shared defaults for `latexmk`; **per-project `.latexmkrc`** only if needed.

### Project index and documentation (PRJ-03, PRJ-04)
- **D-29:** Add **`PROJECTS.md`** as the **canonical table**: each row = project name, path to master **`.tex`**, and **copy-paste build command** from repo root.
- **D-30:** **`README.md`:** add/update a **multi-project** overview (layout + link to **`PROJECTS.md`**); keep **Build** as the place for **exact** commands (or clearly point to **`PROJECTS.md`** for per-project lines without duplicating policy in two places).
- **D-31:** **`AGENTS.md`:** describe **multi-project** compile roots and **`projects/`**; **do not** paste full `latexmk` blocks—**pointer** to **`README.md`** **Build** and/or **`PROJECTS.md`** (extends Phase 3 **D-19**).
- **D-32:** **`AGENTS.md`** and **`.gitignore`** (comments as needed) state **per-project** ignore targets ( **`projects/**/main.pdf`**, aux patterns) **not only** root **`/main.pdf`**.

### Claude's Discretion
- Exact **`PROJECTS.md`** table formatting and column headers; **Makefile** shape (single generic target vs per-project `TARGET=`) as long as it wraps the same **`latexmk`** lines as docs; **README** section order; **whether** a tiny **`projects/sample/README.md`** stub is added; minor **`.gitignore`** comment wording.

</decisions>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### Requirements and roadmap
- `.planning/REQUIREMENTS.md` — **PRJ-01** through **PRJ-04** (v1.1 multi-project)
- `.planning/ROADMAP.md` — Phase 4 goal and success criteria
- `.planning/PROJECT.md` — v1.1 milestone, editor-first scope, `projects/` decision

### Prior phase contracts
- `.planning/phases/01-repository-layout-documentation/01-CONTEXT.md` — `figures/`, `bib/`, artifact policy (adapt paths under `projects/<name>/`)
- `.planning/phases/02-repeatable-local-build/02-CONTEXT.md` — primary **`latexmk`** invocation, README **Build** as canonical command surface
- `.planning/phases/03-agent-edit-conventions/03-CONTEXT.md` — **`AGENTS.md`** by reference to README; no duplicate command blocks

### Research
- `.planning/research/SUMMARY.md` — `projects/` layout, output collisions, `.gitignore` generalization, migration note for root `main.tex`

### Repo files to update or align
- `README.md` — layout + Build; link **`PROJECTS.md`**
- `AGENTS.md` — multi-project roots + pointers
- `.gitignore` — per-project **`main.pdf`** and figure exceptions
- `Makefile` — align with multi-project **`latexmk`** (see discretion)
- `.latexmkrc` — shared defaults

</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable assets
- **`Makefile`** — `make pdf` runs **`latexmk`** on **`main.tex`** at repo root today; must change to target **`projects/sample/main.tex`** (or a parameterized wrapper) after migration.
- **`.latexmkrc`** — sets **`pdflatex`** / nonstop mode; applies when **`latexmk`** runs on a project path under **`projects/`** from repo root.
- **`README.md`**, **`AGENTS.md`** — single-root story; **Build** and **layout** tree need updates for **`projects/`** and **`PROJECTS.md`**.

### Established patterns
- **Canonical build** is **`latexmk`** + **`README.md`** **Build** section (Phase 2–3).
- **Root **`/main.pdf`**** in **`.gitignore`** today; Phase 4 generalizes to **`projects/**/main.pdf`** (and keeps figure-PDF exceptions).

### Integration points
- Physical move of **`main.tex`**, **`figures/`**, **`bib/`**, **`sections/`** → **`projects/sample/`**; any relative `\input`/`\bibliography` paths must remain valid or be updated in the same change.
- Phase 5 will assume **project roots** under **`projects/`** for LaTeX Workshop.

</code_context>

<specifics>
## Specific Ideas

- User confirmed **all** discuss-phase recommendations: **`projects/<name>/main.tex`**, migrate current sample to **`projects/sample/`**, colocated **`main.pdf`** with **`projects/**/main.pdf`** ignore rules, **`PROJECTS.md`** + README pointer, builds documented from repo root with explicit paths.

</specifics>

<deferred>
## Deferred Ideas

None — discussion stayed within phase scope.

</deferred>

---

*Phase: 04-multi-project-layout-index*  
*Context gathered: 2026-03-25*
