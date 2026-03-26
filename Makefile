.PHONY: pdf clean

# VS Code/Cursor: see .vscode/ for LaTeX Workshop workspace settings.

pdf:
	latexmk -pdf -interaction=nonstopmode -file-line-error -outdir=projects/sample/build projects/sample/main.tex

clean:
	latexmk -C -outdir=projects/sample/build projects/sample/main.tex
