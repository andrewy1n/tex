.PHONY: pdf clean format diff

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

format:
	@if [ -z "$(SRC)" ]; then \
		echo "Usage: make format [SRC=file.tex] [PROJECT=sample]"; \
		echo ""; \
		echo "Example: make format SRC=projects/sample/main.tex"; \
		exit 1; \
	fi
	@if [ ! -f "$(SRC)" ]; then \
		echo "Error: File not found: $(SRC)"; \
		exit 1; \
	fi
	latexindent -w $(SRC)
	@echo "Formatted: $(SRC)"

diff:
	@if [ -z "$(SRC)" ] || [ -z "$(CMP)" ]; then \
		echo "Usage: make diff SRC=<file1> CMP=<file2> [PROJECT=sample]"; \
		echo ""; \
		echo "Example: make diff SRC=projects/sample/draft-v1.tex CMP=projects/sample/main.tex"; \
		exit 1; \
	fi
	@if [ ! -f "$(SRC)" ]; then \
		echo "Error: Source file not found: $(SRC)"; \
		exit 1; \
	fi
	@if [ ! -f "$(CMP)" ]; then \
		echo "Error: Compare file not found: $(CMP)"; \
		exit 1; \
	fi
	@mkdir -p $(OUTDIR)
	latexdiff --flatten $(SRC) $(CMP) > $(OUTDIR)/diff-$(shell date +%s).tex
	latexmk -pdf -interaction=nonstopmode -file-line-error -outdir=$(OUTDIR) $(OUTDIR)/diff-$(shell date +%s).tex
	@echo "Diff PDF generated: $(OUTDIR)/diff-*.pdf"
