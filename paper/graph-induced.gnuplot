# vim: set et ft=gnuplot sw=4 :

set terminal tikz color size 7in,6in font ',8'
set output "gen-graph-induced.tex"

unset xlabel
unset ylabel
set xrange [0:1]
set noxtics
set yrange [0:1]
set noytics
set size square
set cbtics out scale 0.5 nomirror offset -1

set multiplot layout 3,4 spacing 0.005, 0.08

set palette negative
load "puor.pal"
unset colorbox

set title "\\textbf{SAT} ($10 \\rightarrowtail 150$)"
set cbtics 0.5
plot "ps10-ts150.induced.proportion-sat.plot" u ($2/25):($1/25):($3) matrix w image notitle

set title "\\textbf{SAT} ($15 \\rightarrowtail 150$)"
set cbtics 0.5
plot "ps15-ts150.induced.proportion-sat.plot" u ($2/25):($1/25):($3) matrix w image notitle

set title "\\textbf{SAT} ($20 \\rightarrowtail 150$)"
set cbtics 0.5
plot "ps20-ts150.induced.proportion-sat.plot" u ($2/25):($1/25):($3) matrix w image notitle

set colorbox

set title "\\textbf{SAT} ($25 \\rightarrowtail 150$)"
set cbtics 0.5
plot "ps25-ts150.induced.proportion-sat.plot" u ($2/25):($1/25):($3) matrix w image notitle

set palette positive
load "ylgnbu.pal"
unset colorbox

set title "\\textbf{Glasgow} ($10 \\rightarrowtail 150$)"
set cbrange [2:6]
set cbtics 2 add ('${\le}10^{2}$' 2) add ('${\ge}10^{6}$' 6)
set format cb '$10^{%.0f}$'
plot "ps10-ts150.induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set title "\\textbf{Glasgow} ($15 \\rightarrowtail 150$)"
set format cb '$10^{%.0f}$'
plot "ps15-ts150.induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set title "\\textbf{Glasgow} ($20 \\rightarrowtail 150$)"
set format cb '$10^{%.0f}$'
plot "ps20-ts150.induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set colorbox

set title "\\textbf{Glasgow} ($25 \\rightarrowtail 150$)"
set format cb '$10^{%.0f}$'
plot "ps25-ts150.induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

unset colorbox

set title "\\textbf{VF2} ($10 \\rightarrowtail 150$)"
set format cb '$10^{%.0f}$'
plot "ps10-ts150.vf2-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set title "\\textbf{VF2} ($15 \\rightarrowtail 150$)"
set format cb '$10^{%.0f}$'
plot "ps15-ts150.vf2-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set title "\\textbf{VF2} ($20 \\rightarrowtail 150$)"
set format cb '$10^{%.0f}$'
plot "ps20-ts150.vf2-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set colorbox

set title "\\textbf{VF2} ($25 \\rightarrowtail 150$)"
set format cb '$10^{%.0f}$'
plot "ps25-ts150.vf2-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

