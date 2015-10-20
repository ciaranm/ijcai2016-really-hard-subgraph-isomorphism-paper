# vim: set et ft=gnuplot sw=4 :

set terminal tikz color size 4.6in,2.8in font '\tiny'
set output "gen-graph-shape-5.tex"

set xlabel "Pattern density"
set ylabel "Target density"
set xrange [0:1]
set yrange [0:1]
set size square
set cbtics out scale 0.5 nomirror offset -1
set noxtics
set noytics

set multiplot layout 1,2

load "puor.pal"

set title "Proportion SAT"
set cbtics 0.5
plot "ps20-ts150.induced.proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

set label 1 at screen 0.5, screen 0.87 center "$G(20, x) \\hookrightarrow G(150, y)$"

set title "Bound"
plot "ps20-ts150.induced.predicted-proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

