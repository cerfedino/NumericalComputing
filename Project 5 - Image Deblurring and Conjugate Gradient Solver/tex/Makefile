filename=template

pdf:
	pdflatex ${filename}
	#bibtex ${filename}
	pdflatex ${filename}
	pdflatex ${filename}
	make clean

read:
	evince ${filename}.pdf &


clean:
	rm -f *.out *.log *.bbl *.blg *.aux ${filename}.log  ${filename}.ps ${filename}.aux ${filename}.out ${filename}.dvi ${filename}.bbl ${filename}.blg
