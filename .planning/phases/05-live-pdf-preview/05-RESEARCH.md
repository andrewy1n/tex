# Phase 5: Live PDF preview - Research

**Researched:** 2026-03-25  
**Domain:** VS Code / Cursor + LaTeX Workshop (`James-Yu.latex-workshop`), multi-root `latexmk`, workspace settings  
**Confidence:** HIGH (official LaTeX Workshop wiki Compile + View pages, last edited 2026-03-25 per wiki)

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions

**PDF viewer placement (PRV-01)**  
- **D-01:** Use LaTeX Workshop’s **built-in PDF viewer in a separate editor tab** (not inline in the `.tex` buffer). **Rationale:** Matches “separate tab or side view” in requirements; simplest cross-platform story with LW defaults.

**Config delivery (PRV-01)**  
- **D-02:** **Commit** a **minimal** **`.vscode/`** workspace config: at least **`settings.json`** with LaTeX Workshop keys needed for multi-project behavior and viewer placement; add **`.vscode/extensions.json`** recommending **`James-Yu.latex-workshop`**. **Also** extend **`README.md`** (Editor / LaTeX Workshop section) so users who override locally still have a **documented** source of truth—satisfies “documented **and/or** committed.”

**Build refresh (PRV-02)**  
- **D-03:** Default **auto-build on save** for LaTeX (`latex-workshop.latex.autoBuild.run` → **`onSave`**) so saving a source file triggers a build and the viewer can refresh. **Document** how to switch to **manual** builds only (e.g. **`never`**) for users who want less background compilation.

**Root file / multi-project resolution**  
- **D-04:** **Recipes** should invoke **`latexmk`** with the **same effective intent** as **`PROJECTS.md`** (explicit path to **`projects/<name>/main.tex`**, repo root as cwd). **Root discovery:** Configure LaTeX Workshop so **`projects/**/main.tex`** files are treated as **roots** (search/include globs or equivalent LW mechanism—exact keys left to research/plan). **Partials:** Document **`% !TeX root`** pointing at that project’s **`main.tex`** when editing **`sections/`** (or other) partials if the IDE does not infer the master—align with existing **`projects/sample/`** structure.

**SyncTeX (optional per roadmap)**  
- **D-05:** **Optional polish, not required for “done.”** Briefly **document** in README: forward/inverse search works when SyncTeX is enabled in the build and LW; **do not** block phase completion on tuning SyncTeX. **Planner discretion:** whether to add **`-synctex=1`** (or equivalent) via **`.latexmkrc`** if not already implied by the local toolchain.

**Platform notes (WSL / Linux)**  
- **D-06:** Add a **short** README subsection (e.g. “WSL or remote”) covering: open the **repository root** in the editor, ensure **`latexmk`** / TeX **on `PATH`**, and **if** the internal PDF viewer misbehaves on a given setup, point to switching **`latex-workshop.view.pdf.viewer`** (e.g. **external** viewer) per LaTeX Workshop docs—without turning the repo into a full troubleshooting guide.

### Claude's Discretion

- Exact **LaTeX Workshop** setting names and values as extension versions evolve (as long as behavior matches D-01–D-04).
- **README** subsection titles and depth of optional SyncTeX detail.
- Whether **`Makefile`** gains a **note** pointing VS Code users at `.vscode/` (optional cross-link only).

### Deferred Ideas (OUT OF SCOPE)

None — discussion stayed within phase scope.
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|------------------|
| **PRV-01** | Documented and/or committed editor configuration so the user can open the **built PDF in a separate view** (tab/side panel — not only inline in the source buffer). | `latex-workshop.view.pdf.viewer` default **`tab`** ([View wiki](https://github.com/James-Yu/LaTeX-Workshop/wiki/View)); optional `latex-workshop.view.pdf.tab.editorGroup` for which editor group hosts the tab; committed `.vscode/settings.json` + `.vscode/extensions.json` per D-02. |
| **PRV-02** | Documented workflow so the PDF **updates after a build** (auto-build on save and/or explicit build + refresh), appropriate for multi-project layout. | `latex-workshop.latex.autoBuild.run`: **`onSave`** vs **`never`** vs **`onFileChange`** ([Compile wiki](https://github.com/James-Yu/LaTeX-Workshop/wiki/Compile)); internal viewer reloads after successful project builds; `latex-workshop.refresh-viewer` for manual refresh; align recipes with **`PROJECTS.md`** + **`latex-workshop.latex.build.fromWorkspaceFolder`**. |
</phase_requirements>

## Summary

Phase 5 wires **Cursor/VS Code** to this repo’s **multi-project** layout (`projects/<name>/main.tex`, builds from **repository root** per **PROJECTS.md**). The standard integration is **LaTeX Workshop**: it provides build recipes (default **`latexmk`** toolchain), an **internal PDF viewer** (PDF.js) in an editor **tab** by default, and auto-build triggers. Locked decisions commit **`.vscode/settings.json`** and **`.vscode/extensions.json`**, set **auto-build on save**, and document **README** + WSL/external-viewer escape hatches.

**Primary recommendation:** Commit workspace settings that (1) set **`latex-workshop.view.pdf.viewer`** to **`tab`**, (2) set **`latex-workshop.latex.autoBuild.run`** to **`onSave`**, (3) set **`latex-workshop.latex.build.fromWorkspaceFolder`** to **`true`** so **`latexmk`** runs with the same **cwd** as **PROJECTS.md** (repo root), (4) narrow root discovery with **`latex-workshop.latex.search.rootFiles.include`** (e.g. `projects/**/*.tex`), (5) define a **`latexmk`** tool whose **`args`** mirror **`PROJECTS.md`** (`-pdf`, `-interaction=nonstopmode`, `-file-line-error`, and **`%DOC%`** as the root path without extension—per [Compile placeholders](https://github.com/James-Yu/LaTeX-Workshop/wiki/Compile#placeholders)). Document **`% !TEX root`** for partials and optional **`never`** / external viewer for users who prefer less automation.

## Project Constraints (from .cursor/rules/)

Actionable items embedded in `.cursor/rules` (GSD stack / project metadata):

- **Editor:** Cursor/VS Code — normal file-based editing.
- **Build:** Local TeX toolchain (`latexmk`, `pdflatex`, …) on the machine; **LaTeX Workshop** is the recommended VS Code integration (`James-Yu.latex-workshop`).
- **Do not** rely on Overleaf as the primary compiler for this git-first repo.
- **Do not** commit generated PDFs, `.aux`, `.log`, `.synctex.gz` by default (aligns with **AGENTS.md** / `.gitignore`).
- **Prefer** `latexmk` over hand-run single-pass `pdflatex` in docs/scripts.
- **MiKTeX:** document **Perl** requirement if using default `latexmk` recipes ([Install wiki](https://github.com/James-Yu/LaTeX-Workshop/wiki/Install)).
- **`.vscode/settings.json`:** appropriate for when IDE **PATH** differs from shell (Remote-WSL/SSH)—relevant to D-06.

## Standard Stack

### Core

| Component | Version / ID | Purpose | Why Standard |
|-----------|----------------|---------|----------------|
| **LaTeX Workshop** | Marketplace ID **`James-Yu.latex-workshop`** (version churn—pin in team docs if needed) | Builds, PDF tab viewer, SyncTeX hooks | Dominant VS Code/Cursor LaTeX integration; defaults to **`latexmk`** ([Compile wiki](https://github.com/James-Yu/LaTeX-Workshop/wiki/Compile)). |
| **latexmk** | Ships with TeX Live / MiKTeX | Drives multi-pass builds | Same command as **PROJECTS.md** and **Makefile**; LW’s default **`latexmk`** tool uses **Perl**. |
| **pdflatex** (via `.latexmkrc`) | Repo sets `$pdf_mode = 1` and nonstop **`-interaction=nonstopmode -file-line-error`** | PDF output | Shared with CLI builds (**README** / **Makefile**). |

### Supporting

| Item | Purpose | When to Use |
|------|---------|-------------|
| **`% !TEX root = …`** magic comment | Forces root file when editing **`sections/*.tex`** | When LW’s static **`\input`/`\include`** graph does not resolve the master ([Compile — Multi File projects](https://github.com/James-Yu/LaTeX-Workshop/wiki/Compile#multi-file-projects)). Requires **`latex-workshop.latex.build.enableMagicComments`** (default **true**). |
| **`latex-workshop.view.pdf.tab.editorGroup`** | Which editor group opens the PDF tab | Optional: side-by-side layout (D-01: “tab or side”). |
| **`latex-workshop.refresh-viewer`** command | Manual PDF refresh | If auto-refresh feels laggy; tune **`latex-workshop.latex.watch.pdf.delay`** (default 250 ms) per [View wiki](https://github.com/James-Yu/LaTeX-Workshop/wiki/View). |

### Alternatives Considered

| Instead of | Could Use | Tradeoff |
|------------|-----------|----------|
| Internal tab viewer | **`latex-workshop.view.pdf.viewer`: `external`** | D-06: escape hatch when internal viewer misbehaves (WSL/remote); SyncTeX with external viewers is **not officially supported** and has known regressions per mid-2025 [View wiki](https://github.com/James-Yu/LaTeX-Workshop/wiki/View) — document honestly, don’t promise parity. |
| **`onSave`** auto-build | **`onFileChange`** (default upstream) | **`onFileChange`** rebuilds when dependencies change (including outside VS Code); more builds. **D-03** locks **`onSave`** as repo default. |
| LW recipes | **External build** (`latex-workshop.latex.external.build.*`) | Bypasses root detection—overkill if recipes + **`fromWorkspaceFolder`** suffice. |

**Installation (editors):** Install extension **`James-Yu.latex-workshop`** from the VS Code Marketplace (or rely on **`.vscode/extensions.json`** “Show Recommended Extensions”).

**Version verification:** Extension versions are **not** npm packages; check [Marketplace — LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop) or the Extensions panel for the installed version. **latexmk:** `latexmk -v` after TeX install.

## Architecture Patterns

### Recommended repo surfaces (Phase 5 deliverables)

```
.
├── .vscode/
│   ├── settings.json    # LaTeX Workshop: viewer, autoBuild, recipes, tools, root search, fromWorkspaceFolder
│   └── extensions.json  # recommendation: James-Yu.latex-workshop
├── README.md            # Editor / PDF workflow, optional WSL, optional SyncTeX, manual vs auto-build
├── PROJECTS.md          # Canonical latexmk lines (recipes must stay consistent)
└── .latexmkrc           # Shared pdflatex flags; optional SyncTeX tweak (planner discretion, D-05)
```

### Pattern 1: Build from workspace folder (matches PROJECTS.md cwd)

**What:** Set **`latex-workshop.latex.build.fromWorkspaceFolder`** to **`true`** so the recipe runs from the **workspace folder** (repo root), not only from the root `.tex` directory. **If false**, the recipe runs from the directory containing the root file ([Compile wiki](https://github.com/James-Yu/LaTeX-Workshop/wiki/Compile#latex-workshoplatexbuildfromworkspacefolder)).

**When to use:** Anytime **`PROJECTS.md`** documents `latexmk … projects/<name>/main.tex` from repo root (this repo).

### Pattern 2: Narrow root search to `projects/`

**What:** Set **`latex-workshop.latex.search.rootFiles.include`** to globs relative to the workspace folder, e.g. **`["projects/**/*.tex"]`**, instead of default **`["**/*.tex"]`**. Optionally **`latex-workshop.latex.search.rootFiles.exclude`** for noise paths ([Compile wiki](https://github.com/James-Yu/LaTeX-Workshop/wiki/Compile#latex-workshoplatexsearchrootfilesinclude)).

**When to use:** Multiple masters under **`projects/<name>/`**; reduces root-detection work and clarifies which trees are LaTeX projects.

### Pattern 3: `latexmk` tool args aligned with PROJECTS.md + placeholders

**What:** Define **`latex-workshop.latex.tools`** entry with **`command`: `latexmk`** and **`args`** including **`-pdf`**, **`-interaction=nonstopmode`**, **`-file-line-error`**, and **`%DOC%`** (root path **without extension**). Placeholders documented in [Compile — placeholders](https://github.com/James-Yu/LaTeX-Workshop/wiki/Compile#placeholders).

**Example (illustrative—planner fills exact JSON):**

```json
"latex-workshop.latex.tools": [
  {
    "name": "latexmk",
    "command": "latexmk",
    "args": [
      "-pdf",
      "-interaction=nonstopmode",
      "-file-line-error",
      "%DOC%"
    ],
    "env": {}
  }
]
```

**Note:** Upstream default **`latexmk`** tool adds **`-synctex=1`** and **`-outdir=%OUTDIR%`**. This repo’s **README** build line omits explicit **`-synctex`** in the shell example; LW’s stock tool includes it. **D-05:** optional alignment with **`.latexmkrc`** / documented SyncTeX—planner decides whether to mirror README exactly or keep **`-synctex=1`** for editor SyncTeX.

**WSL note:** On WSL calling Windows TeX, **`command`** may need **`latexmk.exe`** ([Compile wiki — WSL](https://github.com/James-Yu/LaTeX-Workshop/wiki/Compile)).

### Anti-Patterns to Avoid

- **Opening only a subfolder** of the repo: LW requires opening a folder that contains the **whole** project ([Compile — root file](https://github.com/James-Yu/LaTeX-Workshop/wiki/Compile#the-root-file)).
- **Relying on macros for `\input` paths:** Static parser cannot follow user-defined include macros—use **`% !TEX root`** or flatten includes for reliable root detection.
- **Expecting external-viewer SyncTeX** to “just work”:** Treat as best-effort; point users to internal tab viewer for supported SyncTeX per current wiki.

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| PDF preview in-editor | Custom webview / iframe hacks | LaTeX Workshop internal viewer + **`latex-workshop.view.pdf.viewer`** | PDF.js integration, reload on build, maintained keybindings |
| Build orchestration | Shell-only docs without LW integration | LW **recipes** + **`autoBuild`** | Consistent root detection, dependency watching, TeX badge UX |
| Multi-master discovery | One global `rootFile` path in settings for all projects | **`search.rootFiles.include`** + per-file **`% !TEX root`** | Matches how LW discovers roots ([Compile wiki](https://github.com/James-Yu/LaTeX-Workshop/wiki/Compile)) |

**Key insight:** LaTeX Workshop already implements root discovery, watching, and PDF refresh—Phase 5 is **configuration + documentation**, not a custom preview stack.

## Common Pitfalls

### Pitfall 1: Root file not found when editing a partial

**What goes wrong:** Build/view commands no-op or target wrong master.

**Why it happens:** Partial **`sections/foo.tex`** lacks **`\documentclass`**; LW may not link it to **`main.tex`** if static parsing misses the include chain.

**How to avoid:** Document **`% !TEX root = relative/path/to/main.tex`** (with **`enableMagicComments`** true). Command **`latex-workshop.addtexroot`** helps insert the comment ([Compile wiki](https://github.com/James-Yu/LaTeX-Workshop/wiki/Compile#the-root-file)).

**Warning signs:** Status bar / logs mention “root file” ambiguity.

### Pitfall 2: PDF not updating despite successful build

**What goes wrong:** Stale PDF or viewer not refreshing.

**Why it happens:** Binary PDF writes can emit multiple file-system events; very large PDFs may need a higher **`latex-workshop.latex.watch.pdf.delay`** ([View wiki](https://github.com/James-Yu/LaTeX-Workshop/wiki/View)).

**How to avoid:** Ensure build completes successfully (viewer reloads after successful builds for project-linked PDFs); use **`latex-workshop.refresh-viewer`** if needed.

### Pitfall 3: `onSave` builds on every save including “no-op” saves

**What goes wrong:** User wants save without compile.

**Why it happens:** **D-03** sets default **`onSave`**.

**How to avoid:** Document FAQ pattern: use **`never`** for **`latex-workshop.latex.autoBuild.run`**, or editor “save without format/build” flows—link [FAQ — save without building](https://github.com/James-Yu/LaTeX-Workshop/wiki/FAQ#I-use-build-on-save-but-I-occasionally-want-to-save-without-building) from README.

### Pitfall 4: Default LW **`onFileChange`** vs locked **`onSave`**

**What goes wrong:** Users expect upstream default behavior.

**Why it happens:** Upstream default for **`latex-workshop.latex.autoBuild.run`** is **`onFileChange`**, not **`onSave`** ([Compile wiki](https://github.com/James-Yu/LaTeX-Workshop/wiki/Compile#latex-workshoplatexautobuildrun)).

**How to avoid:** README must state the repo **overrides** to **`onSave`** per **D-03** and how to restore **`onFileChange`** if desired.

## Code Examples

### PDF viewer: tab (PRV-01)

```json
"latex-workshop.view.pdf.viewer": "tab"
```

Source: [LaTeX Workshop Wiki — View](https://github.com/James-Yu/LaTeX-Workshop/wiki/View) (default is **`tab`**; set explicitly for documentation clarity).

### Auto-build on save (PRV-02)

```json
"latex-workshop.latex.autoBuild.run": "onSave"
```

Source: [LaTeX Workshop Wiki — Compile](https://github.com/James-Yu/LaTeX-Workshop/wiki/Compile#latex-workshoplatexautobuildrun).

### Extension recommendation

```json
{
  "recommendations": ["James-Yu.latex-workshop"]
}
```

Source: VS Code [extension manifest recommendations](https://code.visualstudio.com/docs/editor/extension-marketplace#_workspace-recommended-extensions) + Marketplace ID [James-Yu.latex-workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop).

### Partial file root (sample layout)

```tex
% !TEX root = ../main.tex
```

Adjust relative path from `projects/sample/sections/` to `projects/sample/main.tex`. Source: [Compile — magic comment](https://github.com/James-Yu/LaTeX-Workshop/wiki/Compile#the-root-file).

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| Single root `main.tex` at repo root | **`projects/<name>/main.tex`** + index in **PROJECTS.md** | Phase 4 | LW must use **workspace-relative** roots and repo-root **`latexmk`** |
| Manual **`latexmk`** only | LW **`onSave`** + tab PDF | Phase 5 | Faster edit-preview loop for IDE users |

**Deprecated/outdated:** None identified for this phase scope; re-verify **external SyncTeX** claims against latest [View wiki](https://github.com/James-Yu/LaTeX-Workshop/wiki/View) before expanding docs.

## Open Questions

1. **Should custom `latexmk` args omit `-synctex=1` to match README one-liner exactly, or keep LW’s default `-synctex=1`?**
   - What we know: README shell example does not pass **`-synctex`** explicitly; LW’s stock **`latexmk`** tool includes **`-synctex=1`**.
   - What’s unclear: Whether project wants identical argv vs better SyncTeX UX.
   - Recommendation: **D-05** — prefer documenting SyncTeX behavior; planner can either inherit default LW tool or customize—either way README states the fact.

2. **Per-project recipes vs one generic `latexmk` recipe?**
   - What we know: **PROJECTS.md** currently lists one project (`sample`); more rows may appear later.
   - What’s unclear: Whether to add named recipes per project before a second project exists.
   - Recommendation: One **`latexmk`** recipe + root discovery is enough for **N** masters under **`projects/**`**; add **`%!LW recipe=…`** or extra recipes only if users need distinct toolchains.

## Environment Availability

| Dependency | Required By | Available | Version | Fallback |
|------------|-------------|-----------|---------|----------|
| **VS Code or Cursor** | LaTeX Workshop host | ✓ | VS Code 1.112.0 / Cursor 2.6.21 (this WSL session) | — |
| **latexmk** + TeX distro | Builds, PRV-02 | ✗ (not on `PATH` in probe) | — | Install TeX Live / MiKTeX per README; WSL users may use Windows TeX + **`latexmk.exe`** |
| **Perl** | Default `latexmk` (MiKTeX especially) | Not probed | — | Install Perl or document non-`latexmk` recipe per MiKTeX FAQ |

**Missing dependencies with no fallback:**

- **`latexmk` / TeX** — users cannot verify PRV-02 locally until installed.

**Missing dependencies with fallback:**

- None for *documentation* work; implementation verification requires a machine with TeX.

**Step 2.6 note:** Phase is primarily **config + docs**; CI TeX is out of scope per **REQUIREMENTS.md**.

## Sources

### Primary (HIGH confidence)

- [LaTeX Workshop Wiki — Compile](https://github.com/James-Yu/LaTeX-Workshop/wiki/Compile) — `autoBuild.run`, `build.fromWorkspaceFolder`, recipes/tools, `search.rootFiles.include`, multi-file root logic, placeholders (`%DOC%`, `%WORKSPACE_FOLDER%`), WSL `latexmk.exe` note. Page edited **2026-03-25** (per wiki).
- [LaTeX Workshop Wiki — View](https://github.com/James-Yu/LaTeX-Workshop/wiki/View) — `view.pdf.viewer`, internal viewer reload, `watch.pdf.delay`, SyncTeX, external viewer limitations.
- [LaTeX Workshop — Install](https://github.com/James-Yu/LaTeX-Workshop/wiki/Install) — TeX Live preference, PATH, MiKTeX + Perl.
- Repository: **`PROJECTS.md`**, **`.latexmkrc`**, **`Makefile`**, **`README.md`**, **`AGENTS.md`**.

### Secondary (MEDIUM confidence)

- `.planning/research/SUMMARY.md` — milestone-level stack notes (cross-check with wiki for exact keys).

### Tertiary (LOW confidence)

- GitHub issues cited in web search (PDF not updating, external viewer on macOS) — **not** used as normative; treat as troubleshooting pointers only.

## Metadata

**Confidence breakdown:**

- Standard stack: **HIGH** — official wiki + repo build contract.
- Architecture: **HIGH** — placeholders and `fromWorkspaceFolder` documented in wiki.
- Pitfalls: **MEDIUM-HIGH** — root/partial edge cases are known LW limitations.

**Research date:** 2026-03-25  
**Valid until:** ~2026-04-25 (extension/wiki can change; re-check key names if LaTeX Workshop ships a major release).
