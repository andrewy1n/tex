# Quick Task 260327-heb — Summary

**Description:** Add Synctex to latexmk pdflatex build

## Done

- **`.latexmkrc`:** `pdflatex` now passes `-synctex=1` (with existing `-interaction=nonstopmode -file-line-error`), so builds emit `.synctex.gz` for forward/inverse search.

## Verification

- Diff matches intended single-line change; `projects/private` submodule pointer left unstaged.
