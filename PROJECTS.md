# Projects

This file is the **canonical** list of LaTeX projects in this repository. Each row is an independent project under `projects/<name>/` with its own master file; **PDF and aux files** go under **`projects/<name>/build/`** (via `latexmk -outdir=projects/<name>/build`).

**LaTeX Workshop:** `latex-workshop.latex.outDir` is **`%DIR%/build`**, matching the table’s `-outdir` flag so IDE builds land in the same folder as CLI **`make pdf`**.

| Project name | Master file | Build from repository root |
|--------------|-------------|------------------------------|
| `sample` | `projects/sample/main.tex` | `latexmk -pdf -interaction=nonstopmode -file-line-error -outdir=projects/sample/build projects/sample/main.tex` |

The same invocation is available as **`make pdf`** (see the root **`Makefile`**), which wraps `latexmk` with the same flags for the sample project.
