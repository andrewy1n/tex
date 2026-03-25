---
status: diagnosed
slug: latex-workshop-latexmk-enoent
created: 2026-03-25
updated: 2026-03-25
---

# Debug: LaTeX Workshop build fails (WSL)

## Symptoms

- LaTeX Workshop log: `Error: spawn latexmk ENOENT`
- `kpsewhich` cannot resolve `article.cls`
- Environment: Cursor remote **WSL** (`vscode.env.remoteName: wsl`)

## ROOT CAUSE FOUND

**No TeX toolchain on the WSL `PATH` seen by the Cursor server.**  
`latexmk` is not installed (or not discoverable). The extension runs builds with `cwd` = repo root; the recipe is correct; the binary is missing.

Secondary log noise: MiKTeX detection `TypeError` is an extension edge case when `pdflatex` is also missing.

## Fix (recommended)

In a **WSL terminal** (same distro Cursor uses), install TeX Live + `latexmk`:

```bash
sudo apt update
sudo apt install -y latexmk texlive-latex-recommended texlive-latex-extra
```

For a minimal/smaller install (may miss some packages for complex docs):

```bash
sudo apt install -y latexmk texlive-latex-base texlive-latex-recommended
```

Then verify:

```bash
which latexmk pdflatex kpsewhich
kpsewhich article.cls
```

Restart Cursor or **Developer: Reload Window** so the extension picks up the new PATH.

## Alternative

- Install TeX on **Windows** and add the Windows `latexmk` binaries to `PATH` in WSL (fragile), or  
- Open the project in **Windows** Cursor with TeX on Windows PATH instead of WSL remote.

## Verification

After install, run **LaTeX Workshop: Build LaTeX project** on `projects/sample/main.tex` — log should show `latexmk` running without `ENOENT`.
