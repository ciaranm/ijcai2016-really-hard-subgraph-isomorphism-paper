# vim: set et ft=gnuplot sw=4 :

set terminal tikz color size 3in,4in font '\scriptsize'
set output "gen-graph-phase-transition-bands.tex"

load "paired.pal"

unset xlabel
unset ylabel
set xrange [0:1]
set yrange [0:1]
set size square
set xlabel "Pattern density"
set ylabel "Target density"
set border 3
set grid
set xtics nomirror
set ytics nomirror

unset key

set label 1 at graph 1, graph 0.45 left '$G(10, x)$'
set label 2 at graph 1, graph 0.78 left '$G(20, x)$'
set label 3 at graph 1, graph 0.88 left '$G(30, x)$'
set label 4 at graph 1, graph 0.93 left '$G(50, x)$'
set label 5 at graph 0.6, graph 1 center offset character 0, character 0.5 '$G(150, x)$'

plot \
        "ps10-ts150.non-induced.phase-transition-points.plot" u 1:2 w p lc rgb '#a6cee3' pt 11, \
        "ps20-ts150.non-induced.phase-transition-points.plot" u 1:2 w p lc rgb '#1f78b4' pt 7, \
        "ps30-ts150.non-induced.phase-transition-points.plot" u 1:2 w p lc rgb '#b2df8a' pt 9, \
        "ps50-ts150.non-induced.phase-transition-points.plot" u 1:2 w p lc rgb '#33A02C' pt 13, \
        "ps150-ts150.non-induced.phase-transition-points.plot" u 1:2 w p lc rgb '#fb9a99' pt 15

