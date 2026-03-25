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
latexmk -pdf -interaction=nonstopmode -file-line-error projects/sample/main.tex
```

This uses the committed **`.latexmkrc`** for consistent `pdflatex` settings. Output is **`projects/sample/main.pdf`** next to that project’s `main.tex` (ignored by `.gitignore`).

If you have `make`, the same recipe is available as:

```bash
make pdf
```

See the **`Makefile`** at the repo root.

## Main file (compile root)

There is **no** single master at the repository root. Each project has a master under **`projects/<name>/main.tex`**; the **`sample`** project uses **`projects/sample/main.tex`**. See **[PROJECTS.md](PROJECTS.md)** for the full list.

## Editor (optional)

VS Code / Cursor users may install the **LaTeX Workshop** extension (`James-Yu.latex-workshop`) for integrated editing—Phase 5 documents PDF preview settings for multi-project layouts.

## Repository layout

```
.
├── AGENTS.md          # conventions for humans and coding agents (compile roots, build pointers, git hygiene)
├── PROJECTS.md        # canonical list of projects, master paths, and build commands
├── Makefile           # optional: `make pdf` → latexmk for the sample project
├── .latexmkrc         # project latexmk defaults (pdflatex, nonstop build)
├── README.md
├── .gitignore
└── projects/
    └── sample/
        ├── main.tex   # compile root for the sample project
        ├── figures/   # images and figure PDFs (source assets)
        ├── bib/
        │   └── references.bib
        └── sections/  # optional \input / \include partials
```

## What we track vs ignore

- **Tracked:** `.tex` sources, `.bib` bibliography files, figure sources (e.g. `.png`, `.eps`, and PDFs under each project’s `figures/` when they are intentional assets).
- **Ignored:** LaTeX auxiliary files (`.aux`, `.log`, `.out`, `.synctex.gz`, and related patterns from the GitHub TeX baseline), **root** `main.pdf` if produced at the repository root, and **per-project** `main.pdf` files under **`projects/`** (for example `projects/sample/main.pdf`).

Full pattern details are in `.gitignore` (upstream TeX template plus project overrides).
</think>


<｜tool▁calls▁begin｜><｜tool▁call▁begin｜>
StrReplace