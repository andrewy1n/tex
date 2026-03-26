.PHONY: pdf clean

# Default project: bundled sample. Override for other trees, e.g. private submodule:
#   make pdf PROJECT=private/CV
PROJECT ?= sample
MASTER := projects/$(PROJECT)/main.tex
OUTDIR := projects/$(PROJECT)/build

# VS Code/Cursor: see .vscode/ for LaTeX Workshop workspace settings.

pdf:
	latexmk -pdf -interaction=nonstopmode -file-line-error -outdir=$(OUTDIR) $(MASTER)

clean:
	latexmk -C -outdir=$(OUTDIR) $(MASTER)
