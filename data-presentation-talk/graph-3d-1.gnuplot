# vim: set et ft=gnuplot sw=4 :

set terminal tikz color size 4.6in,2.8in font '\tiny'
set output "gen-graph-3d-1.tex"

set xlabel "Pattern density"
set ylabel "Target density"
set xrange [0:1]
set yrange [0:1]
set size square
set cbtics out scale 0.5 nomirror offset -1
set noxtics
set noytics

set key rmargin center width -4 Left

plot \
        "ps10-ts150.non-induced.phase-transition-points.plot" u 1:2 w p title '$G(10, x) \rightarrowtail G(150, y)$' pt 7, \
        "ps20-ts150.non-induced.phase-transition-points.plot" u 1:2 w p title '$G(20, x) \rightarrowtail G(150, y)$' pt 7, \
        "ps30-ts150.non-induced.phase-transition-points.plot" u 1:2 w p title '$G(30, x) \rightarrowtail G(150, y)$' pt 7

