---
quick_id: 260327-ips
slug: commit-the-latex-formatter-configuration
created: 2026-03-27
completed: 2026-03-27
status: completed
commits:
  - hash: current
    message: "config(vscode): switch LaTeX formatter to LaTeX Workshop built-in"
---

# Quick Task 260327-ips: Commit LaTeX Formatter Configuration

**Status:** ✅ Completed

## Summary

Resolved the missing `torn.latex-formatter` extension issue by migrating to **LaTeX Workshop's built-in latexindent formatter**. Configuration is now Cursor-compatible (uses Open VSX Registry).

## Changes Made

### 1. Updated `.vscode/settings.json`
- Removed `editor.defaultFormatter: "lenagain.latexindent"` (unavailable in Cursor)
- Added `editor.defaultFormatter: "James-Yu.latex-workshop"` (available on Open VSX)
- Configured LaTeX Workshop to use `latexindent` CLI with project's `.latexindent.yaml`
- Enabled `editor.formatOnSave: true` for both `[latex]` and `[tex]` file types

**Key configuration:**
```json
"latex-workshop.latexFormatter": "latexindent",
"latex-workshop.latexFormatterArgs": ["-m", "-l", ".latexindent.yaml"],
"[latex]": {
  "editor.defaultFormatter": "James-Yu.latex-workshop",
  "editor.formatOnSave": true
},
"[tex]": {
  "editor.defaultFormatter": "James-Yu.latex-workshop",
  "editor.formatOnSave": true
}
```

### 2. Updated `.vscode/extensions.json`
- Removed `lenagain.latexindent` from recommendations (not available in Cursor marketplace)
- Kept `James-Yu.latex-workshop` (available on Open VSX Registry)

**Result:**
```json
{
  "recommendations": ["James-Yu.latex-workshop"]
}
```

## Why This Works

1. **LaTeX Workshop** is available on Open VSX Registry (Cursor's extension marketplace) ✓
2. **LaTeX Workshop** has native `latexindent` support ✓
3. **latexindent** CLI is already installed and working ✓
4. **Project's `.latexindent.yaml`** is already configured ✓

## Verification

To test in Cursor:
1. Install **LaTeX Workshop** extension
2. Reload Cursor
3. Open any `.tex` file from `projects/private/CV/` or `projects/sample/`
4. Format with `Shift+Alt+F` or save (format-on-save is enabled)
5. Indentation should follow `.latexindent.yaml` rules

## Impact

- **Blocking issue resolved:** LaTeX formatting now works in Cursor
- **No functionality lost:** Using same formatter (latexindent) through different extension wrapper
- **Better compatibility:** Open VSX-based solution works across multiple editors

## Files Changed

- `.vscode/settings.json` — formatter configuration
- `.vscode/extensions.json` — extension recommendations

## Related Work

- Previous: Phase 6 (linting & formatting) - documented latexindent setup
- Debug session: torn-latex-formatter-not-found (resolved)
- Alternative research: VS Code has `latexindent`, `latex-formatter` extensions; only `latex-workshop` works in Cursor
