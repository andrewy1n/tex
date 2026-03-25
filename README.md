# tex

Git-tracked LaTeX sources and assets—edit any `.tex` in Cursor/VS Code and use agents on the same tree; local compilation produces PDFs when needed.

## Prerequisites

Install a full TeX distribution (TeX Live, MacTeX, or MiKTeX). Phase 2 will document a repeatable build using `latexmk`. Official TeX Live: [https://www.tug.org/texlive/](https://www.tug.org/texlive/).

## Main file (compile root)

The primary LaTeX entry is **`main.tex`** at the repository root. The exact build command will be documented in Phase 2.

## Editor (optional)

VS Code / Cursor users may install the **LaTeX Workshop** extension (`James-Yu.latex-workshop`) for integrated editing—no settings are required for this repo.

## Repository layout

```
.
├── main.tex           # compile root (master document)
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

Full pattern details are in `.gitignore` (upstream TeX template plus small project overrides). The build command will be documented in Phase 2.
