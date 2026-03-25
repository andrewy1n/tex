# Feature Research

**Domain:** Git-based LaTeX workspace — versioned sources edited in Cursor/VS Code with coding-agent access and local, repeatable PDF builds (not a hosted editor).

**Researched:** 2025-03-25

**Confidence:** MEDIUM — Table stakes and collaboration patterns are well documented in community guides and editor/extension docs; agent-specific ergonomics are inferred from IDE + LLM workflow practice (few formal “standards”).

## Feature Landscape

### Table Stakes (Users Expect These)

Features people assume in a **professional, shareable LaTeX repo**. Missing these makes the repo feel “unfinished” or painful for collaborators and tools.

| Feature | Why Expected | Complexity | Notes |
|---------|--------------|------------|-------|
| **Obvious project entry point** | Build tools and editors need one logical “main” document (or a documented alternative). | LOW | Convention: `main.tex` / `paper.tex`, or documented in README. Multi-file projects often use `% !TeX root = ...` in children so LaTeX Workshop and `latexmk` behave predictably from subfiles. |
| **Sane directory layout** | Find sources, figures, and bibliography without archaeology; reduces merge pain. | LOW–MEDIUM | Common pattern: `chapters/` or `sections/`, `figures/`, `styles/`, root-level `.bib` or `bib/` — aligns with widely recommended splits for large docs and Git. |
| **Multi-file structure (when doc is non-trivial)** | Readable diffs, fewer merge conflicts, parallel editing. | LOW | Single huge `.tex` is a red flag for Git + teams; split by chapter/section. |
| **`.gitignore` for LaTeX auxiliaries** | Repo stays clean; no accidental commits of `.aux`, `.log`, `.synctex.gz`, etc. | LOW | Standard lists exist (e.g. [GitHub `TeX.gitignore`](https://raw.githubusercontent.com/github/gitignore/main/TeX.gitignore)); **review** any rule that might ignore assets you need (some templates comment out `*.pdf`). |
| **Bibliography and data in-repo** | Reproducible text and citations; same inputs for all clones. | LOW | `.bib` (or generated `.bib` policy documented), citation keys stable; biber/bibtex engine choice documented if non-default. |
| **Figures and assets in-repo (or LFS policy)** | PDF builds work on a fresh clone. | LOW–MEDIUM | Small images in Git; large binaries → [Git LFS](https://git-lfs.com/) or documented external fetch — otherwise clones break. |
| **Repeatable local build** | “Clone → build → PDF” without tribal knowledge. | LOW–MEDIUM | `latexmk` (often via `.latexmkrc`), **or** Makefile/scripts; README names the command. Matches project’s “light build hooks” requirement. |
| **README: how to build and layout map** | Onboarding for humans and a single source of truth for conventions. | LOW | Prerequisites (TeX distro, optional VS Code extensions), main file, build command, optional lint/format. |
| **Line-oriented `.tex` (reasonable line length)** | Usable diffs in Git and in agent/IDE review. | LOW | Soft-wrap in editor; avoid megabyte single-line paragraphs. |

### Differentiators (Competitive Advantage)

Features that **fit this product’s core value** (IDE + agent + Git) but go beyond “any old `.tex` folder.” Not all are mandatory for v1.

| Feature | Value Proposition | Complexity | Notes |
|---------|-------------------|------------|-------|
| **Editor-native integration** | One-click / shortcut build, PDF preview, SyncTeX jump source↔PDF. | LOW | [LaTeX Workshop](https://github.com/James-Yu/latex-workshop) for VS Code/Cursor; `.vscode/settings.json` / `tasks.json` for shared team defaults. |
| **Explicit “contract” for agents** | Agents reliably find root file, build command, and conventions without guessing. | LOW | Short `AGENTS.md` / section in README: root `.tex`, build invocation, figure path rules, “do not edit generated files.” |
| **Consistent path and inclusion discipline** | Fewer “file not found” and wrong-WD builds in multi-file trees. | MEDIUM | Prefer paths relative to project root; align `latex-workshop.latex.outDir` / recipe with repo layout (known pain point for subfiles + `latexmk` CWD). |
| **Optional quality gates (local)** | Cleaner `.tex` before commit; helps both humans and agents. | LOW–MEDIUM | `chktex`, `lacheck`, or `latexindent` in optional scripts/docs — not required for minimal PDF. |
| **Spell / grammar assistance config** | Fewer typos shipped; agents can respect dictionary scope. | LOW | Editor spell-check settings or project word list; optional. |
| **Optional `latexdiff` / review helpers** | Easier submission-style review without hosted UI. | MEDIUM | Workflow docs for comparing revisions — valuable for papers, not for every note repo. |
| **Docker/devcontainer (optional)** | Reproducible toolchain across laptops without mandating one distro globally. | MEDIUM | **Differentiator** vs “bring your own TeX”; still optional per PROJECT.md (no enforced distro). |

### Anti-Features (Commonly Requested, Often Problematic)

| Feature | Why Requested | Why Problematic | Alternative |
|---------|---------------|-----------------|-------------|
| **Overleaf-class hosted editor + live co-edit** | Familiar for coauthors | Out of scope; different product surface (auth, hosting, sync). | Git + PR workflow; optional Overleaf Git bridge **outside** this repo’s responsibilities. |
| **Mandatory CI PDF on every push (v1)** | “Green builds” | PROJECT.md defers mandatory CI; adds runner + TeX image maintenance before core repo ergonomics proven. | Document local build; add CI later as optional validation. |
| **Committing generated PDFs by default** | Easy sharing | Binary noise, merge conflicts, stale artifacts. | Tag releases / attach PDFs / CI artifacts; or commit PDF only when policy explicitly requires it. |
| **Monolithic single `.tex` for “simplicity”** | Fewer files | Brutal Git diffs, bad for collaboration and agent context targeting. | Split includes; keep preamble/macros separate. |
| **Pinning “the one true” TeX install inside repo for everyone** | Reproducibility | Heavy-handed; conflicts with “developers use their own local TeX install.” | Optional devcontainer; document minimum packages/engine. |
| **Opaque auto-build magic with no logged errors** | Convenience | Silent failures erode trust (especially when agents run builds). | Verbose `latexmk` / log on failure; README troubleshooting section. |

## Feature Dependencies

```
[README + layout map]
    └──requires──> [Obvious project entry point]

[Repeatable local build (latexmk/Makefile)]
    └──requires──> [Entry point / root resolution]
                       └──enhanced by──> [% !TeX root or single obvious main.tex]

[Multi-file structure]
    └──requires──> [Consistent relative paths + editor/outDir alignment]
    └──enhances──> [Git-friendly diffs]

[Bibliography in-repo]
    └──requires──> [Documented engine: bibtex vs biber]

[Figures in-repo / LFS]
    └──requires──> [.gitignore that does NOT exclude needed assets]

[Agent-oriented conventions]
    └──requires──> [Human-readable README/AGENTS.md]
    └──enhances──> [Obvious entry point + single build command]
```

### Dependency Notes

- **README + entry point:** Onboarding is empty without naming the main `.tex` and how to compile.
- **Build repeatability → root resolution:** Multi-file projects fail in the IDE if root/CWD is wrong; magic comments or workspace settings reduce fragility.
- **Multi-file → paths:** Includes and graphics resolve from predictable roots; misaligned `outDir` breaks subsidiary builds.
- **`.gitignore` vs assets:** A blanket ignore of `*.pdf` can accidentally drop required figures — policy must be explicit.

## MVP Definition

### Launch With (v1)

Aligned with **Active** requirements in `.planning/PROJECT.md`.

- [ ] **Navigable in-repo layout** — `.tex`, `.bib`, figures, and local `.cls`/`.sty` live in predictable places.
- [ ] **Cursor/VS Code–friendly editing** — no dependency on a web UI; normal workspace opening.
- [ ] **Agent-readable workspace** — same tree agents use as humans; short convention doc if needed.
- [ ] **One documented build path** — e.g. `latexmk -pdf main.tex` or `make pdf`; works on a machine with a normal TeX install.

### Add After Validation (v1.x)

- [ ] **Shared `.vscode` recipes** — once layout stabilizes.
- [ ] **Optional lint/format scripts** — when churn justifies them.
- [ ] **Git LFS** — when binary weight hurts clones.

### Future Consideration (v2+)

- [ ] **CI PDF build (optional)** — when team wants PR gates.
- [ ] **Devcontainer** — when “same TeX everywhere” outweighs setup cost.
- [ ] **Automated release PDFs** — GitHub Releases / Pages pattern.

## Feature Prioritization Matrix

| Feature | User Value | Implementation Cost | Priority |
|---------|------------|---------------------|----------|
| Entry point + README | HIGH | LOW | P1 |
| `.gitignore` for aux files | HIGH | LOW | P1 |
| Repeatable local build | HIGH | LOW–MEDIUM | P1 |
| Multi-file layout (non-trivial docs) | HIGH | LOW | P1 |
| Bibliography + figures in-repo | HIGH | LOW | P1 |
| LaTeX Workshop / shared tasks | MEDIUM | LOW | P2 |
| Agent convention doc | MEDIUM | LOW | P2 |
| Path/outDir alignment for multi-file | MEDIUM | MEDIUM | P2 |
| Local lint/format | MEDIUM | LOW–MEDIUM | P3 |
| `latexdiff` workflow docs | LOW–MEDIUM | MEDIUM | P3 |
| Devcontainer | MEDIUM | MEDIUM | P3 |
| CI PDF | MEDIUM | MEDIUM | P3 (defer per PROJECT) |

**Priority key:**

- P1: Must have for launch (matches “well-run repo” + PROJECT Active list)
- P2: Should have for smooth IDE/agent experience
- P3: Nice to have / defer

## Competitor Feature Analysis

| Feature | Overleaf (hosted) | Local Git + VS Code | Our Approach |
|---------|-------------------|---------------------|--------------|
| Real-time co-edit | Core | Not applicable | Out of scope (PROJECT.md) |
| Git versioning | Git bridge / sync | Native | **Core** |
| One-click PDF build | Built-in | LaTeX Workshop + `latexmk` | Document + optional `.vscode` |
| Agent access to sources | Limited / API-shaped | Full workspace | **Core** (plain files) |
| Reproducible environment | Their image | BYO TeX; optional Docker | BYO TeX; optional devcontainer later |
| PR/build validation | Optional integrations | GitHub Actions, etc. | Explicitly optional in v1 |

## Sources

- Project scope and constraints: `.planning/PROJECT.md`
- LaTeX + Git workflow and VS Code: [Paul Brenker — TeX + GitHub + VS Code (2025)](https://www.pbrenk.com/2025/02/20/tex-github-workflow/) (MEDIUM — single author blog)
- Repo structure / splitting for Git: [Trevor Campbell — paper repo setup](https://trevorcampbell.me/html/paperrepo.html) (MEDIUM)
- Large-document organization: [Thetapad — organizing large LaTeX projects](https://www.thetapad.com/blog/managing-large-documents) (MEDIUM)
- LaTeX Workshop multi-file / root / CWD: [LaTeX Workshop Wiki — Compile](https://github.com/James-Yu/latex-workshop/wiki/Compile), [TeX.SE — workspace root](https://tex.stackexchange.com/questions/745774/vscode-latex-workshop-set-root-master-file-for-all-files-within-a-project-from) (MEDIUM)
- Standard ignore patterns: [github/gitignore `TeX.gitignore`](https://github.com/github/gitignore/blob/main/TeX.gitignore) (HIGH for ignore *list*; still verify against your asset policy)

---
*Feature research for: git-based LaTeX workspace (Cursor/VS Code + agents)*

*Researched: 2025-03-25*
