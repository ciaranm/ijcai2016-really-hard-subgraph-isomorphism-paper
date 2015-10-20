# vim: set et ft=gnuplot sw=4 :

set terminal tikz color size 4.6in,2.8in font '\tiny'
set output "gen-graph-2d-1.tex"

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
plot "ps10-ts150.non-induced.proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

load "ylgnbu.pal"
set format cb '$10^{%.0f}$'
set cbrange [2:8]

set label 1 at screen 0.5, screen 0.87 center "$G(10, x) \\rightarrowtail G(150, y)$"

set title "Mean Search Nodes"
set cbtics 2 add ('${\le}10^{2}$' 2) add ('${\ge}10^{8}$' 8)
plot "ps10-ts150.non-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

