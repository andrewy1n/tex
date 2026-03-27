---
quick_id: 260327-kzk
date: 2026-03-27
title: Use default ubuntu UID 1000 user in Dockerfile
completed_at: 2026-03-27T00:00:00Z
commit: afdb679
tasks_completed: 1
files_modified:
  - .devcontainer/Dockerfile
---

# Quick Task 260327-kzk: Use Default Ubuntu UID 1000 User

## Summary

Replaced the custom `vscode` user (UID 1000) in the Dockerfile with Ubuntu's built-in `ubuntu` user that ships with Ubuntu 24.04. This simplifies the container image by eliminating unnecessary user creation.

## Changes Made

### Task 1: Replace custom vscode user with default ubuntu user

**File modified:** `.devcontainer/Dockerfile`

**Changes:**
1. Removed `RUN useradd -m -s /bin/bash -u 1000 vscode` line (unnecessary—ubuntu user already exists in base image)
2. Changed workspace ownership from `vscode:vscode` to `ubuntu:ubuntu`
3. Updated sudoers file from `/etc/sudoers.d/vscode-workspace` to `/etc/sudoers.d/ubuntu-workspace`
4. Updated sudoers entry from `echo 'vscode ALL=(root)...'` to `echo 'ubuntu ALL=(root)...'`
5. Changed `USER vscode` to `USER ubuntu`
6. All TeX Live, Node.js, and tool installation steps remain unchanged

**Verification completed:**
- ✓ No `vscode` user references in Dockerfile (grep count: 0)
- ✓ Multiple `ubuntu` references present (5 occurrences)
- ✓ Workspace directory ownership set to ubuntu:ubuntu
- ✓ Sudoers configuration allows ubuntu user to run fix-workspace-perms.sh
- ✓ All development tools remain available (TeX Live, latexmk, chktex, latexdiff, Node.js)

## Success Criteria Met

- [x] Dockerfile contains no `vscode` user references
- [x] All instances of `vscode` replaced with `ubuntu`
- [x] No `useradd` command (Ubuntu user already exists)
- [x] Workspace directory ownership correct
- [x] Sudoers configuration allows `ubuntu` user to run fix-workspace-perms.sh

## Deviations from Plan

None - plan executed exactly as written.

## Commit

**Commit hash:** afdb679
**Message:** chore(quick-260327-kzk): use default ubuntu UID 1000 user instead of custom vscode user

**Files:**
- `.devcontainer/Dockerfile` (modified: -9, +8 lines)

## Self-Check: PASSED

- [x] Dockerfile file exists and contains expected content
- [x] All vscode references removed (0 occurrences)
- [x] All ubuntu references present (5 occurrences including FROM ubuntu:24.04)
- [x] Commit afdb679 exists in git history
- [x] Success criteria fully met
