# GSD Debug Knowledge Base

Resolved debug sessions. Used by `gsd-debugger` to surface known-pattern hypotheses at the start of new investigations.

---

## torn-latex-formatter-not-found — VS Code extension referenced in settings doesn't exist
- **Date:** 2026-03-27
- **Error patterns:** torn.latex-formatter, marketplace, VS Code, extension not found
- **Root cause:** Extension `torn.latex-formatter` does not exist in VS Code marketplace. Was referenced in Phase 6 work but the publisher/ID is invalid. Project uses latexindent CLI tool so the correct extension is `lenagain.latexindent`.
- **Fix:** Replaced all references to `torn.latex-formatter` with `lenagain.latexindent` in settings, documentation, and extension recommendations. Extension `lenagain.latexindent` properly wraps the latexindent CLI tool already configured in .latexindent.yaml.
- **Files changed:** .vscode/settings.json, .vscode/extensions.json, README.md, .planning/phases/06-linting-formatting/06-SUMMARY.md
---
