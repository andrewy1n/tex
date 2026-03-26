# Projects

This file is the **canonical** list of LaTeX projects in this repository. Each row is an independent project under `projects/<path>/` with its own master file; **PDF and aux files** go under **`projects/<path>/build/`** (via `latexmk -outdir=projects/<path>/build`).

**LaTeX Workshop:** `latex-workshop.latex.outDir` is **`%DIR%/build`**, matching the table’s `-outdir` flag so IDE builds land in the same folder as CLI **`make pdf`**.

| Project name | Master file | Build from repository root |
|--------------|-------------|------------------------------|
| `sample` | `projects/sample/main.tex` | `latexmk -pdf -interaction=nonstopmode -file-line-error -outdir=projects/sample/build projects/sample/main.tex` |

The same flags are available as **`make pdf`** (defaults to `sample`) or **`make pdf PROJECT=<path>`** when the master is `projects/<path>/main.tex` — for example after adding a private repo as a submodule at **`projects/private`** (see [README — Private projects](README.md#private-projects-submodule)), a project `CV` inside that repo is built with **`make pdf PROJECT=private/CV`**.
