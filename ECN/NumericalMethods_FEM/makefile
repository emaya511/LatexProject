# Main LaTeX file (without .tex)
MAINS = main 
OUTDIR = build
MAKE = make
MAKECLEAN = make clean

LATEX = pdflatex -interaction=nonstopmode -halt-on-error -file-line-error -output-directory=$(OUTDIR)
BIB   = biber --output-directory $(OUTDIR)

# Default target
all: $(MAINS:=.pdf)

# Rule to build PDF
%.pdf : %.tex $(wildcard *.tex) $(wildcard *.bib)
	mkdir -p $(OUTDIR)
	$(LATEX) $*.tex
	-$(BIB) $*
	$(LATEX) $*.tex
	$(LATEX) $*.tex
	mv $(OUTDIR)/$*.pdf  $*.pdf

# Clean build artifacts
clean:
	rm -rf $(OUTDIR)

clean-all: clean
	find . -name '*.pdf' -delete

