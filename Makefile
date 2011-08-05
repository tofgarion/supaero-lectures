TEXHASH = texhash
PDFLATEX = pdflatex
BIBTEX = bibtex
LOCAL_TEXMF = texmf

install:	init
	@echo "call texhash."
	@echo "*** WARNING ***"
	@echo "It is normal not to have write permission to some directories"
	$(TEXHASH)

init: 	$(HOME)/$(LOCAL_TEXMF)/tex/latex/supaero-lectures
	@echo "copying files"
	cp *.sty $(HOME)/$(LOCAL_TEXMF)/tex/latex/supaero-lectures
	cp *.cls $(HOME)/$(LOCAL_TEXMF)/tex/latex/supaero-lectures

$(HOME)/$(LOCAL_TEXMF)/tex/latex/supaero-lectures:	
	@echo "creating ~/$(LOCAL_TEXMF)/tex/latex/supaero-lectures"
	mkdir -p $(HOME)/$(LOCAL_TEXMF)/tex/latex/supaero-lectures
