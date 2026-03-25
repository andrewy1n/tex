# Phase 5: Live PDF preview - Discussion Log

> **Audit trail only.** Do not use as input to planning, research, or execution agents.  
> Decisions are captured in `05-CONTEXT.md`.

**Date:** 2026-03-25  
**Phase:** 5 — Live PDF preview  
**Areas discussed:** PDF viewer placement; config delivery; build refresh; root-file / multi-project resolution; SyncTeX (optional); WSL / platform notes  

---

## PDF viewer placement

| Option | Description | Selected |
|--------|-------------|----------|
| Separate editor tab (LW built-in) | PDF opens in a tab, not the `.tex` buffer | ✓ |
| Side-by-side / split | Split editor with PDF beside source | |
| External viewer | System PDF app or browser | |

**User's choice:** Discuss all areas; **locked:** separate **tab** viewer (D-01).  
**Notes:** Aligns with PRV-01 and research SUMMARY.

---

## Config delivery

| Option | Description | Selected |
|--------|-------------|----------|
| Commit `.vscode/` + document in README | Workspace settings + extension recommendation; README as fallback | ✓ |
| Documentation only | No committed JSON; users copy settings | |
| Full duplication | Large README blocks mirroring every key | |

**User's choice:** **Hybrid** — commit minimal `.vscode/` **and** document in README (D-02).

---

## Build refresh

| Option | Description | Selected |
|--------|-------------|----------|
| Auto-build on save | Save `.tex` → build → viewer refresh | ✓ |
| On file change | Broader triggers | |
| Manual only | User runs build recipe; document refresh | |

**User's choice:** **`onSave`** default; document how to use manual-only (D-03).

---

## Root file / multi-project

| Option | Description | Selected |
|--------|-------------|----------|
| Glob roots + `latexmk` recipes | Include `projects/**/main.tex`, recipes match PROJECTS.md | ✓ |
| `% !TeX root` only | No workspace globs | |
| Multi-root workspaces | Separate VS Code roots per project | |

**User's choice:** **Globs + recipes** consistent with **`PROJECTS.md`**; **`% !TeX root`** documented for partials when needed (D-04).

---

## SyncTeX

| Option | Description | Selected |
|--------|-------------|----------|
| Optional; brief README mention | Not blocking; roadmap optional success criterion | ✓ |
| Required; tune until perfect | In scope for “done” | |
| Omit entirely | No mention | |

**User's choice:** **Optional** documentation; not required for phase completion (D-05).

---

## WSL / platform

| Option | Description | Selected |
|--------|-------------|----------|
| Short README subsection | Repo root, PATH, external viewer escape hatch | ✓ |
| Long troubleshooting doc | | |
| No platform section | | |

**User's choice:** **Short** README note (D-06).

---

## Claude's Discretion

- Exact LaTeX Workshop keys and future extension churn (D-01–D-04 behavior preserved).
- Depth of SyncTeX and optional `.latexmkrc` tweak (D-05).

## Deferred Ideas

None recorded in this session.
