---
status: diagnosed
slug: devcontainer-eacces-latexindent
created: 2026-03-27
updated: 2026-03-27
---

# Debug: EACCES saving `projects/private/CV/main.tex` + latexindent missing in dev container

## ROOT CAUSE FOUND

### 1. Permission denied (EACCES)

Bind mount `${localWorkspaceFolder}` → `/workspace` with `remoteUser: vscode`. Files under `projects/private/` were **owned by root** on the host (`root:root`, mode `644`). User `vscode` in the container is not root → cannot open for write.

`updateRemoteUserUID` does not help when the file owner is **uid 0** (only root can write).

### 2. latexindent not in PATH

Image used `tlmgr install latexindent`, which is unreliable on Ubuntu-packaged TeX Live and did not guarantee `/usr/bin/latexindent` for the `vscode` user.

## Fixes

- **Repo:** `.devcontainer/Dockerfile` — install `texlive-extra-utils` (provides `latexindent`); remove `tlmgr` block; verify with `latexindent --version`.
- **Repo (EACCES):** `postStartCommand` runs `sudo /usr/local/bin/fix-workspace-perms.sh`, which `chown -R vscode:vscode /workspace` on the bind mount. Sudo is limited to that script only (`/etc/sudoers.d/vscode-workspace`). With `updateRemoteUserUID: true`, ownership on disk matches your host user after each container start.
- **Host (optional fallback):** If you prefer not to run the script, you can still one-time `sudo chown -R "$(id -un):$(id -gn)" …` on WSL.

## Verification

- After chown: save `projects/private/CV/main.tex` in the dev container succeeds.
- In container: `which latexindent` and `latexindent --version` succeed.
