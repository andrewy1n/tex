# Quick Task 260327-ips: Commit LaTeX formatter configuration

**Mode:** quick

## Objective

Commit the LaTeX formatter configuration changes that switched from the torn.latex-formatter extension (`lenagain.latexindent`) to using LaTeX Workshop's built-in formatter (`latexindent`), and verify the formatting fix works in Cursor.

## Changes Summary

- `.vscode/extensions.json`: Removed `lenagain.latexindent` recommendation (keep only `James-Yu.latex-workshop`)
- `.vscode/settings.json`:
  - Moved formatter config from `editor.defaultFormatter: "lenagain.latexindent"` to LaTeX Workshop native config
  - Added `latex-workshop.latexFormatter: "latexindent"` with args `["-m", "-l", ".latexindent.yaml"]`
  - Updated `[latex]` and `[tex]` formatters to use `"James-Yu.latex-workshop"` instead of `"lenagain.latexindent"`
- `projects/private`: Updated submodule pointer (from implementation, commit separately)

## Tasks

1. **Commit formatter config changes** — Stage and commit `.vscode/extensions.json` and `.vscode/settings.json` with message `"config(vscode): switch LaTeX formatter to LaTeX Workshop built-in"`. Do NOT include the `projects/private` submodule pointer change in this commit.

2. **Test in Cursor** — Open the Cursor IDE, load a `.tex` file from the repo (e.g., a project document), trigger format-on-save or use `Cmd+Shift+P > Format Document`, and verify that indentation is applied correctly using latexindent. No errors in the output panel.

3. **GSD artifacts** — Write `260327-ips-SUMMARY.md` documenting the formatter migration; append row to `.planning/STATE.md` Quick Tasks Completed table; final `docs(quick-260327-ips)` commit for planning files.

**Scope:** Only the VS Code formatter configuration. The `projects/private` submodule change will be committed separately in its own quick task.

## Success Criteria

- `.vscode/extensions.json` and `.vscode/settings.json` committed with clean message
- Cursor can format `.tex` files without errors
- latexindent correctly indents code (observable in file changes)
- `STATE.md` updated with quick task entry
- No unrelated changes in the commits
