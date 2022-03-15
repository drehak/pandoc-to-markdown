examples:
	@echo "-- Typesetting examples"
	@echo
	@latexmk -shell-escape -lualatex example-markdown-panda.tex
	@latexmk -shell-escape -lualatex example-man-pandoc.tex
	@latexmk -shell-escape -lualatex example-man-leapp.tex
	@echo

clean:
	@echo "-- Cleaning temporary files"
	@echo
	@rm -fv *.aux
	@rm -fv *.fdb_latexmk
	@rm -fv *.fls
	@rm -fv *.log
	@rm -fv *.pandoc.tex
	@echo

clean-all: clean
	@echo "-- Cleaning output files"
	@echo
	@rm -fv *.pdf
	@echo