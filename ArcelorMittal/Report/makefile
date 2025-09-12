# Main LaTeX file (without .tex)
MAIN = main
OUTDIR = build
MAKE = make
MAKECLEAN = make clean

LATEX = pdflatex -interaction=nonstopmode -halt-on-error -output-directory=$(OUTDIR)
BIB   = biber --output-directory $(OUTDIR)

# Default target
all: $(MAIN).pdf

# Rule to build PDF
$(MAIN).pdf: $(MAIN).tex $(wildcard *.tex) $(wildcard *.bib)
	$(MAKE) -C pgfplots
	$(MAKE) -C tikz
	mkdir -p $(OUTDIR)
	$(LATEX) $(MAIN).tex
	-$(BIB) $(MAIN)
	$(LATEX) $(MAIN).tex
	$(LATEX) $(MAIN).tex
	mv $(OUTDIR)/$(MAIN).pdf  $(MAIN).pdf

# Clean build artifacts
clean:
	$(MAKECLEAN) -C pgfplots
	$(MAKECLEAN) -C tikz
	rm -rf $(OUTDIR)

clean-all: clean
	find . -name '*.pdf' -delete

