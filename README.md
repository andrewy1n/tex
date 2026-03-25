# tex

Git-tracked LaTeX sources and assets—edit any `.tex` in Cursor/VS Code and use agents on the same tree; local compilation produces PDFs when needed.

## Prerequisites

Install a full TeX distribution (TeX Live, MacTeX, or MiKTeX) so `latexmk` and `pdflatex` are on your `PATH`. Official TeX Live: [https://www.tug.org/texlive/](https://www.tug.org/texlive/).

## Build

From the **repository root** (the directory that contains `main.tex`):

**Primary command:**

```bash
latexmk -pdf -interaction=nonstopmode -file-line-error main.tex
```

This uses the committed **`.latexmkrc`** for consistent `pdflatex` settings. Output is **`main.pdf`** next to `main.tex` (ignored by `.gitignore`).

If you have `make`, the same recipe is available as:

```bash
make pdf
```

See the **`Makefile`** at the repo root.

## Main file (compile root)

The primary LaTeX entry is **`main.tex`** at the repository root. See **[Build](#build)** above.

## Editor (optional)

VS Code / Cursor users may install the **LaTeX Workshop** extension (`James-Yu.latex-workshop`) for integrated editing—no settings are required for this repo.

## Repository layout

```
.
├── main.tex           # compile root (master document)
├── Makefile           # optional: `make pdf` → same latexmk invocation as below
├── .latexmkrc         # project latexmk defaults (pdflatex, nonstop build)
├── README.md
├── .gitignore
├── figures/           # images and figure PDFs (source assets)
├── bib/
│   └── references.bib
└── sections/          # optional \\input / \\include partials
```

## What we track vs ignore

- **Tracked:** `.tex` sources, `.bib` bibliography files, figure sources (e.g. `.png`, `.eps`, and PDFs under `figures/` when they are intentional assets).
- **Ignored:** LaTeX auxiliary files (`.aux`, `.log`, `.out`, `.synctex.gz`, and related patterns from the GitHub TeX baseline) and **root** `main.pdf` build output next to `main.tex`.

Full pattern details are in `.gitignore` (upstream TeX template plus small project overrides).
