# TikZ diagrams Makefile
MAINS = ppt ppt1 ppt2 ppt3_defense 
OUTDIR = build
MAKE = make
MAKECLEAN = make clean

LATEX = pdflatex -interaction=nonstopmode -file-line-error -halt-on-error -output-directory=$(OUTDIR)

#Default targets
all: $(MAINS:=.pdf)

# Build .pdfs from *.texs
%.pdf : %.tex  
	$(MAKE) -C ParaStudy_onlydata
	mkdir -p $(OUTDIR)
	$(LATEX) $*.tex
	mv $(OUTDIR)/$*.pdf  $*.pdf

# Clean build artifacts
clean:
	$(MAKECLEAN) -C ParaStudy_onlydata
	rm -rf $(OUTDIR)

clean-all: clean
	find . -name '*.pdf' -delete


.PHONY: all clean

