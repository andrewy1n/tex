# Project Retrospective

*Living document updated after each milestone.*

## Milestone: v1.0 — IDE-first LaTeX repo

**Shipped:** 2026-03-25  
**Phases:** 3 | **Plans:** 7 | **Sessions:** —

### What was built

- Navigable LaTeX repo with `main.tex` at root, `figures/`, `bib/`, `sections/`, and README onboarding.
- GitHub TeX `.gitignore` plus project overrides for root `main.pdf` and trackable figure PDFs.
- `.latexmkrc`, `Makefile`, and README **Build** documenting one primary `latexmk` line from repo root.
- `AGENTS.md` and pointers in README / `.cursor/rules` for agent and automation expectations.

### What worked

- Phased ordering (layout → build → agent conventions) kept dependencies obvious.
- Single sources of truth: README for commands, `AGENTS.md` for agent policy (no duplicated `latexmk` blocks in `AGENTS.md`).

### What was inefficient

- Local `latexmk` was not available in one execution environment; verification relied on config consistency and documented commands instead of a green build in CI.

### Patterns established

- **D-19-style build references:** convention docs point at README **Build** instead of copying command blocks.
- **Milestone archives:** full roadmap and requirements preserved under `.planning/milestones/`.

### Key lessons

1. Keep agent-facing prose in `AGENTS.md`; use README and rules only for short pointers.
2. Archive roadmap and requirements at milestone boundaries so `.planning/ROADMAP.md` stays small.

### Cost observations

- Not tracked for this workspace.

---

## Milestone: v1.1 — Multi-project workspace & live PDF

**Shipped:** 2026-03-26  
**Phases:** 2 | **Plans:** 4 | **Sessions:** —

### What was built

- `projects/sample/` migration with per-project build outputs and `PROJECTS.md` as the project index.
- `README.md` / `AGENTS.md` retargeted for multiple masters without duplicating full `latexmk` blocks.
- Committed `.vscode/` LaTeX Workshop settings (tab PDF, onSave, root globs) aligned with documented builds.
- README LaTeX Workshop section: keys, onSave vs manual, `% !TEX root`, SyncTeX optional, WSL/remote notes.

### What worked

- Reusing v1.0 patterns: README owns commands; `AGENTS.md` stays policy-level.
- Phases 4 then 5 respected dependency (project roots before preview docs).

### What was inefficient

- Same constraint as v1.0: some environments lack a local `latexmk`; verification leaned on config and docs.

### Patterns established

- Per-project `build/` output dirs and ignore rules scaled cleanly from single-root v1.0.

### Key lessons

1. Index file (`PROJECTS.md`) plus one sample project makes multi-root discovery obvious for humans and agents.
2. Committing minimal `.vscode/` removes “works on my machine” friction for PDF tab + refresh.

### Cost observations

- Not tracked for this workspace.

---

## Milestone: v1.2 — Quality tooling & templates

**Shipped:** 2026-03-27  
**Phases:** 2 | **Plans:** 2 | **Sessions:** —

### What was built

- README **Linting** and **Formatting** for `chktex` and `latexindent` with committed `.latexindent.yaml` and `make format`.
- VS Code / LaTeX Workshop settings for format-on-save on `.tex` files (aligned with project formatter config).
- README **Revision Tracking** and `make diff SRC=… CMP=…` producing timestamped diff PDFs under each project `build/`.
- Makefile guardrails for missing `SRC`/`CMP` paths.

### What worked

- Keeping tools optional and documentation-first matches small-repo contributor expectations.
- One root `.latexindent.yaml` shared across `projects/*/` keeps formatting consistent.

### What was inefficient

- Marketplace / Cursor differences for LaTeX formatters required a follow-up quick task (LaTeX Workshop–native `latexindent`).

### Patterns established

- **Makefile as thin wrapper** — `format` and `diff` targets document the “blessed” commands next to `pdf`.

### Key lessons

1. Ship docs and repo config first; CI and pre-commit hooks can follow as optional layers.
2. Archive requirements with checked traceability so milestone closure does not leave stale `[ ]` boxes.

### Cost observations

- Not tracked for this workspace.

---

## Cross-Milestone trends

### Process evolution

| Milestone | Phases | Note |
|-----------|--------|------|
| v1.0 | 3 | First shipped version; GSD phases 1–3 |
| v1.1 | 2 | Multi-project layout + live PDF preview (phases 4–5) |
| v1.2 | 2 | Linting, formatting, `latexdiff` workflow (phases 6–7) |
