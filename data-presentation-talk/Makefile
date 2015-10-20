all : tables graphs
	latexmk -pdf -pdflatex='pdflatex -interaction=nonstopmode %O %S' talk

TABLES =

GRAPHS = gen-graph-phase-1.tex gen-graph-phase-2.tex gen-graph-phase-3.tex \
	 gen-graph-2d-1.tex gen-graph-2d-2.tex gen-graph-2d-3.tex \
	 gen-graph-3d-1.tex gen-graph-3d-2.tex \
	 gen-graph-induced-2d-1.tex gen-graph-induced-2d-2.tex gen-graph-induced-2d-3.tex gen-graph-induced-2d-4.tex gen-graph-induced-2d-5.tex \
	 gen-graph-induced-3d-1.tex gen-graph-induced-3d-2.tex \
	 gen-graph-alt-1.tex gen-graph-alt-2.tex gen-graph-alt-3.tex \
	 gen-graph-red-1.tex gen-graph-red-2.tex gen-graph-red-3.tex gen-graph-red-4.tex gen-graph-red-5.tex \
	 gen-graph-shape-1.tex gen-graph-shape-2.tex gen-graph-shape-3.tex gen-graph-shape-4.tex gen-graph-shape-5.tex gen-graph-shape-6.tex

tables : $(TABLES)

graphs : $(GRAPHS)

gen-graph-%.tex : graph-%.gnuplot
	gnuplot $<

