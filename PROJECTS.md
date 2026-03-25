# Projects

This file is the **canonical** list of LaTeX projects in this repository. Each row is an independent project under `projects/<name>/` with its own master file and build outputs.

| Project name | Master file | Build from repository root |
|--------------|-------------|------------------------------|
| `sample` | `projects/sample/main.tex` | `latexmk -pdf -interaction=nonstopmode -file-line-error projects/sample/main.tex` |

The same invocation is available as **`make pdf`** (see the root **`Makefile`**), which wraps `latexmk` with the same flags for the sample project.
