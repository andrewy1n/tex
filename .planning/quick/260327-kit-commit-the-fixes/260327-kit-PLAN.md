---
title: Commit devcontainer fixes
---

## Goal

Record the devcontainer fixes (latexindent via `texlive-extra-utils`, sudo-scoped workspace `chown`, `postStartCommand`), update the `projects/private` submodule pointer, and add the EACCES debug note.

## Tasks

### 1. Commit working-tree fixes

**Files:** `.devcontainer/Dockerfile`, `.devcontainer/devcontainer.json`, `.devcontainer/fix-workspace-perms.sh`, `projects/private`, `.planning/debug/devcontainer-eacces-latexindent.md`

**Action:** Stage (exclude `.claude/` — local IDE metadata). Commit with a conventional message describing devcontainer + submodule + debug doc.

**Verify:** `git status` clean for intended paths; `git log -1 --stat` shows the commit.
