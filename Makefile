.PHONY: pdf clean

# VS Code/Cursor: see .vscode/ for LaTeX Workshop workspace settings.

pdf:
	latexmk -pdf -interaction=nonstopmode -file-line-error projects/sample/main.tex

clean:
	latexmk -C projects/sample/main.tex
