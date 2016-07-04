all : tables graphs
	latexmk -pdf -pdflatex='pdflatex -interaction=nonstopmode %O %S' talk

TABLES =

GRAPHS = gen-graph-phase.tex gen-graph-phase-2.tex gen-graph-non-induced-2d.tex \
	 gen-graph-induced-2d.tex gen-graph-induced-2d-2.tex gen-graph-induced-2d-middle.tex \
	 gen-graph-induced-2d-alt.tex gen-graph-induced-2d-kappa.tex

tables : $(TABLES)

graphs : $(GRAPHS)

gen-graph-%.tex : graph-%.gnuplot
	gnuplot $<


