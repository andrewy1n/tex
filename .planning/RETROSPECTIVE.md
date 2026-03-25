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

## Cross-Milestone trends

### Process evolution

| Milestone | Phases | Note |
|-----------|--------|------|
| v1.0 | 3 | First shipped version; GSD phases 1–3 |
