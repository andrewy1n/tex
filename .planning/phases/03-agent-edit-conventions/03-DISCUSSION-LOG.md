# Phase 3: Agent & edit conventions - Discussion Log

> **Audit trail only.** Do not use as input to planning, research, or execution agents.  
> Decisions are captured in `03-CONTEXT.md` — this log preserves the alternatives considered.

**Date:** 2026-03-25  
**Phase:** 3 — Agent & edit conventions  
**Areas discussed:** Where the contract lives; `.cursor/rules` relationship; Build detail duplication; Automation expectations depth

---

## Where the contract lives

| Option | Description | Selected |
|--------|-------------|----------|
| a | Dedicated `AGENTS.md` at repo root; README short pointer | ✓ |
| b | README-only section (no `AGENTS.md`) | |
| c | `AGENTS.md` + fuller duplication in README | |

**User's choice:** **1a**  
**Notes:** README stays lean; `AGENTS.md` is the dedicated contract (AGT-01).

---

## Relationship to `.cursor/rules`

| Option | Description | Selected |
|--------|-------------|----------|
| a | Keep rules as-is; add short pointer to `AGENTS.md` only (no duplicated LaTeX rules) | ✓ |
| b | Mirror key bullets in `.cursor/rules` and keep `AGENTS.md` | |
| c | Rules-only; no `AGENTS.md` | |

**User's choice:** **2a**  
**Notes:** Single source of truth for LaTeX agent edits: `AGENTS.md`.

---

## Build detail in the agent contract

| Option | Description | Selected |
|--------|-------------|----------|
| a | Pointer only to `README.md` Build section (no duplicated commands) | ✓ |
| b | One-line summary + pointer | |
| c | Full copy of `latexmk` / `make` snippets | |

**User's choice:** **3a**  
**Notes:** README remains canonical for exact commands (Phase 2 alignment).

---

## Automation / edit expectations depth

| Option | Description | Selected |
|--------|-------------|----------|
| a | Roadmap minimum: no aux commits; preserve `%` continuations; no root `main.pdf` per policy | ✓ |
| b | Minimum + extra guardrails (`\input` scope, run build after edits, avoid drive-by reformat) | |
| c | Longer checklist (encoding, packages, bib workflow, etc.) | |

**User's choice:** **4a**  
**Notes:** Shortest doc; meets ROADMAP success criteria without extra bullets.

---

## Claude's Discretion

- Wording and placement of README pointer; exact `AGENTS.md` structure; optional anchor style for README link.

## Deferred Ideas

- None recorded in this session.
