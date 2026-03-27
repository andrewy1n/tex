# Debug: devcontainer-files-lost-reopen

**Date:** 2026-03-27  
**Symptom:** After closing and reopening the dev container (or the editor), the workspace under `/workspace` appears empty or missing most project files.

---

## Hypotheses considered

| # | Hypothesis | Result |
|---|------------|--------|
| 1 | Files created outside the bind mount (`/tmp`, home) lost on rebuild | **Unlikely** for “whole repo missing”; rebuild does not remove host files. |
| 2 | Wrong folder opened or **Attach to Running Container** without the normal workspace mount | **Plausible** for some workflows; attach can show image-only content if mount was never applied. |
| 3 | WSL2 / Docker Desktop path (Windows FS vs WSL FS) | **Plausible** for performance or odd mount behavior; not the usual “empty” pattern. |
| 4 | **Rebuild** vs **reopen** confusion | Rebuild replaces the image; bind mount should still show host tree if mount is correct. |
| 5 | Submodule `projects/private` empty | **Possible confusion:** submodule not inited looks “empty”; different from entire repo missing. |
| 6 | Default mount inference when **host `git` is not on `PATH`** | **Strong match** for “almost everything gone” (see evidence). |

---

## Evidence (repo + product behavior)

### `devcontainer.json` (before fix)

- `workspaceFolder`: `/workspace`
- `mounts`: `[]` (no *extra* mounts; default workspace bind still applied by Dev Containers)
- No named volume over `/workspace` that would hide the host tree
- `postCreateCommand` only prints tool versions — does not delete or move sources
- `shutdownAction`: `none` — does not explain empty `/workspace` on reconnect

### Dockerfile

- Creates `/workspace` and `chown` for `vscode`; at **runtime** a bind mount overlays `/workspace` with the host project. No config here removes files on reopen.

### Microsoft Dev Containers: default bind behavior

From [Change the default source code mount](https://code.visualstudio.com/remote/advancedcontainers/change-default-source-mount):

- If **`git` is on the host `PATH`** and the opened folder is inside a Git repo, the mounted workspace is typically the **repository root**.
- If **`git` is not on the host `PATH`**, the mounted folder is the **folder containing `.devcontainer/devcontainer.json`**, i.e. **only** `.devcontainer/` — not the full LaTeX repo.

In that situation, `/workspace` shows essentially **Dockerfile + devcontainer.json** (and any sibling files under `.devcontainer/`), while **`projects/`**, **`README.md`**, etc. are **not** mounted. That matches reports of “all files gone” or “workspace wrong” after reopen, especially if the editor’s environment sometimes lacks `git` on `PATH` (minimal PATH, certain launches, or tooling sandboxes).

---

## Fix applied (configuration)

**Explicit bind** so the mount always matches the **folder you opened** in the editor, independent of Git-on-PATH inference:

```json
"workspaceMount": "source=${localWorkspaceFolder},target=/workspace,type=bind"
```

File: `.devcontainer/devcontainer.json` (with existing `workspaceFolder`: `/workspace`).

**User actions after pulling this change:**

1. **Dev Containers: Rebuild Container** (so the new `workspaceMount` is picked up).
2. Ensure the workspace opened in Cursor/VS Code is the **repository root** (the directory that contains `.devcontainer/` and `README.md`).

### Workflow notes (documentation)

- Prefer opening the clone from the **WSL Linux filesystem** on WSL2 (`/home/...`) when using Docker Desktop, not a slow or problematic cross-OS bind.
- **`git` on the host PATH** remains good practice for correct Git integration and clone features; the explicit `workspaceMount` removes dependence on mount inference for the source tree.
- If **`projects/private`** looks empty, run `git submodule update --init --recursive` (see README “Private projects”).

---

## ROOT CAUSE FOUND

**Primary (configuration / product behavior):** Dev Containers can mount **only `.devcontainer/`** when the **host does not have `git` on `PATH`** at the time the container is created, which makes the workspace look empty or wrong relative to the full repo. The repo’s previous `devcontainer.json` relied on default mount behavior and did not set `workspaceMount`.

**Secondary (user environment):** Attaching to a container without the normal folder-based session, or opening a non-root folder, can also show an unexpected tree — not ruled out without user logs.

**Evidence:** Official VS Code documentation on default source mounts + alignment with symptom (“files gone” while devcontainer metadata still appears).

---

## Verification checklist

After rebuild:

- [ ] `ls /workspace` in the integrated terminal shows `README.md`, `projects/`, `Makefile`, etc.
- [ ] `readlink -f /workspace` or `pwd` from repo root matches expectation.
