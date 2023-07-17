# DOC defines the version of the document being generated.
# It should be one of: markup, local, submission, final, finaldraft, tr, trdraft
# See paperversions.tex for the explanation of how the versions differ.
#
# Use 'make DOC' for appropriate values of DOC to build the corresponding document

DOC = draft
# Set DOC to one of draft, local, submission, final, report

# Name of the top-level TeX file sans .tex extension
CONF = paper

TARGETS = $(DOC).pdf

TEXS = $(DOC).tex abstract.tex header.tex body.tex

# included figures
FIGS =

# change to wherever you put paperversions.tex and the .sty files.
TEXDIR = tex-macros

# change to wherever APL make directories are located
MAKEDIR = make

include $(MAKEDIR)/commondefs

.PHONY: check-and-reinit-submodules

default: $(TARGETS) check-and-reinit-submodules

check-and-reinit-submodules:
	@if git submodule status | egrep -q '^[-]|^[+]' ; then \
	        echo "INFO: Need to reinitialize git submodules"; \
	        git submodule update --init; \
	fi

BIBDIR = bibtex
BIBFILE = $(BIBDIR)/pm-master.bib

$(DOC).pdf: $(TEXS) $(FIGS) $(DOC).bbl $(BIBFILE)
$(DOC).bbl: $(BIBFILE)

$(DOC).tex: $(CONF).tex
	sed s/DOC/$(DOC)/ < $(CONF).tex > $(DOC).tex

   
LDIRT = local.tex draft.tex submission.tex final.tex finaldraft.tex tr.tex trdraft.tex web.tex

include $(COMMONRULES)
