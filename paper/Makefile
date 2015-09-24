all : tables graphs
	latexmk -pdf -pdflatex='lualatex -interaction=nonstopmode %O %S' -shell-escape paper

TABLES =

GRAPHS = gen-graph-sat.tex gen-graph-non-induced.tex gen-graph-induced.tex gen-graph-phase-transition.tex

tables : $(TABLES)

graphs : $(GRAPHS)

gen-graph-%.tex : graph-%.gnuplot
	gnuplot $<

