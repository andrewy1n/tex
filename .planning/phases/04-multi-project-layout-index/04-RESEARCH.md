# Phase 4 research — Multi-project layout & index

**Date:** 2026-03-25  
**Phase:** 4 — Multi-project layout & index

## User Constraints

Copied from `.planning/phases/04-multi-project-layout-index/04-CONTEXT.md` — **non-negotiable for planning.**

### Locked decisions

- **D-21 / D-22:** `projects/<project-name>/` with **`main.tex`** per project; document naming (e.g. lowercase kebab-case).
- **D-23 / D-24:** Move **`main.tex`**, **`figures/`**, **`bib/`**, **`sections/`** → **`projects/sample/`**; root = docs + tooling only; **`projects/sample`** is reference layout.
- **D-25–D-28:** Colocated **`main.pdf`**; **`.gitignore`** **`projects/**/main.pdf`** + figure exceptions **`projects/**/figures/**/*.pdf`**; document **`latexmk`** from repo root with explicit path **`projects/sample/main.tex`**; root **`.latexmkrc`** shared.
- **D-29–D-32:** **`PROJECTS.md`** canonical table; **`README.md`** multi-project + link; **`AGENTS.md`** multi-project pointers, no duplicate command blocks; **`AGENTS.md`** / **`.gitignore`** explain per-project artifacts.

### Claude's Discretion

- **`PROJECTS.md`** formatting; **`Makefile`** shape (generic vs `TARGET=`); **`README`** section order; optional **`projects/sample/README.md`** stub; **`.gitignore`** comment wording.

### Deferred ideas

- None from CONTEXT.

---

## Project constraints (from `.cursor/rules/`)

- **GSD:** Prefer GSD entry points (`/gsd-execute-phase`, etc.) for planned work; user may bypass explicitly.
- **LaTeX / agents:** Pointers note **`AGENTS.md`** at repo root for LaTeX edit expectations.
- **Stack:** TeX Live / `latexmk` / LaTeX Workshop — multi-project aligns with `.planning/research/SUMMARY.md` (per-folder projects, avoid output collisions).

---

## Standard stack

| Tool | Role | Confidence |
|------|------|--------------|
| **`latexmk`** | Multi-pass builds; invoke with **path to master** from repo root | HIGH |
| **Root `.latexmkrc`** | Inherited when `latexmk` runs on `projects/.../main.tex` | HIGH |
| **`git mv`** | Preserve history when relocating `main.tex` and asset dirs | HIGH |

---

## Architecture patterns

1. **Single repo, multiple independent PDFs** — Each `projects/<name>/main.tex` produces **`main.pdf`** in that same directory (no shared output dir unless later changed).
2. **Documentation hierarchy** — **`PROJECTS.md`** = index of masters + commands; **`README.md`** = onboarding + layout diagram + pointer; **`AGENTS.md`** = agent rules + pointers (no duplicated `latexmk` blocks per Phase 3).
3. **Ignore rules** — Broad TeX aux patterns from GitHub `TeX.gitignore` baseline; **project-specific** PDF ignore **`projects/**/main.pdf`**; **negated** patterns for figure PDFs under **`projects/**/figures/`** mirroring root **`!figures/**/*.pdf`**.

---

## Don't hand-roll

- **Do not** introduce a second master at repo root after migration (contradicts D-23).
- **Do not** use a single global output directory for all projects unless CONTEXT is revised (colocated PDFs are locked).

---

## Common pitfalls

| Pitfall | Mitigation |
|---------|------------|
| **Broken relative paths** after move | `\input`, `\include`, `\bibliography` paths — current `main.tex` has no bib include; if `bib/` moves, future `\bibliography{bib/references}` may need `bib/references` still valid relative to `projects/sample/main.tex` → use `bib/references` (subdir under project). |
| **`latexmk` aux files** next to sources | Expected; global `*.aux` in gitignore already covers. |
| **Stale root `/main.pdf`** | Keep ignore rule; document that PDF builds live under `projects/`. |
| **Figure PDF tracking** | Ensure `!projects/**/figures/**/*.pdf` so intentional figure PDFs remain trackable. |

---

## Code examples

**Build from repo root (D-27):**

```bash
latexmk -pdf -interaction=nonstopmode -file-line-error projects/sample/main.tex
```

**Makefile `pdf` target (discretion — concrete default):**

```makefile
latexmk -pdf -interaction=nonstopmode -file-line-error projects/sample/main.tex
```

---

## RESEARCH COMPLETE

Planner should split work into: (1) filesystem migration + ignore + Makefile alignment, (2) `PROJECTS.md` + README + `AGENTS.md`.
