examples:
	@echo "-- Typesetting examples"
	@echo
	@latexmk -shell-escape -lualatex html-browsers.tex
	@latexmk -shell-escape -lualatex html-gdp.tex
	# @latexmk -shell-escape -lualatex html-pandoc.tex
	@latexmk -shell-escape -lualatex markdown-panda.tex
	@latexmk -shell-escape -lualatex man-pandoc.tex
	@latexmk -shell-escape -lualatex man-leapp.tex
	@latexmk -shell-escape -lualatex man-wolf.tex
	@echo

clean:
	@echo "-- Cleaning temporary files"
	@echo
	@rm -frv _pandoc_*
	@rm -frv _minted-*
	@rm -fv *.aux
	@rm -fv *.bbl
	@rm -fv *.bcf
	@rm -fv *.blg
	@rm -fv *.fdb_latexmk
	@rm -fv *.fls
	@rm -fv *.log
	@rm -fv *.pandoc.tex
	@rm -fv *.run.xml
	@echo

clean-all: clean
	@echo "-- Cleaning output files"
	@echo
	@rm -fv *.pdf
	@echo
