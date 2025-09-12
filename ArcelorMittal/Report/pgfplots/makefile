# TikZ diagrams Makefile
TEXS := $(wildcard *.tex)
PDFS := $(TEXS:.tex=.pdf)
OUTDIR = build

LATEX = pdflatex -interaction=nonstopmode -halt-on-error -output-directory=$(OUTDIR)

#Default targets
all: $(PDFS)

# Build .pdfs from *.texs
%.pdf: %.tex | $(OUTDIR)
	$(LATEX) $<
	mv $(OUTDIR)/$(@F) $@


# Ensure build dir exists
$(OUTDIR):
	mkdir -p $(OUTDIR)


# Clean build artifacts
clean:
	rm -rf $(OUTDIR)/ 

.PHONY: all clean

