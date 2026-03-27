---
quick_id: 260327-kzk
date: 2026-03-27
type: execute
tasks: 1
estimated_time: 15min
files_modified:
  - .devcontainer/Dockerfile
---

<objective>
Use Ubuntu's built-in `ubuntu` user (UID 1000) instead of creating a custom `vscode` user in the Dockerfile.

**Purpose:** Simplify container image, reduce unnecessary user creation, leverage Ubuntu's default user which has UID 1000 by default.

**Output:** Updated Dockerfile that uses `ubuntu` user with proper workspace permissions and sudoers configuration.
</objective>

<context>
Current Dockerfile (`.devcontainer/Dockerfile`) creates a custom `vscode` user with UID 1000. Ubuntu 24.04 ships with a built-in `ubuntu` user that also has UID 1000. Switching eliminates unnecessary user creation and simplifies the image.
</context>

<tasks>

<task type="auto">
  <name>Task 1: Replace custom vscode user with default ubuntu user</name>
  <files>.devcontainer/Dockerfile</files>
  <action>
    Replace the `useradd` block (lines 44-46) with configuration for the default `ubuntu` user that already exists in Ubuntu 24.04.

    Specific changes:
    1. Remove: `RUN useradd -m -s /bin/bash -u 1000 vscode && \`
    2. Change `chown vscode:vscode /workspace` to `chown ubuntu:ubuntu /workspace`
    3. Update sudoers file reference from `vscode` to `ubuntu` in lines 51-53:
       - Change `echo 'vscode ALL=(root)...` to `echo 'ubuntu ALL=(root)...`
    4. Update `USER vscode` (line 59) to `USER ubuntu`
    5. Leave all other lines unchanged (TeX Live, Node.js, workspace setup, fix-workspace-perms.sh)

    The ubuntu user with UID 1000 already exists in the base image, so no useradd is needed.
  </action>
  <verify>
    <automated>
      # Verify Dockerfile syntax and key changes
      grep -n "ubuntu" .devcontainer/Dockerfile | head -5
      # Check that vscode user references are gone
      grep -c "vscode" .devcontainer/Dockerfile || echo "0"
    </automated>
  </verify>
  <done>
    - Dockerfile uses `ubuntu` user instead of custom `vscode` user
    - Workspace directory owned by ubuntu:ubuntu
    - Sudoers config references ubuntu user
    - USER directive set to ubuntu
    - All TeX Live, Node.js, and tool installation steps remain unchanged
  </done>
</task>

</tasks>

<verification>
After modification, the container will:
1. Use Ubuntu's native `ubuntu` user with UID 1000
2. Maintain all workspace permissions and sudo capabilities
3. Keep all development tools (TeX Live, latexmk, chktex, latexdiff, Node.js) available
4. Build and run without user creation overhead
</verification>

<success_criteria>
- Dockerfile contains no `vscode` user references
- All instances of `vscode` replaced with `ubuntu`
- No `useradd` command (Ubuntu user already exists)
- Workspace directory ownership correct
- Sudoers configuration allows `ubuntu` user to run fix-workspace-perms.sh
</success_criteria>
