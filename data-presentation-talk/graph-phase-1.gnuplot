# vim: set et ft=gnuplot sw=4 :

set terminal tikz color size 4.2in,3in font '\tiny'
set output "gen-graph-phase-1.tex"

load "puor.pal"

set xrange [0:1]
set xlabel "Pattern density"
set ylabel "Proportion SAT"
set logscale y2
set format y2 '$10^{%T}$'
unset key
set border 3
set grid xtics
set xtics nomirror
set ytics nomirror

set label 1 at screen 0.15, screen 0.85 "$G(20, x) \\rightarrowtail G(150, 0.4)$"

plot \
    "ps20-ts150.non-induced.slice-averages.plot" u 1:4 w l axes x1y1 ti 'Proportion SAT' lc '#4daf4a' lw 3

