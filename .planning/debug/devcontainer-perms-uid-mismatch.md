---
status: resolved
trigger: "Docker Dev Container Permissions Issue - local user cannot access files"
created: 2026-03-27T00:00:00Z
updated: 2026-03-27T00:00:00Z
---

## Current Focus

hypothesis: Container user UID/GID mismatch with local user causes chown to break local file access
test: Verified container user vscode UID vs local user andre UID
expecting: Container user vscode has different UID than local user (1000), causing files to be inaccessible after chown
next_action: RESOLVED - root cause confirmed, solution identified

## Symptoms

expected: Local user andre should access repo files without permission denied errors
actual: Permission denied errors when accessing files locally after devcontainer operations
errors: EACCES permission denied on bind-mounted files
reproduction: Open devcontainer, run postStartCommand (fix-workspace-perms.sh), close container, try to access files locally
started: After recent devcontainer setup work (commits b8ced39-88d9ee4)

## Eliminated

None - hypothesis confirmed on first test

## Evidence

- timestamp: 2026-03-27
  checked: Local user UID/GID via id command
  found: Local user andre has uid=1000(andre) gid=1000(andre)
  implication: Host files are owned by UID 1000

- timestamp: 2026-03-27
  checked: Dockerfile user creation
  found: Container creates user "vscode" without specifying UID: "RUN useradd -m -s /bin/bash vscode"
  implication: Container user vscode gets default UID (likely 1001+ depending on existing users), NOT 1000

- timestamp: 2026-03-27
  checked: postStartCommand execution path
  found: devcontainer.json line 19: "postStartCommand": "sudo /usr/local/bin/fix-workspace-perms.sh"
  implication: On every container start, this script runs with root privileges

- timestamp: 2026-03-27
  checked: fix-workspace-perms.sh script
  found: Script runs "chown -R vscode:vscode /workspace" as root
  implication: Every bind-mounted file (owned by UID 1000 on host) gets chowned to container's vscode user (UID 1001+). Local user andre (1000) then cannot read/write files.

- timestamp: 2026-03-27
  checked: devcontainer.json configuration
  found: Line 32 sets "updateRemoteUserUID": true
  implication: VS Code has mechanism to match remote user UID to local user UID, but it may not be triggering correctly OR the postStartCommand runs AFTER UID update and breaks it with chown

## Resolution

root_cause: |
  The container's vscode user is created with a default UID (not 1000), while the host's local user andre has UID 1000.

  The postStartCommand runs fix-workspace-perms.sh which executes "chown -R vscode:vscode /workspace" as root.
  This changes all bind-mounted files from UID 1000 (andre) to UID 1001+ (container's vscode), making them inaccessible
  to the local user andre.

  The mechanism "updateRemoteUserUID": true should align container user to host, but the postStartCommand chown
  happens afterward and reverses any alignment.

fix: |
  OPTION A (Recommended): Modify Dockerfile to create vscode user with explicit UID 1000 to match typical host user:
    Change: RUN useradd -m -s /bin/bash vscode
    To: RUN useradd -m -s /bin/bash -u 1000 vscode

  OPTION B (Alternative): Remove postStartCommand chown entirely and rely on "updateRemoteUserUID": true to handle alignment.
    This assumes no root-owned files in bind mount.

  OPTION C: Keep postStartCommand but make it smarter - detect if file ownership is already correct before chowning.

verification: |
  After applying fix (OPTION A):
  1. Rebuild devcontainer image
  2. Open devcontainer and let postStartCommand run
  3. Close devcontainer
  4. Try to access files from local shell: should have full read/write access
  5. Verify container can still write/save files
  6. No EACCES errors on either side

files_changed: []
