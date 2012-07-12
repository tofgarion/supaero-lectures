TEXHASH = texhash
PDFLATEX = pdflatex
BIBTEX = bibtex
LOCAL_TEXMF := $(shell kpsewhich -var-value=TEXMFHOME)

install:	init
	@echo "call texhash."
	@echo "*** WARNING ***"
	@echo "It is normal not to have write permission to some directories"
	$(TEXHASH)

init: 	$(LOCAL_TEXMF)/tex/latex/supaero-lectures $(LOCAL_TEXMF)/doc/latex/supaero-lectures
	@echo "copying files"
	cp *.sty $(LOCAL_TEXMF)/tex/latex/supaero-lectures
	cp *.cls $(LOCAL_TEXMF)/tex/latex/supaero-lectures
	cp *.png $(LOCAL_TEXMF)/tex/latex/supaero-lectures
	cp *.bbx $(LOCAL_TEXMF)/tex/latex/supaero-lectures
	cp *.cbx $(LOCAL_TEXMF)/tex/latex/supaero-lectures
	cp exempleSlides.tex beamer-bib.bib $(LOCAL_TEXMF)/doc/latex/supaero-lectures

$(LOCAL_TEXMF)/tex/latex/supaero-lectures:	
	@echo "creating $(LOCAL_TEXMF)/tex/latex/supaero-lectures"
	mkdir -p $(LOCAL_TEXMF)/tex/latex/supaero-lectures

$(LOCAL_TEXMF)/doc/latex/supaero-lectures:	
	@echo "creating $(LOCAL_TEXMF)/doc/latex/supaero-lectures"
	mkdir -p $(LOCAL_TEXMF)/doc/latex/supaero-lectures

examples:	install exempleSlides.pdf

%.pdf:	%.tex
	@echo "compiling examples..."
	cd $(LOCAL_TEXMF)/doc/latex/supaero-lectures/ ; \
	$(PDFLATEX) $< ; \
	$(BIBTEX) $(basename $<) ; \
	$(PDFLATEX) $< ; \
	$(PDFLATEX) $<

clean:
	@echo "cleaning all the files"
	rm -Rf $(LOCAL_TEXMF)/doc/latex/supaero-lectures/*.pdf
