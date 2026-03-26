# tex

Git-tracked LaTeX sources and assets—edit any `.tex` in Cursor/VS Code and use agents on the same tree; local compilation produces PDFs when needed.

## Agents

For **coding agents** and **automated edits**, see **[AGENTS.md](AGENTS.md)** at the repository root—it defines compile roots, build references, and git hygiene expectations.

## Prerequisites

Install a full TeX distribution (TeX Live, MacTeX, or MiKTeX) so `latexmk` and `pdflatex` are on your `PATH`. Official TeX Live: [https://www.tug.org/texlive/](https://www.tug.org/texlive/).

## Build

Work from the **repository root** (the directory that contains `README.md`, `Makefile`, and `.latexmkrc`).

LaTeX projects live under **`projects/<name>/`**, each with its own **`main.tex`**. **Per-project commands** (master paths and copy-paste `latexmk` lines) are listed in **[PROJECTS.md](PROJECTS.md)**.

**Example — `sample` project:**

```bash
latexmk -pdf -interaction=nonstopmode -file-line-error -outdir=projects/sample/build projects/sample/main.tex
```

This uses the committed **`.latexmkrc`** for consistent `pdflatex` settings. Output (PDF, aux, log) goes under **`projects/sample/build/`** (ignored by `.gitignore`), not next to `main.tex`.

If you have `make`, the same recipe is available as:

```bash
make pdf
```

Use **`make pdf PROJECT=<path>`** when the master is **`projects/<path>/main.tex`** (default **`PROJECT=sample`**). See the **`Makefile`** at the repo root.

### Private projects (submodule)

To keep CV, résumé, or other private sources in a **separate Git repository** while using this repo’s **`Makefile`**, **`.latexmkrc`**, and editor settings, add that repository as a submodule at **`projects/private`**:

```bash
git submodule add <your-private-repo-url> projects/private
git submodule update --init --recursive
```

Lay out each LaTeX project under the private repo as **`…/main.tex`** (for example `projects/private/CV/main.tex` after the submodule is present). Build from this repository’s root:

```bash
make pdf PROJECT=private/CV
```

Clones that should not fetch private content can omit submodule init; **`projects/private`** stays empty until you add the submodule and have access.

## Main file (compile root)

There is **no** single master at the repository root. Each project has a master under **`projects/<name>/main.tex`**; the **`sample`** project uses **`projects/sample/main.tex`**. See **[PROJECTS.md](PROJECTS.md)** for the full list.

## LaTeX Workshop (PDF preview)

Open the **repository root** (the folder that contains this `README.md`, `Makefile`, and `.latexmkrc`) as the workspace folder in VS Code or Cursor. LaTeX Workshop discovers TeX roots from that cwd; committed settings under **`.vscode/settings.json`** recommend the **LaTeX Workshop** extension via **`.vscode/extensions.json`** (**D-02**).

The following **exact setting keys** appear in committed config and are repeated here so you can search this document:

- `latex-workshop.view.pdf.viewer`
- `latex-workshop.latex.autoBuild.run`
- `latex-workshop.latex.build.fromWorkspaceFolder`
- `latex-workshop.latex.search.rootFiles.include`
- `latex-workshop.latex.outDir` (set to `%DIR%/build` so IDE builds match CLI `latexmk -outdir=…`)

**Auto-build default:** the repo sets `latex-workshop.latex.autoBuild.run` to **`onSave`** (**D-03**). Saving a `.tex` file triggers `latexmk` via the configured recipe; after a successful build, the PDF tab refreshes.

**Manual builds:** if you want **no** auto-build, set `latex-workshop.latex.autoBuild.run` to **`never`** and use LaTeX Workshop’s **Build LaTeX project** command or your own keybinding instead (**D-03**).

**Partials:** when you edit a file under `projects/sample/sections/`, add a root directive so LaTeX Workshop knows which `main.tex` to build. The path is relative from the partial to the project master:

```tex
% !TEX root = ../main.tex
```

This matches the layout where partials live next to `projects/sample/main.tex` (**D-04**). For commands and paths, **[PROJECTS.md](PROJECTS.md)** remains the canonical reference for `latexmk` lines.

### SyncTeX (optional)

Forward and inverse search (click-from-source / click-from-PDF) work when SyncTeX is enabled by your build and supported by LaTeX Workshop; details depend on your viewer and OS. This repo does not guarantee the same SyncTeX behavior if you switch to an external PDF viewer (**D-05**). Enable **synctex** in your TeX toolchain if you rely on source↔PDF navigation.

### WSL or remote

Use the same rule: open the **repository root** in the editor and ensure **`latexmk`** and your TeX programs are on **`PATH`** in that environment. If the internal PDF viewer misbehaves (common in some remote or WSL setups), set `latex-workshop.view.pdf.viewer` to **`external`** and use your system PDF viewer (**D-06**).

## Repository layout

```
.
├── AGENTS.md          # conventions for humans and coding agents (compile roots, build pointers, git hygiene)
├── PROJECTS.md        # canonical list of projects, master paths, and build commands
├── Makefile           # optional: `make pdf` → latexmk for the sample project
├── .latexmkrc         # project latexmk defaults (pdflatex, nonstop build)
├── README.md
├── .gitignore
├── .vscode/
│   ├── settings.json  # LaTeX Workshop workspace settings (viewer, build, recipes)
│   └── extensions.json # recommends James-Yu.latex-workshop
└── projects/
    ├── sample/
    │   ├── main.tex   # compile root for the sample project
    │   ├── build/     # PDF + aux from latexmk (gitignored)
    │   ├── figures/   # images and figure PDFs (source assets)
    │   ├── bib/
    │   │   └── references.bib
    │   └── sections/  # optional \input / \include partials
    └── private/       # optional git submodule: your private CV / résumé / etc. (not in template-only clones)
```

## What we track vs ignore

- **Tracked:** `.tex` sources, `.bib` bibliography files, figure sources (e.g. `.png`, `.eps`, and PDFs under each project’s `figures/` when they are intentional assets).
- **Ignored:** LaTeX auxiliary files (`.aux`, `.log`, `.out`, `.synctex.gz`, and related patterns from the GitHub TeX baseline), **root** `main.pdf` if produced at the repository root, each project’s **`projects/<name>/build/`** tree (PDF + build products), and any legacy **`projects/**/main.pdf`** next to a master.

Full pattern details are in `.gitignore` (upstream TeX template plus project overrides).
</think>


<｜tool▁calls▁begin｜><｜tool▁call▁begin｜>
StrReplace