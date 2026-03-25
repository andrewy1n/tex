# Architecture Research

**Domain:** Multi-file LaTeX projects under Git (editor- and agent-friendly repo layout)  
**Researched:** 2025-03-25  
**Confidence:** MEDIUM-HIGH — layout and workflow reflect widespread practice (templates, collaboration guides, TeX.SE); toolchain behavior for output directories is documented on CTAN/Stack Exchange. Not every team uses the same folder names; conventions below are opinionated defaults.

## Standard Architecture

### System Overview

Git stores **sources and assets**; the TeX distribution plus automation (`latexmk`, Make, editor tasks) performs **compilation**. The PDF and intermediate files are **build products**—usually generated locally and excluded from version control.

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         Version control (Git)                            │
├─────────────────────────────────────────────────────────────────────────┤
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐ │
│  │ Entry .tex   │  │ Partials     │  │ Assets       │  │ Project      │ │
│  │ (main.tex)   │  │ (chapters/)  │  │ (figs/, .bib)│  │ tooling      │ │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘  │ README,      │ │
│         │                 │                 │          │ .latexmkrc,  │ │
│         └─────────────────┴─────────────────┘          │ Makefile     │ │
│                          │                               └──────┬───────┘ │
├──────────────────────────┼──────────────────────────────────────┼─────────┤
│                    \input / \include                          invokes    │
├──────────────────────────┼──────────────────────────────────────┼─────────┤
│                         Build plane (local; not in Git by default)      │
│  ┌──────────────────────────────────────────────────────────────────┐   │
│  │  latexmk / pdflatex / biber|bibtex  →  .aux .log .toc .bbl …     │   │
│  │  optional: -outdir=build/  keeps repo root clean                  │   │
│  └──────────────────────────────────────────────────────────────────┘   │
│                              │                                            │
│                              ▼                                            │
│                     ┌─────────────────┐                                   │
│                     │  main.pdf       │                                   │
│                     └─────────────────┘                                   │
└─────────────────────────────────────────────────────────────────────────┘
```

### Component Responsibilities

| Component | Responsibility | Typical Implementation |
|-----------|----------------|------------------------|
| **Entry document** | Single compilation root; `\documentclass`, structure, `\input`/`\include` of parts | `main.tex` or `paper.tex` at repo root or under `doc/` |
| **Partials** | Logical sections (chapters, appendices); no full preamble or `\begin{document}` in each file when using standard `\input` pattern | `chapters/`, `frontmatter/`, `appendices/` |
| **Preamble split** | Shared packages, macros, geometry (optional file) | `preamble.tex` or `\input{meta/packages}` |
| **Assets** | Figures, bibliography, data tables consumed by TeX | `figures/`, `assets/`, `references.bib` |
| **Local style** | Non-CTAN `.cls`/`.sty` vendored for reproducibility | `tex/` or `local/` (keep minimal) |
| **Build output** | PDF, aux, logs, sync files | `build/`, `out/`, or ignored files next to sources |
| **Automation** | Repeatable “compile until stable” without hand-running BibTeX | `latexmk`, `Makefile`, VS Code tasks |
| **Policy** | What is tracked vs ignored | `.gitignore` (aux always; PDF team choice) |
| **CI (optional)** | Same recipe headless on push/PR | GitHub Actions / GitLab CI calling `latexmk` |

## Recommended Project Structure

Two common shapes both work in Git; pick one and stay consistent.

**Pattern A — flat root (good for papers, small projects):**

```
.
├── main.tex
├── preamble.tex              # optional
├── references.bib
├── chapters/                   # or sections/
│   ├── 01-intro.tex
│   └── 02-methods.tex
├── figures/
│   └── diagram.pdf
├── .gitignore
├── .latexmkrc                  # optional
├── Makefile                    # optional
└── README.md
```

**Pattern B — `src/` doc root (good when repo holds multiple concerns):**

```
.
├── README.md
├── .gitignore
├── src/
│   ├── main.tex
│   ├── chapters/
│   ├── figures/
│   └── references.bib
└── build/                      # gitignored when using -outdir
```

### Structure Rationale

- **One entry `main.tex`:** Clear compile target for humans, editors, and `latexmk main.tex`.
- **`chapters/` (or `sections/`):** Matches how Git diffs and merges work—one file per chapter beats a 5k-line monolith.
- **`figures/` (or `assets/`):** Binary and vector sources stay grouped; paths in `\includegraphics` stay stable.
- **`.bib` at known location:** Bibliography is source; belongs in Git beside prose.
- **Build dir + `.gitignore`:** Keeps `git status` clean and matches “source-first” goals from project requirements.
- **Tooling at root:** `Makefile` / `.latexmkrc` / editor config are discoverable for agents and new contributors.

## Architectural Patterns

### Pattern 1: Master document + `\input` / `\include`

**What:** The entry file holds the skeleton; parts are pulled in with `\input{chapters/intro}` or `\include{chapters/methods}`.  
**When to use:** Almost all multi-file Git projects. `\include` adds page breaks and allows partial builds (`\includeonly`); `\input` is simpler and nests cleanly.  
**Trade-offs:** `\include` can interact with separate build directories (aux paths); large books often still use `\include` for speed. TeX Stack Exchange documents edge cases with `latexmk -outdir` and `\include`; modern `latexmk` versions mitigate some subdirectory issues.

**Example:**

```latex
% main.tex
\documentclass{article}
\input{preamble}
\begin{document}
\input{chapters/01-intro}
\input{chapters/02-body}
\bibliography{references}
\end{document}
```

### Pattern 2: Centralized build directory (`latexmk` / `$out_dir`)

**What:** Direct PDF and aux files to `build/` (or `out/`) via `latexmk -outdir=build` or `.latexmkrc` (`$out_dir = 'build';`).  
**When to use:** You want a clean tree for IDE file search and Git; aligns with “light repeatable local build.”  
**Trade-offs:** Bibliography and some tools need correct search paths; may require `BIBINPUTS` or adjusting `.latexmkrc` so Biber/BibTeX find `.bib` files. See [TeX.SE discussions on `latexmk` output directory](https://tex.stackexchange.com/questions/11710/specify-output-directory-when-using-latexmk).

**Example (`.latexmkrc`):**

```perl
$pdf_mode = 1;
$out_dir = 'build';
```

### Pattern 3: Makefile or editor tasks as thin wrappers

**What:** One command (`make`, task: “LaTeX: build”) that calls `latexmk -pdf -interaction=nonstopmode main.tex`.  
**When to use:** Teams mixed between VS Code/Cursor and terminal; agents can run `make pdf` without guessing flags.  
**Trade-offs:** Duplication if both Make and `.latexmkrc` exist—keep flags in one place when possible.

## Data Flow

### Source → build → PDF

```
[.tex entry + \input tree] ──► [Engine: pdflatex / xelatex / lualatex]
        │                              │
        │                              ├──► [.aux, .toc, .lof, …]
        │                              │
[.bib] ─┼──► [biber or bibtex] ──► [.bbl] ──► (next LaTeX pass)
        │                              │
[figures] ──► [graphics inclusion in PDF]
                                        │
                                        ▼
                                 [main.pdf]
```

**Passes:** First LaTeX run writes aux; citation/bibliography tools read aux and write `.bbl`; LaTeX runs again to resolve references and citations. `latexmk` automates this dependency graph ([CTAN: latexmk](https://ctan.org/pkg/latexmk)).

### Key data flows

1. **Structural inclusion:** Entry TeX → partials via `\input`/`\include` (purely textual expansion / file boundaries).
2. **Bibliography:** `.tex` cites keys → aux records → `biber`/`bibtex` + `.bib` → `.bbl` → LaTeX incorporates citations.
3. **Graphics:** `\includegraphics{figures/foo}` resolves relative to current file or `\graphicspath{...}`.
4. **Sync (optional):** SyncTeX links PDF ↔ source for editor preview; produces `.synctex.gz` (usually ignored in Git).

## Suggested build order for setting up the repository

Use this order so each step has a stable foundation for the next (matches downstream phase planning).

1. **Choose layout** — Entry file location (root vs `src/`), names for `chapters/` and `figures/`, whether preamble is split.
2. **Add `.gitignore`** — At minimum: `*.aux`, `*.log`, `*.out`, `*.toc`, `*.bbl`, `*.blg`, `*.fdb_latexmk`, `*.fls`, `*.synctex.gz`, build dir. Decide team policy on committing `*.pdf` (many academic repos ignore PDF; some commit for releases—document in README).
3. **Wire the entry document** — Minimal compiling `main.tex` with one `\input` chapter to validate paths.
4. **Add bibliography and one figure** — Prove full pipeline (LaTeX + bib + graphics) before scaling file count.
5. **Add automation** — `.latexmkrc` and/or `Makefile` / editor task with the same flags everyone uses; if using `-outdir`, set it here and fix `BIBINPUTS`/paths if needed.
6. **Document** — README: TeX Live/MiKTeX assumed, exact build command, optional engine (`-xelatex`).
7. **CI (later, optional)** — Duplicate the same command in a workflow; pin image or document “no guaranteed distro” if staying local-only per project constraints.

## Scaling Considerations

| Scale | Architecture adjustments |
|-------|---------------------------|
| **Single short paper** | Flat root, few files; may skip separate `chapters/` until needed. |
| **Thesis / book** | Strong `\include` boundaries, possibly `frontmatter/`, `appendices/`; consider `latexmk` and strict `build/` to reduce noise. |
| **Multiple independent PDFs** | Subdirectories each with own `main.tex` or separate branches; avoid one global aux namespace. |
| **Shared macros across docs** | `tex/` or `common/` with guarded `\input`; watch duplicate `\label` across documents if compiling from same dir. |

### What breaks first

1. **Merge conflicts** in giant `.tex` files → mitigate with chapter-per-file and sentence-per-line wrapping for diffs.  
2. **Path fragility** when moving to `build/` or CI → fix with consistent relative paths, `\graphicspath`, and documented CWD for `latexmk`.  
3. **Non-reproducible builds** → pin local class files if journal template requires; document package assumptions in README.

## Anti-Patterns

### Anti-Pattern 1: Committing build artifacts by default

**What people do:** `git add` everything including `.aux`, `.log`, PDFs.  
**Why it's wrong:** Noise in history, merge pain on aux files, binaries bloat the repo.  
**Do this instead:** `.gitignore` build products; if PDFs are needed for reviewers, use Releases or a documented exception.

### Anti-Pattern 2: No single obvious compile target

**What people do:** Several top-level `.tex` files with no README or default task.  
**Why it's wrong:** Editors, CI, and agents cannot know which file to build.  
**Do this instead:** One canonical `main.tex` (or README lists `make paper` / `make slides` explicitly).

### Anti-Pattern 3: Mixing `\input` of preamble fragments incorrectly

**What people do:** Multiple partials each with `\documentclass` or stray `\begin{document}`.  
**Why it's wrong:** TeX structure errors and confusing compilation order.  
**Do this instead:** Exactly one preamble + one `\begin{document}`…`\end{document}` in the entry file (or a strictly controlled include chain).

### Anti-Pattern 4: Ignoring bibliography / outdir interaction until CI

**What people do:** Local compile “just works” from repo root; CI or `build/` breaks finding `.bib`.  
**Why it's wrong:** Silent CI failure or wrong references in clean checkouts.  
**Do this instead:** Test `latexmk` from a clean clone (or empty `build/`) early; set env or `.latexmkrc` as needed.

## Integration Points

### External systems

| System | Integration pattern | Notes |
|--------|---------------------|-------|
| **Local TeX distribution** | Invoke `latexmk` / engine binaries on PATH | Project does not enforce distro per `PROJECT.md`; README should name minimum requirement (e.g. TeX Live year). |
| **Cursor / VS Code** | LaTeX Workshop or tasks calling same command as CLI | Keeps agent and human builds aligned. |
| **GitHub / GitLab CI** | Job runs `latexmk -pdf -interaction=nonstopmode` | Often uses `xu-cheng/latex-action` or container with `texlive-full`; optional for v1. |
| **Overleaf** | Zip upload or git bridge | Out of scope for product, but same repo layout often imports cleanly if paths are relative. |

### Internal boundaries

| Boundary | Communication | Notes |
|----------|---------------|-------|
| **Chapters ↔ entry** | `\input` / `\include` | No circular includes; naming convention (`01-`, `02-`) helps ordering. |
| **Figures ↔ prose** | File path only | Prefer vector PDF/SVG workflow team agrees on. |
| **Macros ↔ content** | `\input` of `preamble` or `macros.tex` | Keep generic macros separate from single-paper content when reusing repo. |

## Sources

- [CTAN: latexmk](https://ctan.org/pkg/latexmk) — automated multi-pass builds, dependency tracking (HIGH confidence for role of latexmk).
- [latexmk manual (PDF)](https://mirrors.ctan.org/support/latexmk/latexmk.pdf) — authoritative flags and configuration.
- [TeX Stack Exchange: output directory with latexmk](https://tex.stackexchange.com/questions/11710/specify-output-directory-when-using-latexmk) — practical constraints for `BIBINPUTS` / paths (MEDIUM).
- Community workflow writeups (structure, Git hygiene): e.g. [large LaTeX project organization](https://www.thetapad.com/blog/managing-large-documents), [LaTeX + GitHub tips](https://willfondrie.com/2024/02/10-tips-for-collaborative-writing-with-latex-and-github/) (MEDIUM — patterns align with common practice, not formal standards).

---
*Architecture research for: LaTeX repository layout (`tex`)*  
*Researched: 2025-03-25*
