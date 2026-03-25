---
phase: 05-live-pdf-preview
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - .vscode/extensions.json
  - .vscode/settings.json
autonomous: true
requirements:
  - PRV-01
  - PRV-02
must_haves:
  truths:
    - "`.vscode/extensions.json` recommends `James-Yu.latex-workshop` (D-02)"
    - "`.vscode/settings.json` sets tab PDF viewer, onSave auto-build, workspace-folder builds, `projects/**/*.tex` root search, and a `latexmk` tool matching PROJECTS.md flags (D-01, D-03, D-04)"
  artifacts:
    - path: .vscode/extensions.json
      provides: "Workspace extension recommendation (D-02)"
      contains: "James-Yu.latex-workshop"
    - path: .vscode/settings.json
      provides: "LaTeX Workshop keys for viewer, auto-build, roots, tools, recipes (D-01, D-03, D-04)"
      contains: "latex-workshop.view.pdf.viewer"
---

<objective>
Commit a **minimal** workspace **`.vscode/`** configuration: **`extensions.json`** recommending LaTeX Workshop and **`settings.json`** with LaTeX Workshop keys that implement **D-01** (tab viewer), **D-03** (`onSave` auto-build), and **D-04** (build from repo root, narrow root search to `projects/`, `latexmk` tool args aligned with **PROJECTS.md**).

Purpose: Satisfies the **committed-configuration** half of **PRV-01** and the **automated build/refresh mechanism** portion of **PRV-02** before README documents the workflow.
Output: `.vscode/extensions.json`, `.vscode/settings.json`.
</objective>

<execution_context>
@$HOME/.cursor/get-shit-done/workflows/execute-plan.md
@$HOME/.cursor/get-shit-done/templates/summary.md
</execution_context>

<context>
@.planning/phases/05-live-pdf-preview/05-CONTEXT.md
@.planning/phases/05-live-pdf-preview/05-RESEARCH.md
@.planning/REQUIREMENTS.md
@PROJECTS.md
@README.md

**Locked:** D-01, D-02 (config files), D-03, D-04. **Deferred:** none. **README / WSL / SyncTeX prose:** plan **05-live-pdf-preview-02**.
</context>

<tasks>

<task type="auto">
  <name>Task 1: Add `.vscode/extensions.json` recommending LaTeX Workshop</name>
  <read_first>
    - .planning/phases/05-live-pdf-preview/05-CONTEXT.md
    - .planning/phases/05-live-pdf-preview/05-RESEARCH.md
  </read_first>
  <files>.vscode/extensions.json</files>
  <action>
    Create **`.vscode/extensions.json`** at repo root with **exactly** this JSON object (no extra keys):

    ```json
    {
      "recommendations": ["James-Yu.latex-workshop"]
    }
    ```

    This implements **D-02** (extension recommendation).
  </action>
  <verify>
    <automated>python3 -c "import json; d=json.load(open('.vscode/extensions.json')); assert d.get('recommendations')==['James-Yu.latex-workshop']"</automated>
  </verify>
  <acceptance_criteria>
    - `test -f .vscode/extensions.json` exits 0
    - `grep -q '"James-Yu.latex-workshop"' .vscode/extensions.json`
    - `grep -q '"recommendations"' .vscode/extensions.json`
    - `python3 -c "import json; json.load(open('.vscode/extensions.json'))"` exits 0 (valid JSON)
  </acceptance_criteria>
  <done>`.vscode/extensions.json` exists and recommends `James-Yu.latex-workshop` per D-02</done>
</task>

<task type="auto">
  <name>Task 2: Add `.vscode/settings.json` with LaTeX Workshop keys (viewer, auto-build, roots, latexmk tool/recipe)</name>
  <read_first>
    - .planning/phases/05-live-pdf-preview/05-CONTEXT.md
    - .planning/phases/05-live-pdf-preview/05-RESEARCH.md
    - PROJECTS.md
  </read_first>
  <files>.vscode/settings.json</files>
  <action>
    Create **`.vscode/settings.json`** with **valid JSON** (no comments) containing **at least** these keys and values — exact string values must match for grep verification:

    | Key | Value |
    |-----|--------|
    | `latex-workshop.view.pdf.viewer` | `"tab"` |
    | `latex-workshop.latex.autoBuild.run` | `"onSave"` |
    | `latex-workshop.latex.build.fromWorkspaceFolder` | `true` |
    | `latex-workshop.latex.search.rootFiles.include` | JSON array with single string **`"projects/**/*.tex"`** |
    | `latex-workshop.latex.tools` | Array with one object: `name` **`"latexmk"`**, `command` **`"latexmk"`**, `args` **`["-pdf", "-interaction=nonstopmode", "-file-line-error", "%DOC%"]`**, `env` **`{}`** |
    | `latex-workshop.latex.recipes` | Array with one object: `name` **`"latexmk (repo)"`**, `tools` **`["latexmk"]`** |
    | `latex-workshop.latex.recipe.default` | **`"latexmk (repo)"`** |

    Rationale per locked decisions: **D-01** (`tab`), **D-03** (`onSave`), **D-04** (`fromWorkspaceFolder` + `projects/**/*.tex` + `latexmk` args aligned with **PROJECTS.md** `latexmk` line: `-pdf`, `-interaction=nonstopmode`, `-file-line-error`, root path via **`%DOC%`**).

    Do **not** add unrelated editor settings.
  </action>
  <verify>
    <automated>grep -q '"latex-workshop.view.pdf.viewer": "tab"' .vscode/settings.json && grep -q '"latex-workshop.latex.autoBuild.run": "onSave"' .vscode/settings.json && grep -q '"latex-workshop.latex.build.fromWorkspaceFolder": true' .vscode/settings.json && grep -q 'projects/\*\*/\*.tex' .vscode/settings.json && grep -q '"latex-workshop.latex.recipe.default": "latexmk (repo)"' .vscode/settings.json</automated>
  </verify>
  <acceptance_criteria>
    - `grep -q '"latex-workshop.view.pdf.viewer": "tab"' .vscode/settings.json`
    - `grep -q '"latex-workshop.latex.autoBuild.run": "onSave"' .vscode/settings.json`
    - `grep -q '"latex-workshop.latex.build.fromWorkspaceFolder": true' .vscode/settings.json`
    - `grep -q '"projects/**/*.tex"' .vscode/settings.json`
    - `grep -q '"-interaction=nonstopmode"' .vscode/settings.json`
    - `grep -q '"-file-line-error"' .vscode/settings.json`
    - `grep -q '"%DOC%"' .vscode/settings.json`
    - `grep -q '"name": "latexmk (repo)"' .vscode/settings.json`
    - `python3 -c "import json; json.load(open('.vscode/settings.json'))"` exits 0
  </acceptance_criteria>
  <done>`.vscode/settings.json` encodes D-01, D-03, D-04 with the exact LaTeX Workshop keys listed in RESEARCH.md</done>
</task>

</tasks>

<verification>
  - PRV-01: committed editor settings enable non-inline PDF viewing via `latex-workshop.view.pdf.viewer` = `tab`.
  - PRV-02: `onSave` + workspace-folder `latexmk` recipe supports refresh-after-build; full user-facing workflow text ships in **05-live-pdf-preview-02**.
</verification>

<success_criteria>
  - `.vscode/extensions.json` and `.vscode/settings.json` exist and match task actions; all **acceptance_criteria** grep/python checks pass.
</success_criteria>

<output>
After completion, create `.planning/phases/05-live-pdf-preview/05-live-pdf-preview-01-SUMMARY.md`
</output>
