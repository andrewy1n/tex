.PHONY: pdf clean

pdf:
	latexmk -pdf -interaction=nonstopmode -file-line-error projects/sample/main.tex

clean:
	latexmk -C projects/sample/main.tex
