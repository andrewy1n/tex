---
phase: 05-live-pdf-preview
plan: 02
type: execute
wave: 2
depends_on:
  - 05-live-pdf-preview-01
files_modified:
  - README.md
  - Makefile
  - PROJECTS.md
autonomous: true
requirements:
  - PRV-01
  - PRV-02
must_haves:
  truths:
    - "README contains section `## LaTeX Workshop (PDF preview)` with documented keys, auto-build vs manual, `% !TEX root` for partials, optional SyncTeX, and `### WSL or remote` (D-02, D-05, D-06)"
    - "README grep-verifiable strings document `latex-workshop.latex.autoBuild.run` values `onSave` and `never`, and `latex-workshop.view.pdf.viewer` including `external` as escape hatch (D-03, D-06)"
    - "`Makefile` contains a one-line comment pointing VS Code/Cursor users at `.vscode/` (Claude discretion cross-link)"
    - "`PROJECTS.md` states LaTeX Workshop recipes mirror the table’s `latexmk` lines"
  artifacts:
    - path: README.md
      provides: "Documented source of truth for PRV-01/PRV-02 + D-02 prose (D-05, D-06)"
      contains: "## LaTeX Workshop (PDF preview)"
    - path: Makefile
      provides: "Optional pointer to `.vscode/`"
      contains: ".vscode"
    - path: PROJECTS.md
      provides: "Cross-link to committed LW config vs PROJECTS.md"
      contains: "LaTeX Workshop"
---

<objective>
Extend **README.md** with a **documented** LaTeX Workshop workflow (fulfilling **D-02** documentation alongside committed `.vscode/`), including **D-03** (onSave default + how to use **`never`**), **D-04** (`% !TEX root` for partials under **`projects/sample/sections/`**), **D-05** (brief optional SyncTeX note — no blocking tuning), and **D-06** (**`### WSL or remote`**). Add **grep-verifiable** cross-links in **Makefile** (comment) and **PROJECTS.md** (one short paragraph or bullet).

Purpose: Completes **PRV-01** (“documented **and/or** committed”) and **PRV-02** (documented refresh workflow for multi-project layout) per roadmap success criteria.
Output: updated **README.md**, **Makefile**, **PROJECTS.md**; repository layout diagram in README lists **`.vscode/`**.
</objective>

<execution_context>
@$HOME/.cursor/get-shit-done/workflows/execute-plan.md
@$HOME/.cursor/get-shit-done/templates/summary.md
</execution_context>

<context>
@.planning/phases/05-live-pdf-preview/05-CONTEXT.md
@.planning/phases/05-live-pdf-preview/05-RESEARCH.md
@.planning/REQUIREMENTS.md
@README.md
@Makefile
@PROJECTS.md
@.vscode/settings.json
@projects/sample/sections/

**Depends on:** **05-live-pdf-preview-01** (README references committed keys).
</context>

<tasks>

<task type="auto">
  <name>Task 1: Replace README “Editor (optional)” with `## LaTeX Workshop (PDF preview)` and required subsections</name>
  <read_first>
    - README.md
    - .planning/phases/05-live-pdf-preview/05-CONTEXT.md
    - .planning/phases/05-live-pdf-preview/05-RESEARCH.md
    - .vscode/settings.json
  </read_first>
  <files>README.md</files>
  <action>
    1. **Remove** the existing section heading **`## Editor (optional)`** and its single short paragraph (the one ending with “Phase 5 documents…”).

    2. **Insert** a new top-level section with **exact heading** (match case and spacing):

       `## LaTeX Workshop (PDF preview)`

    3. Under it, include **prose** (not only bullet lists) that explains:
       - Open the **repository root** as the workspace folder in VS Code/Cursor (ties to **D-04** / LW root rules).
       - Committed settings live under **`.vscode/settings.json`** and recommend **`James-Yu.latex-workshop`** via **`.vscode/extensions.json`** (**D-02**).
       - These **exact setting keys** must appear in backticks in the README body so users can search the doc:
         - `` `latex-workshop.view.pdf.viewer` ``
         - `` `latex-workshop.latex.autoBuild.run` ``
         - `` `latex-workshop.latex.build.fromWorkspaceFolder` ``
         - `` `latex-workshop.latex.search.rootFiles.include` ``
       - **Auto-build default:** state that the repo sets `` `latex-workshop.latex.autoBuild.run` `` to **`onSave`** (**D-03**). Explain that saving a `.tex` file triggers `latexmk` and the PDF tab refreshes after a successful build.
       - **Manual builds:** state that users who want **no** auto-build can set `` `latex-workshop.latex.autoBuild.run` `` to **`never`** and use LaTeX Workshop’s **Build LaTeX project** command / keybinding instead (**D-03**).
       - **Partials:** include a **fenced** `tex` code block showing **`% !TEX root = ../main.tex`** as the example for editing files under **`projects/sample/sections/`** (path relative to partial → project `main.tex`) (**D-04**).
       - **SyncTeX (optional):** one short subsection with heading **`### SyncTeX (optional)`** stating that forward/inverse search works when SyncTeX is enabled in the build and the extension; do **not** promise external-viewer SyncTeX parity (**D-05**). The subsection body must contain the substring **`synctex`** (case-insensitive match OK via `grep -i`).
       - **WSL / remote:** subsection with **exact heading** **`### WSL or remote`** (**D-06**). Body must:
         - state opening the **repository root** in the editor and having **`latexmk`** / TeX on **`PATH`**;
         - include the exact key `` `latex-workshop.view.pdf.viewer` `` and the value **`external`** as the documented fallback if the internal viewer misbehaves;
         - stay short (no troubleshooting encyclopedia).

    4. Update the **`## Repository layout`** fenced tree so it includes **`.vscode/`** with **`settings.json`** and **`extensions.json`** lines (list them explicitly under **`.vscode/`**).

    5. Keep **`## Build`** and **PROJECTS.md** as the canonical **`latexmk`** command reference; do not duplicate the full `latexmk` line inside the new section except where needed for clarity (prefer pointing to **PROJECTS.md**).
  </action>
  <verify>
    <automated>grep -q '^## LaTeX Workshop (PDF preview)$' README.md && grep -q '### WSL or remote' README.md && grep -q '### SyncTeX (optional)' README.md && grep -q '% !TEX root = ../main.tex' README.md && grep -qi 'synctex' README.md</automated>
  </verify>
  <acceptance_criteria>
    - `grep -q '^## LaTeX Workshop (PDF preview)$' README.md`
    - `grep -q '### WSL or remote' README.md`
    - `grep -q '### SyncTeX (optional)' README.md`
    - `grep -q '% !TEX root = ../main.tex' README.md`
    - `grep -q 'latex-workshop.view.pdf.viewer' README.md`
    - `grep -q 'latex-workshop.latex.autoBuild.run' README.md`
    - `grep -q 'latex-workshop.latex.build.fromWorkspaceFolder' README.md`
    - `grep -q 'latex-workshop.latex.search.rootFiles.include' README.md`
    - `grep -q 'onSave' README.md`
    - `grep -q 'never' README.md`
    - `grep -q 'external' README.md`
    - `grep -q '\.vscode/settings.json' README.md`
    - `grep -q '\.vscode/extensions.json' README.md`
    - `grep -q 'projects/sample/sections' README.md`
    - `grep -q 'settings.json' README.md` and `grep -q 'extensions.json' README.md` both exit 0
    - `! grep -q '^## Editor (optional)$' README.md` (old section removed)
  </acceptance_criteria>
  <done>README documents PRV-01/PRV-02 workflow with exact headings and grep-verifiable keys per D-02, D-03, D-04, D-05, D-06</done>
</task>

<task type="auto">
  <name>Task 2: Cross-link `Makefile` and `PROJECTS.md` to committed LaTeX Workshop config</name>
  <read_first>
    - Makefile
    - PROJECTS.md
    - README.md
  </read_first>
  <files>Makefile; PROJECTS.md</files>
  <action>
    1. **`Makefile`:** After the **`.PHONY:`** line (or at the top comment block if you add one), add **one comment line** that:
       - mentions **VS Code** or **Cursor**;
       - points readers to **`.vscode/`** for LaTeX Workshop integration.

       Example shape (executor may adjust wording; **acceptance** is grep-based):

       `# VS Code/Cursor: see .vscode/ for LaTeX Workshop workspace settings.`

    2. **`PROJECTS.md`:** After the introductory paragraph (before or after the table), add **one short paragraph** that:
       - states that **LaTeX Workshop** recipes in **`.vscode/settings.json`** use **`latexmk`** with the same intent as the **`latexmk`** commands in the table (repo root cwd, explicit **`projects/<name>/main.tex`** paths);
       - includes the literal substring **`.vscode/settings.json`**.

    Do **not** change **`make pdf`** / table commands unless a path is factually wrong.
  </action>
  <verify>
    <automated>grep -q '\.vscode' Makefile && grep -q 'LaTeX Workshop' PROJECTS.md && grep -q '\.vscode/settings.json' PROJECTS.md</automated>
  </verify>
  <acceptance_criteria>
    - `grep -qE '^#.*\.vscode' Makefile || grep -q '\.vscode/' Makefile`
    - `grep -q 'LaTeX Workshop' PROJECTS.md`
    - `grep -q '.vscode/settings.json' PROJECTS.md`
  </acceptance_criteria>
  <done>Makefile and PROJECTS.md reference `.vscode` so agents and humans find the committed LW config</done>
</task>

</tasks>

<verification>
  - PRV-01: README + committed `.vscode/` together satisfy “documented and/or committed.”
  - PRV-02: README explains save-triggered rebuild and manual-`never` alternative; points to **PROJECTS.md** for `latexmk` parity with recipes.
</verification>

<success_criteria>
  - All **acceptance_criteria** in Task 1–2 pass; README subsection headings and key strings match exactly where specified.
</success_criteria>

<output>
After completion, create `.planning/phases/05-live-pdf-preview/05-live-pdf-preview-02-SUMMARY.md`
</output>
