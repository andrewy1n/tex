# Phase 4: Multi-project layout & index - Discussion Log

> **Audit trail only.** Do not use as input to planning, research, or execution agents.  
> Decisions are captured in **04-CONTEXT.md**.

**Date:** 2026-03-25  
**Phase:** 4 — Multi-project layout & index  
**Areas discussed:** Project tree & master naming; Legacy root migration; Output isolation & build; Project index & documentation

---

## Area 1 — Project tree and master naming

| Option | Description | Selected |
|--------|-------------|----------|
| A | `projects/<name>/` with **`main.tex`** per project; documented naming (e.g. lowercase kebab-case) | ✓ |
| B | Flexible master names; each listed in index + optional `% !TeX root` | |
| C | Other | |

**User's choice:** **A** — adopt recommended convention (`projects/<name>/main.tex`).

**Notes:** User selected **all** gray areas for discussion, then confirmed **all recommendations** in a follow-up.

---

## Area 2 — Legacy root migration

| Option | Description | Selected |
|--------|-------------|----------|
| A | Move **`main.tex`**, **`figures/`**, **`bib/`**, **`sections/`** into **`projects/sample/`**; no duplicate at root | ✓ |
| B | Keep root **`main.tex`** alongside **`projects/`** | |
| C | Other | |

**User's choice:** **A**

**Notes:** Root becomes docs + tooling only; **`sample`** is the reference project name.

---

## Area 3 — Output isolation and build mechanics

| Option | Description | Selected |
|--------|-------------|----------|
| A | Colocated **`main.pdf`** per project; **`projects/**/main.pdf`** (or equivalent) in **`.gitignore`**; **`!projects/**/figures/**/*.pdf`** (or equivalent) for figure assets; **document `latexmk` from repo root** with explicit path to master | ✓ |
| B | Central **`out/`** or **`build/<name>/`** for all outputs | |
| C | Other | |

**User's choice:** **A** — shared root **`.latexmkrc`**; per-project **`.latexmkrc`** only if needed (discretion).

---

## Area 4 — Project index and documentation

| Option | Description | Selected |
|--------|-------------|----------|
| A | **`PROJECTS.md`** canonical table + **README** pointer + **AGENTS** pointers (no duplicate command blocks) | ✓ |
| B | README-only table | |
| C | **`PROJECTS.md`** only | |

**User's choice:** **A**

---

## Claude's Discretion

- **Makefile** structure (single `Makefile` vs per-project targets) as long as recipes match documented **`latexmk`** lines.
- **`PROJECTS.md`** formatting; optional **`projects/sample/README.md`** stub.

## Deferred Ideas

None recorded.
