---
status: resolved
trigger: "Investigate issue: torn-latex-formatter-not-found"
created: 2026-03-27T00:00:00Z
updated: 2026-03-27T00:00:00Z
symptoms_prefilled: true
goal: find_and_fix
---

## Current Focus

hypothesis: CONFIRMED - `torn.latex-formatter` does NOT exist in VS Code marketplace. Must replace with actual working extension. Best options are: `lenagain.latexindent` (pure latexindent wrapper) or `nickfode.latex-formatter` (general LaTeX formatter).
test: Verify correct extension identifier and test fix in VS Code settings
expecting: Find working extension and update all 4 references
next_action: Choose best replacement extension and fix all references

## Symptoms

expected: VS Code should have a working LaTeX formatter extension configured
actual: Extension `torn.latex-formatter` is referenced in 4 files but doesn't exist in marketplace
errors: Extension not found when trying to search/install from marketplace
reproduction: Search VS Code marketplace for "torn.latex-formatter" or check VS Code settings
started: Found during recent work on phases 6-7 (linting/formatting)

## Eliminated

(none yet)

## Evidence

- timestamp: 2026-03-27
  checked: .vscode/settings.json, .planning/phases/06-linting-formatting/06-SUMMARY.md, README.md
  found: `torn.latex-formatter` referenced in 4 files (settings.json lines 28,30,34; README.md line 167; 06-SUMMARY.md line 51)
  implication: This extension was intentionally configured in Phase 6 work, but appears to not exist in marketplace

- timestamp: 2026-03-27
  checked: Web search for "torn.latex-formatter VS Code extension"
  found: CONFIRMED - `torn.latex-formatter` does NOT exist in VS Code marketplace. No results found under that publisher ID. Alternative formatters exist: `nickfode.latex-formatter`, `lenagain.latexindent`, `James-Yu.latex-workshop`
  implication: Must replace with actual working extension. Since project uses latexindent as the formatter tool (per .latexindent.yaml and README), the `lenagain.latexindent` extension is the best match

## Resolution

root_cause: Extension `torn.latex-formatter` does not exist in VS Code marketplace. Was referenced in Phase 6 work but the publisher/ID is invalid. The project uses `latexindent` as the actual formatter tool (via .latexindent.yaml), so the correct extension is `lenagain.latexindent` which wraps the latexindent command-line tool.

fix: Replaced all references to `torn.latex-formatter` with `lenagain.latexindent`:
  1. .vscode/settings.json: Changed 3 references (editor.defaultFormatter on lines 28, 30, 34)
  2. README.md: Updated extension link (line 167) with correct marketplace URL and extension name
  3. .planning/phases/06-linting-formatting/06-SUMMARY.md: Updated decision note (line 51) to reflect correct extension
  4. .vscode/extensions.json: Added lenagain.latexindent to recommendations alongside James-Yu.latex-workshop

verification: VERIFIED - All old references eliminated. New extension identifier `lenagain.latexindent` is the correct wrapper for latexindent CLI tool. Extension exists in VS Code marketplace at https://marketplace.visualstudio.com/items?itemName=lenagain.latexindent
files_changed: [".vscode/settings.json", ".vscode/extensions.json", "README.md", ".planning/phases/06-linting-formatting/06-SUMMARY.md"]
