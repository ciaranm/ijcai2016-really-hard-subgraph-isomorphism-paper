# vim: set et ft=gnuplot sw=4 :

set terminal tikz color size 7.8in,7.6in font '\scriptsize'
set output "gen-graph-sat.tex"

unset xlabel
unset ylabel
set xrange [0:1]
set noxtics
set yrange [0:1]
set noytics
set size square
set cbtics out scale 0.5 nomirror offset -1

set multiplot layout 6,6 spacing 0.02, 0.02

load "puor.pal"
unset colorbox

set label 1 at screen 0.08, screen 0.80 'Satisfiable' rotate by 90
set label 2 at screen 0.08, screen 0.68 'Glasgow' rotate by 90
set label 3 at screen 0.08, screen 0.50 'Glucose (SAT)' rotate by 90
set label 4 at screen 0.08, screen 0.35 'BBMC (Clique)' rotate by 90
set label 5 at screen 0.08, screen 0.20 'Gurobi (MIP)' rotate by 90
set label 6 at screen 0.08, screen 0.10 'Clasp (PB)' rotate by 90

set title "$G(10,x) \\hookrightarrow G(75,y)$"
set cbtics 0.5
plot "ps10-ts75.induced.proportion-sat.plot" u ($2/25):($1/25):($3) matrix w image notitle

unset label 1
unset label 2
unset label 3
unset label 4
unset label 5
unset label 6

set title "$G(12,x) \\hookrightarrow G(75,y)$"
set cbtics 0.5
plot "ps12-ts75.induced.proportion-sat.plot" u ($2/25):($1/25):($3) matrix w image notitle

set title "$G(14,x) \\hookrightarrow G(75,y)$"
set cbtics 0.5
plot "ps14-ts75.induced.proportion-sat.plot" u ($2/25):($1/25):($3) matrix w image notitle

set title "$G(16,x) \\hookrightarrow G(75,y)$"
set cbtics 0.5
plot "ps16-ts75.induced.proportion-sat.plot" u ($2/25):($1/25):($3) matrix w image notitle

set title "$G(18,x) \\hookrightarrow G(75,y)$"
set cbtics 0.5
plot "ps18-ts75.induced.proportion-sat.plot" u ($2/25):($1/25):($3) matrix w image notitle

set colorbox

set title "$G(25, x) \\hookrightarrow G(75,y)$"
set cbtics 0.5
plot "ps25-ts75.induced.proportion-sat.plot" u ($2/25):($1/25):($3) matrix w image notitle

load "ylgnbu.pal"
set format cb '$10^{%.0f}$'
unset colorbox
set cbrange [2:6]

set notitle
set cbtics 1 add ('${\le}10^{2}$' 2) add ('${\ge}10^{6}$' 6)
plot "ps10-ts75.induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
set cbtics 1 add ('${\le}10^{2}$' 2) add ('${\ge}10^{6}$' 6)
plot "ps12-ts75.induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
set cbtics 1 add ('${\le}10^{2}$' 2) add ('${\ge}10^{6}$' 6)
plot "ps14-ts75.induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
set cbtics 1 add ('${\le}10^{2}$' 2) add ('${\ge}10^{6}$' 6)
plot "ps16-ts75.induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
set cbtics 1 add ('${\le}10^{2}$' 2) add ('${\ge}10^{6}$' 6)
plot "ps18-ts75.induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set colorbox

set notitle
plot "ps25-ts75.induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

unset colorbox
set cbrange [3:7]

set notitle
plot "ps10-ts75.glucose-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
plot "ps12-ts75.glucose-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
plot "ps14-ts75.glucose-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
plot "ps16-ts75.glucose-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
plot "ps18-ts75.glucose-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set colorbox

set cbtics 1 add ('${\le}10^{3}$' 3) add ('${\ge}10^{8}$' 8)
plot "ps25-ts75.glucose-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

unset colorbox
set cbrange [3:9]

set notitle
plot "ps10-ts75.clique-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
plot "ps12-ts75.clique-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
plot "ps14-ts75.clique-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
plot "ps16-ts75.clique-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
plot "ps18-ts75.clique-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set colorbox

set cbtics 1 add ('${\le}10^{3}$' 3) add ('${\ge}10^{9}$' 9)
plot "ps25-ts75.clique-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

unset colorbox
set cbrange [0:5]

set notitle
plot "ps10-ts75.gurobi-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
plot "ps12-ts75.gurobi-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
plot "ps14-ts75.gurobi-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
plot "ps16-ts75.gurobi-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
plot "ps18-ts75.gurobi-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
set colorbox
set cbtics 1 add ('${\le}10^{0}$' 0) add ('${\ge}10^{5}$' 5)
plot "ps25-ts75.gurobi-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

unset colorbox
set cbrange [2:7]

set notitle
plot "ps10-ts75.clasp-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
plot "ps12-ts75.clasp-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
plot "ps14-ts75.clasp-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
plot "ps16-ts75.clasp-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
plot "ps18-ts75.clasp-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

