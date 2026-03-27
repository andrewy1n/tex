# Quick task 260327-kit: Commit the fixes

## Outcome

Committed devcontainer fixes and related artifacts on `master` as `4e5e09e`.

## Changes

- **Dockerfile:** `sudo`, `texlive-extra-utils` for `latexindent`; removed `tlmgr` install; copy `fix-workspace-perms.sh` with NOPASSWD `sudoers`; verify `latexindent --version` in image build.
- **devcontainer.json:** `postStartCommand` runs scoped chown so bind-mounted workspace files match `vscode`.
- **fix-workspace-perms.sh:** `chown -R vscode:vscode /workspace`.
- **Submodule:** `projects/private` pointer updated to match recorded submodule commit.
- **Debug:** `.planning/debug/devcontainer-eacces-latexindent.md` documents EACCES + PATH root cause.

## Not committed

- `.claude/` (untracked local IDE metadata — left out of this commit).

## Submodule note

If `git status` still shows `projects/private (modified content)`, that is uncommitted work **inside** the submodule checkout; resolve in that repo separately.
