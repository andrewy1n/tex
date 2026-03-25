# Phase 2: Repeatable local build — Research

**Date:** 2026-03-25  
**Question:** What do we need to know to plan a single documented `latexmk`-based build for `main.tex` → `main.pdf` from a fresh clone?

## Findings

### latexmk as primary driver

- **`latexmk`** (TeX Live / MiKTeX / MacTeX) runs the multi-pass loop (pdflatex, bib, etc.) and is the standard “one command” for local LaTeX projects. See `.planning/research/STACK.md` and [CTAN: latexmk](https://ctan.org/pkg/latexmk).
- **Project-local `.latexmkrc`** (Perl syntax) is the usual place to pin `$pdf_mode`, interaction mode, and engine so CLI and editors share behavior without duplicating flags in README only.

### Flags aligned with CONTEXT (D-11, D-13)

- **`-pdf`** — PDF output via `pdflatex` (or configured engine).
- **`-interaction=nonstopmode`** — non-interactive builds (CI/agent friendly).
- **`-file-line-error`** — file:line error format (matches CONTEXT canonical example).

### Working directory

- **`main.tex`** lives at **repository root** (Phase 1). All documented commands must assume **`cd` to repo root** — matches D-12.

### Makefile (optional thin wrapper)

- **STACK.md** recommends a thin **`make pdf`** wrapping the same `latexmk` line for agents and muscle memory. CONTEXT (D-14) allows this only if it **does not** diverge from the documented `latexmk` invocation.

### Verification on a fresh clone

- Success criteria: after `git clone` … `cd` … install TeX … **one** documented command produces **`main.pdf`** next to **`main.tex`** (ignored by `.gitignore` — already configured).

### Pitfalls (from `.planning/research/PITFALLS.md` themes)

- Wrong CWD → wrong `main.pdf` location or missing inputs.
- Omitting **nonstop** mode → hung builds waiting for input.
- Documenting **different** flags in README vs `.latexmkrc` → confusion; keep README command **matching** the canonical `latexmk` line in CONTEXT.

## Recommendations for planning

1. Commit **`.latexmkrc`** with `pdflatex` / PDF mode defaults consistent with D-11.
2. Optionally add **`Makefile`** with `pdf` target = same `latexmk` line as README.
3. **README:** one **Build** subsection: prerequisite (TeX + `latexmk` on PATH), **exact** command(s), **run from repo root**.
4. **Executor verification:** run `latexmk` from repo root; assert **`main.pdf`** exists and **`latexmk` exit code 0** (requires local TeX in environment).

## RESEARCH COMPLETE
