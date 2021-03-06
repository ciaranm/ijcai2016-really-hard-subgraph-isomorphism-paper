# vim: set et ft=gnuplot sw=4 :

set terminal tikz color size 4.2in,3in font '\tiny'
set output "gen-graph-phase-2.tex"

load "puor.pal"

set xrange [0:1]
set xlabel "Pattern density"
set ylabel "Proportion SAT"
set y2label "Mean search nodes"
set logscale y2
set format y2 '$10^{%T}$'
unset key
set border 11
set grid xtics y2tics
set xtics nomirror
set ytics nomirror
set y2tics nomirror
set y2range [1:1e9]

set label 1 at screen 0.15, screen 0.85 "$G(20, x) \\rightarrowtail G(150, 0.4)$"

plot \
    "ps20-ts150.non-induced.slice-averages.plot" u 1:4 w l axes x1y1 ti 'Proportion SAT' lc '#4daf4a' lw 3, \
    "ps20-ts150.non-induced.slice-averages.plot" u 1:3 w l axes x1y2 ti 'Mean search' lc '#377eb8' lw 3

