.PHONY: pdf clean

pdf:
	latexmk -pdf -interaction=nonstopmode -file-line-error main.tex

clean:
	latexmk -C
