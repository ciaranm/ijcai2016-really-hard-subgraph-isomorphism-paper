# vim: set et ft=gnuplot sw=4 :

set terminal tikz color size 3.4in,2.6in font '\tiny'
set output "gen-graph-phase-transition.tex"

load "puor.pal"

set xrange [0:1]
set xlabel "Pattern density"
set ylabel "Search nodes"
set y2label "Proportion SAT" rotate by -90
set logscale y
set format y '$10^{%T}$'
set key above maxrows 3
set border 11
set grid
set xtics nomirror
set ytics nomirror
set y2tics 0.5 nomirror

plot \
    "<sed -e '1~25!d' data/ps20-ts150.non-induced.slice.plot" u ($4==0?$1:NaN):($5) w p notitle lc '#e08214' pt 2 ps 0.7, \
    "<sed -e '1~25!d' data/ps20-ts150.non-induced.slice.plot" u ($4==1?$1:NaN):($5) w p notitle lc '#542788' pt 1 ps 0.7, \
    "data/ps20-ts150.non-induced.slice-averages.plot" u 1:3 w l ti 'Mean search' lc '#1d91c0' lw 3, \
    "" u (NaN):(NaN) w p pt 1 lc '#542788' ti "Satisfiable", \
    "" u (NaN):(NaN) w p pt 2 lc '#e08214' ti "Unsatisfiable", \
    "data/ps20-ts150.non-induced.slice-averages.plot" u 1:4 w l axes x1y2 ti 'Proportion SAT' lc '#0c2c84' lw 3, \
    "" u (NaN):(NaN) w l lw 0 lc '#ffffff' ti "~", \
    "" u (NaN):(NaN) w l lw 0 lc '#ffffff' ti "~"

