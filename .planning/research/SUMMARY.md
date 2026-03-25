# Project Research Summary

**Project:** tex  
**Domain:** Local LaTeX git workspace for Cursor/VS Code and coding agents (not a hosted web editor)  
**Researched:** 2025-03-25  
**Confidence:** MEDIUM–HIGH

## Executive Summary

This project is a **source-first git repository** for LaTeX: versioned `.tex`, bibliography, figures, and optional local class/style files, edited in Cursor/VS Code with the same tree available to agents. Experts treat the TeX distribution and `latexmk` as the **build plane** (local, not in Git), keep **one clear master document** and predictable paths, and use **LaTeX Workshop** plus optional Make/tasks so humans, agents, and future CI share one command story. That matches PROJECT.md: light repeatable local builds, no mandatory CI in v1, and no enforced distro—while still documenting expectations (e.g. TeX Live year, `bibtex` vs `biber`).

The recommended approach is **TeX Live 2025** on Linux/WSL (or **MacTeX 2025** on macOS; **MiKTeX** on Windows with **Perl** if using default `latexmk` recipes), **`latexmk`** as the multi-pass driver, and **LaTeX Workshop** (`James-Yu.latex-workshop`) for editing integration. Centralize flags in a **project `.latexmkrc`** and/or a thin **Makefile**; add a **TeX-oriented `.gitignore`** and an explicit policy on whether `*.pdf` is output-only; document **WSL/PATH** so the editor host sees the same binaries as the shell.

Main risks are **repository hygiene** (committed aux/PDF noise), **cwd and output-directory drift** between IDE, agents, and CLI (breaking includes, figures, or SyncTeX), **wrong compile root** in multi-file trees, and **agent edits** that break `%` continuations, verbatim-like blocks, or preamble consistency. Mitigate with a documented master file, one shared build entrypoint with explicit `cwd`, `.bib` as source of truth with engine documented, small agent diffs, and a “clean clone → build → clean `git status`” checklist before calling work done.

## Key Findings

### Recommended Stack

Standard practice is a full distribution (**TeX Live** / **MacTeX** / **MiKTeX**) plus **`latexmk`** for automatic LaTeX + BibTeX/Biber + index passes, and **LaTeX Workshop** for VS Code/Cursor (build recipes defaulting to `latexmk`, PDF view, SyncTeX). Optional **ChkTeX** / **latexindent** improve quality; **Biber** pairs with `biblatex`, **BibTeX** with classic templates. Avoid relying on Overleaf as the primary compiler for this repo, hand-run single-pass `pdflatex` as the only documented workflow, mixing TeX Live and MiKTeX on PATH, or MiKTeX without Perl when using default Workshop recipes.

**Core technologies:**

- **TeX Live 2025** (or MacTeX 2025 / MiKTeX): full engine and package set — de facto standard; `tlmgr` for alignment across machines.
- **latexmk**: one command for multi-pass builds and optional watch mode — assumed by editors and community workflows.
- **LaTeX Workshop**: primary Cursor/VS Code integration — documents TeX Live preference, WSL, PATH, MiKTeX+Perl constraints.
- **`.latexmkrc` / Makefile / `tasks.json`**: single source of truth for flags — agents and humans invoke the same entrypoint.

Detail: [STACK.md](./STACK.md).

### Expected Features

Collaborators expect an **obvious entry point** (`main.tex` or documented equivalent), **sane layout** (e.g. `chapters/`, `figures/`, `.bib` in predictable places), **multi-file structure** for non-trivial docs, **`.gitignore` for auxiliaries**, **bibliography and figures in-repo** (or LFS policy), **repeatable local build** documented in README, and **line-oriented `.tex`** for Git/agent diffs. Differentiators include shared **`.vscode`** defaults, **`AGENTS.md`** (root file, build command, path rules), aligned **outDir**/paths for multi-file builds, optional lint/format, and later **devcontainer** or **CI**.

**Must have (table stakes):**

- Navigable layout; obvious master — build tools and onboarding depend on it.
- `.gitignore` for LaTeX aux (and explicit PDF policy) — keeps repo and merges sane.
- One documented build path (`latexmk` or `make pdf`) — matches PROJECT.md active requirements.
- Multi-file discipline + `% !TeX root` or single master when needed — reduces wrong-file compiles.

**Should have (competitive):**

- LaTeX Workshop / shared tasks — smooth IDE loop.
- Agent convention doc + path discipline — fewer “file not found” and wrong-root builds.

**Defer (v2+):**

- Mandatory CI PDF on every push — explicitly out of scope for v1 per PROJECT.md.
- Devcontainer, release PDF automation, `latexdiff` workflows — after core repo ergonomics land.

Detail: [FEATURES.md](./FEATURES.md).

### Architecture Approach

Git holds **sources and assets**; **automation** (`latexmk`, Make, editor tasks) runs compilation; **PDF and aux** are build products, usually gitignored. Use **one entry document**, **partials** via `\input`/`\include`, optional **preamble split**, centralized **`figures/`** and **`.bib`**, optional **`build/`** via `$out_dir` with path/BIBINPUTS care. Recommended setup order: choose layout → `.gitignore` → wire minimal master → add bib + one figure → add automation → README → CI only later if desired.

**Major components:**

1. **Entry `.tex`** — single compile root; structure and includes.
2. **Partials / assets** — chapters, figures, bibliography as versioned inputs.
3. **Automation + policy** — `.latexmkrc`, Makefile, `.gitignore`, README; optional `.vscode`.

Detail: [ARCHITECTURE.md](./ARCHITECTURE.md).

### Critical Pitfalls

1. **Tracking build artifacts and editor cruft** — Adopt a maintained TeX `.gitignore`, decide PDF policy, use patterns that cover subfolders; verify clean `git status` after build.
2. **Fragile paths and working directory** — One documented master; same CLI/IDE/agent entrypoint with explicit `cwd`; relative `$out_dir`; test IDE vs terminal.
3. **Partial compiles / wrong root** — Never treat chapter files as the compile root; document in README/`AGENTS.md`; `latexmk` default files or Makefile `pdf` target only builds master.
4. **Bibliography source vs generated** — `.bib` is source; document `bibtex` vs `biber`; ignore generated `.bbl`/`.bcf` unless explicitly excepted.
5. **Agent edits breaking LaTeX semantics** — Preserve `%` line endings and verbatim-like blocks; avoid bulk reflow; run full master build after substantive agent changes.

Detail: [PITFALLS.md](./PITFALLS.md).

## Implications for Roadmap

Based on research, suggested phase structure:

### Phase 1: Repository foundation & hygiene

**Rationale:** Layout and ignore rules are prerequisites for every other workflow; prevents irreversible noise in history and sets asset policy early.  
**Delivers:** Chosen tree (flat root vs `src/`), canonical `main.tex` (or documented masters), `.gitignore` baseline, README with layout map and prerequisites, explicit PDF/figure policy (including LFS note if needed).  
**Addresses:** FEATURES P1 — entry point, layout, `.gitignore`, figures/bib in-repo, README.  
**Avoids:** Pitfalls 1 (artifact tracking), 4 (binary bloat) at policy level.

### Phase 2: Repeatable build & bibliography pipeline

**Rationale:** A single, documented build path must work from a clean tree before scaling content or IDE polish; bib/outdir issues show up here first.  
**Delivers:** Project `.latexmkrc` and/or Makefile with `latexmk -pdf -interaction=nonstopmode -halt-on-error` (or equivalent); documented engine for citations; minimal proof path (bib + one figure); if using `build/`, configured paths/`BIBINPUTS` and verified clean clone.  
**Uses:** STACK — `latexmk`, SyncTeX defaults via automation.  
**Implements:** ARCHITECTURE — automation layer and source→PDF data flow.  
**Avoids:** Pitfalls 2 (cwd/outdir), 3 (wrong master), 5 (bib confusion), 7 (shell-escape/minted flags documented if used).

### Phase 3: Editor, agent, and path alignment

**Rationale:** After the CLI contract is stable, align LaTeX Workshop `outDir`/recipes and agent rules so IDE and agents do not diverge from README.  
**Delivers:** Optional `.vscode/settings.json` and `tasks.json`; short `AGENTS.md` (master only, build command, “do not edit generated files”); SyncTeX/outdir consistent with Phase 2.  
**Addresses:** FEATURES P2 — Workshop/tasks, agent contract, path/outDir alignment.  
**Avoids:** Pitfalls 2 (IDE vs CLI), 6 (agent conventions + rebuild discipline).

### Phase 4 (optional): Quality, scale, and future platform work

**Rationale:** Valuable once churn justifies it; not required for PROJECT.md v1.  
**Delivers:** Optional ChkTeX/latexindent scripts; Git LFS if binaries hurt clones; `latexdiff` or review workflow notes; later **CI PDF** and/or **devcontainer** when team wants gates or identical toolchains.

### Phase ordering rationale

- **Hygiene and layout before automation** — avoids committing aux while iterating on structure (ARCHITECTURE setup order; PITFALLS Phase 1 mapping).  
- **CLI/build contract before deep IDE tuning** — README and `make`/`latexmk` are the agent- and CI-portable baseline; Workshop layers on top.  
- **Multi-file path and master conventions early** — unblocks reliable collaboration and agent compiles (FEATURES dependency graph).

### Research Flags

Phases likely needing deeper research during planning:

- **Phase 2:** If the team adopts **`$out_dir` / `build/`** or unusual `\include` layouts — TeX.SE and LaTeX Workshop issue threads document edge cases; validate on target OS (WSL vs native).  
- **Phase 4 (CI/devcontainer):** Image choice, package set, and cache strategy — optional and deferred per PROJECT.md but non-trivial when triggered.

Phases with standard patterns (lighter `/gsd-research-phase`):

- **Phase 1:** `.gitignore` baselines and common folder layouts are widely documented.  
- **Phase 3:** LaTeX Workshop wiki for install, compile, and PATH/WSL is extensive.

## Confidence Assessment

| Area | Confidence | Notes |
|------|------------|-------|
| Stack | HIGH | TUG/CTAN, LaTeX Workshop wiki, and distro docs align on TeX Live + `latexmk` + extension; exact binary semver pins remain environment-specific. |
| Features | MEDIUM | Table stakes and editor patterns are well documented; agent ergonomics are inferred from IDE practice, not formal standards. |
| Architecture | MEDIUM–HIGH | Master + partials + automation matches widespread templates; folder names are team choice. |
| Pitfalls | MEDIUM–HIGH | Strong community consensus; editor/toolchain edge cases evolve with versions. |

**Overall confidence:** MEDIUM–HIGH

### Gaps to Address

- **Exact TeX Live package set per document** — Document minimum packages or “full scheme” assumption; validate on a second machine or fresh install during execution.  
- **Agent behavior on complex `.tex`** — No substitute for spot-checking builds after agent edits; consider tightening `.cursor` rules once patterns emerge.  
- **PDF-in-git policy** — Team must choose ignore vs release commits; affects `.gitignore` and reviewer workflow.

## Sources

### Primary (HIGH confidence)

- [TeX Live (TUG)](https://www.tug.org/texlive/), [TeX Live manual / news](https://www.tug.org/texlive/doc/texlive-en/texlive-en.html), [quick install](https://www.tug.org/texlive/quickinstall.html)
- [CTAN: latexmk](https://ctan.org/pkg/latexmk), [latexmk manual (PDF)](https://mirrors.ctan.org/support/latexmk/latexmk.pdf)
- [LaTeX Workshop — Install](https://github.com/James-Yu/LaTeX-Workshop/wiki/Install), [Compile](https://github.com/James-Yu/LaTeX-Workshop/wiki/Compile), [VS Code Marketplace](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop)
- [github/gitignore: TeX.gitignore](https://github.com/github/gitignore/blob/main/TeX.gitignore)
- [MacTeX](https://www.tug.org/mactex/), [MiKTeX](https://miktex.org/download)

### Secondary (MEDIUM confidence)

- Community workflow and large-project layout articles cited in FEATURES.md and ARCHITECTURE.md
- [TeX Stack Exchange](https://tex.stackexchange.com/) — `latexmk` output directory, aux ignore practices, multi-file root
- [LaTeX Workshop issues](https://github.com/James-Yu/LaTeX-Workshop/issues) (e.g. outdir/cwd) — version-sensitive

### Tertiary (LOW confidence)

- Ecosystem alternatives (TeXLab + separate viewer) — verify current extension IDs before standardizing

### Project context

- [.planning/PROJECT.md](../PROJECT.md) — scope, active requirements, out-of-scope items

---
*Research completed: 2025-03-25*  
*Ready for roadmap: yes*
