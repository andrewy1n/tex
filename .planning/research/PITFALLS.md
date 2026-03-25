# Pitfalls Research

**Domain:** LaTeX sources in git, editor-first workflow (Cursor/VS Code), coding agents, local builds  
**Researched:** 2025-03-25  
**Confidence:** MEDIUM–HIGH (community consensus + official templates; some editor/toolchain edge cases vary by version)

## Critical Pitfalls

### Pitfall 1: Tracking build artifacts and editor cruft

**What goes wrong:**  
Auxiliary files (`*.aux`, `*.log`, `*.toc`, `*.out`, `*.fls`, `*.fdb_latexmk`, `*.synctex.gz`, `*.bbl`/`*.blg` in BibTeX workflows, etc.) get committed. Diffs become unreadable, merges conflict on machine-generated content, and teammates see “dirty” trees after every local compile. Stale `*.aux` can also mask real errors when someone pulls an inconsistent artifact set.

**Why it happens:**  
Compiling in the source tree is the default; `.gitignore` is easy to defer. People disagree whether to track `*.pdf`, so teams sometimes track everything or nothing consistently wrong.

**How to avoid:**  
Adopt a maintained TeX-oriented ignore baseline (e.g. [GitHub `TeX.gitignore`](https://github.com/github/gitignore/blob/main/TeX.gitignore)), extend for your tools (minted, glossaries, beamer, etc.), and **decide explicitly** whether PDFs are outputs (usually ignore) or release artifacts (track only if you accept binary churn). Prefer `**/*.aux`-style patterns if sources live in subfolders. Keep a single repo-wide policy documented.

**Warning signs:**  
`git status` lists `.aux`/`.log` after compile; PRs touching dozens of “binary-looking” or generated paths; merge conflicts in `.toc` or `.bbl`.

**Phase to address:**  
**Phase 1** (repository hygiene and layout)

---

### Pitfall 2: Fragile paths and working directory (agents, tasks, and `latexmk`)

**What goes wrong:**  
Build scripts, editor tasks, or agent instructions assume a fixed cwd (e.g. repo root) while the main `.tex` lives in a subfolder—or the opposite. Using `-output-directory` / `$out_dir` with absolute paths, or mixing `-cd` with outdir, can break `makeindex`, BibTeX paths, or `\input` resolution depending on engine and tool versions. Agents that “run pdflatex on the open file” compile the wrong document or miss `\input` dependencies.

**Why it happens:**  
LaTeX resolves many paths relative to the **current working directory** and the **main file’s location**; IDEs and wrappers don’t always match the CLI mental model. Output-directory features in `latexmk` and editor extensions have long-standing edge cases (e.g. LaTeX-Workshop / `latexmk` interaction issues around outdir and `-cd`).

**How to avoid:**  
Define one **documented master file** (or per-folder masters). Centralize build entrypoints (`latexmk -pdf main.tex`, Makefile with explicit `cd`, or `.latexmkrc` with **relative** `$out_dir`). Editor tasks and agent rules should call the same entrypoint with an explicit `cwd`. If you use a build dir, git-ignore it and avoid committing paths that only exist on one machine.

**Warning signs:**  
“File not found” for figures or `.tex` chunks only in the IDE, not on terminal (or vice versa); aux files appearing beside sources *and* under `build/`; partial PDFs when `\include` is used.

**Phase to address:**  
**Phase 1–2** (layout in Phase 1; repeatable build contract in Phase 2)

---

### Pitfall 3: Partial compiles and wrong “root” in multi-file projects

**What goes wrong:**  
Running `pdflatex` on a chapter file instead of the root document skips the preamble, produces empty or wrong output, or leaves references/citations unresolved. `\include`/`\includeonly` workflows confuse newcomers and agents, who think one file “is” the project.

**Why it happens:**  
Multi-file LaTeX is structured as a single logical document; tools expose individual `.tex` files in the tree.

**How to avoid:**  
Name or locate the master clearly (`main.tex`, `book.tex`, or README “build: x”). Use `latexmk` with `@default_files` in `.latexmkrc` or a Makefile target `pdf` that only builds the master. For agents: a short `AGENTS.md` or `.cursor` rule stating “never compile subfiles directly; use …”.

**Warning signs:**  
Missing packages or `\newcommand` errors when compiling “the chapter”; TOC/refs never stabilize; citation keys undefined only in CI or for one teammate.

**Phase to address:**  
**Phase 1** (conventions); **Phase 2** (enforced entrypoint)

---

### Pitfall 4: Binary and large-asset bloat (PDFs, figures, generated plots)

**What goes wrong:**  
Committed high-res images, exported PDFs, or regenerated plots inflate clone size and make history painful. Alternatively, **not** using Git LFS when you *must* track large binaries leads to the same problem. Diffs on PDFs are useless; rebases touch megabytes.

**Why it happens:**  
Figures are “part of the paper” so they feel like source; outputs are convenient to share.

**How to avoid:**  
Prefer vector or manageable raster sources in git; ignore regenerated outputs where possible; use [Git LFS](https://git-lfs.com/) for unavoidable large binaries with documented `git lfs install` / track patterns. If PDFs are deliverables, consider attaching them to releases instead of main branch history.

**Warning signs:**  
`git clone` is slow; `git log --stat` dominated by image/PDF changes; Git hosting warns about file size.

**Phase to address:**  
**Phase 1** (asset policy); **Phase 3** if you add release/docs automation later

---

### Pitfall 5: Bibliography source vs generated files (BibTeX / biber / biblatex)

**What goes wrong:**  
Teams commit hand-edited `*.bbl` while also using `*.bib`, causing overwrites or drift. Or they ignore `*.bbl` but someone relies on it without running biber. Cross-platform encodings in `.bib` break silently.

**Why it happens:**  
Overleaf-style “it just works” hides the distinction between **source** (`.bib`) and **generated** (`*.bbl`, `*.bcf`, run logs).

**How to avoid:**  
Treat `.bib` as source of truth; ignore generated bibliography artifacts unless you have a rare, documented reason. Document the engine (`bibtex` vs `biber`) in the same place as the master file. Run full cycles (`latexmk` or documented sequence) after bib changes.

**Warning signs:**  
Citation undefined for others but not locally; `*.bbl` in code review with hand edits; conflicting citation styles between commits.

**Phase to address:**  
**Phase 2** (build reproducibility)

---

### Pitfall 6: Agent and editor edits that break LaTeX semantics

**What goes wrong:**  
Agents “normalize” backslashes, unwrap environments, change `%` comments, or split lines inside `\verb`/`minted`, introducing hard-to-spot syntax errors. Bulk reflow can break `%` line continuation and `verbatim`-like blocks. Suggested “fixes” may add packages without adding them to the real preamble or duplicate `\usepackage`.

**Why it happens:**  
LaTeX is text, but not “plain text” to refactor blindly; LLMs optimize for common programming languages.

**How to avoid:**  
Repo-level guidance: “preserve `%` at line ends where present”; don’t refactor inside `verbatim`, `minted`, or complex macro args without compiling. Prefer small diffs; run the project build after substantive edits. Optional: CI later for regression detection.

**Warning signs:**  
Mysterious “Runaway argument?” or “Unicode character not set up”; diff shows mass reformatting of `.tex`; builds pass on one chunk only.

**Phase to address:**  
**Phase 2** (conventions for agents/editors); **Phase 4+** if you add automated build checks

---

### Pitfall 7: Shell escape, minted, and write18 artifacts

**What goes wrong:**  
`minted`, `svg`, `gnuplot`, or `\write18`-dependent workflows create cache dirs or temp files; if ignored incorrectly, either cruft gets committed or required cache is missing on clone. `-shell-escape` increases supply-chain and malicious-TeX risk if you compile untrusted `.tex`.

**Why it happens:**  
Power packages need external programs; defaults differ across distributions.

**How to avoid:**  
Document required flags (`--shell-escape` / `latexmk` config). Ignore minted cache directories if they’re regenerable. **Do not** compile untrusted `.tex` with shell escape enabled. Pin package versions where practical (TeX Live year, project README).

**Warning signs:**  
New “missing pygments” or “shell escape” errors after environment change; unexpected binaries or scripts appearing beside sources.

**Phase to address:**  
**Phase 2** (build flags documented); security hygiene ongoing

---

## Technical Debt Patterns

| Shortcut | Immediate Benefit | Long-term Cost | When Acceptable |
|----------|-------------------|----------------|-----------------|
| “Just run `pdflatex` twice” with no script | Fast for one person | Wrong order for bib/glossaries; agents can’t reproduce | Never as the **only** documented workflow; OK for quick local debug if Phase 2 adds a real entrypoint |
| Committing PDFs for “easy sharing” | One less step for readers | Repo bloat, meaningless merges | Only for tiny static deliverables with team agreement; prefer artifacts outside main history |
| Per-user `.latexmkrc` only | Personal tuning | Onboarding and agents diverge from maintainers | OK if machine-local; duplicate **project** `.latexmkrc` in repo for shared truth |
| Relying on global `TEXMFHOME` for project classes | Avoids vendoring | Clone doesn’t build on fresh machines | Acceptable for solo machines only; Phase 1 should vendor or document required trees |

## Integration Gotchas

| Integration | Common Mistake | Correct Approach |
|-------------|----------------|------------------|
| Local TeX distribution (TeX Live vs MiKTeX vs MacTeX) | Assuming a package exists everywhere | Document minimum year/flavor; avoid exotic packages without fallbacks |
| Editor (LaTeX Workshop, etc.) | Build recipe points at wrong root or outdir | Align recipe `cwd` and args with CLI `latexmk`/Makefile |
| `synctex` | Expecting perfect jump-to-source with outdir misconfiguration | Match `-synctex=1` and editor outdir settings to actual layout |
| `git` on Windows vs Linux | Line endings or case sensitivity break `\input` | `.gitattributes` for `*.tex` as text; consistent file naming case |

## Performance Traps

| Trap | Symptoms | Prevention | When It Breaks |
|------|----------|------------|----------------|
| Monolithic root `main.tex` with huge `\input` chain | Every edit triggers full rebuild | Split with `\include` where appropriate; strategic `latexmk` deps | Large theses; frequent iteration |
| Committed build outputs + many collaborators | Constant merge noise | Ignore aux/PDF per policy; single master build | 2+ active branches touching “outputs” |
| Unoptimized raster figures | Slow compile and huge PDF | Compress targets; vector for diagrams | Books with many figures |

## Repo hygiene & path safety

*(Replaces generic web-app security section: this project is source-first, not a hosted LaTeX service.)*

| Mistake | Risk | Prevention |
|---------|------|------------|
| Running `-shell-escape` on untrusted or pasted `.tex` | Arbitrary code execution via TeX | Only enable for trusted trees; never for random snippets |
| Build scripts that `cd` using unquoted paths | Breakage or odd behavior with spaces in usernames/paths | Quote paths; prefer repo-relative invocations |
| Secrets in `.tex` or `\usepackage` paths | Accidental leak via git or logs | No credentials in source; env vars for non-TeX tooling if needed |
| World-writable shared build dirs (shared machines) | Tampering with aux before compile | User-private build dirs; ignore in git |

## UX Pitfalls

| Pitfall | User Impact | Better Approach |
|---------|-------------|-----------------|
| No documented “how to build” | Editors and agents guess | README one-liner + same task in editor |
| PDF open while compiling (some viewers) | “File locked” errors on Windows | Close viewer or use auto-reload that releases lock |
| Ignoring `latexmk` entirely | “Forgot to run biber” support burden | Standardize on `latexmk` or a Makefile that runs full cycle |
| Deep folders without README | Navigation fatigue | Top-level map of documents (which master = which PDF) |

## "Looks Done But Isn't" Checklist

- [ ] **Clean clone:** Fresh clone + documented build produces PDF without manual file moves
- [ ] **`git status` clean after build:** Aux and chosen outputs match `.gitignore` policy
- [ ] **Bibliography:** Adding a citation and rebuilding works from clean aux (full cycle documented)
- [ ] **Multi-file:** Compiling only the master matches what README claims; no hidden second entrypoint
- [ ] **Agent safety:** Large automated edits were followed by a full compile of the **master** document
- [ ] **Cross-platform:** Paths in `\input`/`\includegraphics` work from repo root with documented cwd

## Recovery Strategies

| Pitfall | Recovery Cost | Recovery Steps |
|---------|---------------|----------------|
| Committed aux noise | LOW–MEDIUM | Add/fix `.gitignore`; `git rm --cached` on artifacts; one “purge” commit; teammates rebase |
| Wrong PDF / stale refs | LOW | Delete aux for that document (`latexmk -C` or clean script); full rebuild |
| Massive binary in history | HIGH | Remove with `git filter-repo` or BFG; force-push coordination; prefer LFS going forward |
| Agent-broken `.tex` | LOW–MEDIUM | Revert hunk or file; rebuild; tighten agent/CONTRIBUTOR rules |

## Pitfall-to-Phase Mapping

| Pitfall | Prevention Phase | Verification |
|---------|------------------|--------------|
| Tracking build artifacts | Phase 1 | Clean clone → build → `git status` shows only intentional changes |
| Path / cwd fragility | Phase 1–2 | Same command works from README and from editor task with explicit cwd |
| Wrong master / partial compile | Phase 1–2 | Only documented target builds; subfiles not used as compile roots |
| Large binary bloat | Phase 1 | Clone size reasonable; LFS or ignore policy documented |
| Bib source vs generated confusion | Phase 2 | Delete aux/bbl locally; rebuild restores citations |
| Agent semantic breakage | Phase 2 | Spot-check agent-edited PRs with full master build |
| Shell escape / minted | Phase 2 | README lists required flags; clean build from README on fresh env |
| Toolchain / editor integration | Phase 2–3 | Second machine (or teammate) confirms README build |

## Sources

- [github/gitignore: `TeX.gitignore`](https://github.com/github/gitignore/blob/main/TeX.gitignore) — baseline ignore patterns (HIGH confidence for file categories)
- [TeX Stack Exchange: Which auxiliary LaTeX files should be ignored by VCS?](https://tex.stackexchange.com/questions/17845/which-auxiliary-latex-files-should-be-ignored-by-version-control-software) — community consensus on aux vs source (MEDIUM)
- [LaTeX-Workshop / latexmk outdir issues (e.g. #1932)](https://github.com/James-Yu/LaTeX-Workshop/issues/1932) — real-world cwd/outdir fragility (MEDIUM; tool versions evolve)
- [tex.stackexchange: `latexmk` output directory](https://tex.stackexchange.com/questions/11710/specify-output-directory-when-using-latexmk) — `latexmk` configuration patterns (MEDIUM)
- Project context: `.planning/PROJECT.md` (editor-first, local TeX, agents) — scope alignment

---
*Pitfalls research for: LaTeX in git + editors + coding agents*  
*Researched: 2025-03-25*
