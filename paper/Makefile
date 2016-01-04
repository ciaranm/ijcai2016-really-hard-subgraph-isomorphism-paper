all : tables graphs
	latexmk -pdf -pdflatex='pdflatex -interaction=nonstopmode %O %S' -shell-escape paper

TABLES =

GRAPHS = gen-graph-sat.tex gen-graph-non-induced.tex gen-graph-induced.tex gen-graph-phase-transition.tex \
	 gen-graph-phase-transition-bands.tex gen-graph-which.tex

tables : $(TABLES)

graphs : $(GRAPHS)

gen-graph-%.tex : graph-%.gnuplot
	gnuplot $<
	sed -i -e '5s/^\(\\path.*\)/\% \1/' $@ # epic haxx

