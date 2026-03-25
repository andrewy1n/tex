# Phase 1: Repository layout & documentation - Discussion Log

> **Audit trail only.** Do not use as input to planning, research, or execution agents.  
> Decisions are captured in `01-CONTEXT.md`.

**Date:** 2025-03-25  
**Phase:** 1 — Repository layout & documentation  
**Areas discussed:** Master file & tree, Artifact policy, README depth, `.gitignore` baseline

---

## Master file & repository tree

| Option | Description | Selected |
|--------|-------------|----------|
| Root `main.tex` + `figures/` + `bib/` + optional `sections/` | Single obvious compile root; common LaTeX-in-git layout | ✓ |
| Nested `paper/main.tex` or `docs/main.tex` | Deeper entry; still valid but extra navigation | |
| Multi-paper `papers/<name>/main.tex` | Multiple documents; deferred to backlog | |

**User's choice:** Discuss **all** areas; **recommended default** applied: root `main.tex`, supporting folders as in CONTEXT **D-01–D-03**.  
**Notes:** Single-document v1; multi-paper explicitly out of scope for this phase.

---

## Artifact policy (PDFs & generated files)

| Option | Description | Selected |
|--------|-------------|----------|
| Ignore aux + output PDF; track figure PDFs in `figures/` when needed; README states policy | Matches research; avoids binary noise and merge pain on build output | ✓ |
| Ignore all PDFs including figures | Forces non-PDF figures only | |
| Commit output PDF for sharing | Higher noise/conflict risk; not default | |

**User's choice:** Recommended default **D-04–D-06** in CONTEXT.  
**Notes:** README must spell out tracked vs ignored PDFs.

---

## README depth

| Option | Description | Selected |
|--------|-------------|----------|
| Short: main file, tree, one-line TeX prereq, link to install docs | Enough for v1; aligns with coarse Phase 1 | ✓ |
| Extended: WSL, PATH, LaTeX Workshop | Valuable later; optional subsection only | |
| Minimal: main file name only | Too thin for REPO-04 | |

**User's choice:** Recommended default **D-07–D-08**.

---

## `.gitignore` baseline

| Option | Description | Selected |
|--------|-------------|----------|
| Standard GitHub `TeX.gitignore` + narrow exceptions | Broad coverage; industry baseline | ✓ |
| Hand-written minimal list | Easy to miss aux patterns | |
| Extra-strict ignore all PDFs everywhere | Breaks tracked figure PDFs without exceptions | |

**User's choice:** Recommended default **D-09–D-10**.

---

## Claude's Discretion

- Minor README structure, exact `bib/` vs `references.bib` naming—see CONTEXT.

## Deferred Ideas

- Multi-paper repo layout, mandatory CI, devcontainer — see CONTEXT `<deferred>`.
