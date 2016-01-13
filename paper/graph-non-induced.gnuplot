# vim: set et ft=gnuplot sw=4 :

set terminal tikz color size 3.4in,4.6in font '\tiny'
set output "gen-graph-non-induced.tex"

unset xlabel
unset ylabel
set xrange [0:1]
set noxtics
set yrange [0:1]
set noytics
set size square
set cbtics out scale 0.5 nomirror offset -1

set multiplot layout 4,3 spacing 0.03, 0.02

load "puor.pal"
unset colorbox

set label 1 at screen 0.05, graph 0.5 center 'Satisfiable?' rotate by 90

set title "$G(10,x){\\rightarrowtail}G(150,y)$"
set cbtics 0.5
plot "data/ps10-ts150.non-induced.proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle, \
    "data/ps10-ts150.non-induced.predicted-line.plot" u 1:2 w line notitle lc "black"

unset label 1

set title "$G(20,x){\\rightarrowtail}G(150,y)$"
set cbtics 0.5
plot "data/ps20-ts150.non-induced.proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle, \
    "data/ps20-ts150.non-induced.predicted-line.plot" u 1:2 w line notitle lc "black"

set colorbox

set title "$G(30,x){\\rightarrowtail}G(150,y)$"
plot "data/ps30-ts150.non-induced.proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle, \
    "data/ps30-ts150.non-induced.predicted-line.plot" u 1:2 w line notitle lc "black"

load "ylgnbu.pal"
set palette positive
set format cb '$10^{%.0f}$'
unset colorbox
set cbrange [2:8]

set label 1 at screen 0.05, graph 0.5 center 'Glasgow' rotate by 90

set notitle
plot "data/ps10-ts150.non-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

unset label 1

set notitle
plot "data/ps20-ts150.non-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set colorbox

set notitle
set cbtics 2 add ('${\le}10^{2}$' 2) add ('${\ge}10^{8}$' 8)
plot "data/ps30-ts150.non-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

unset colorbox
set cbrange [2:8]

set label 1 at screen 0.05, graph 0.5 center 'LAD' rotate by 90

set notitle
plot "data/ps10-ts150.lad-non-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

unset label 1

set notitle
plot "data/ps20-ts150.lad-non-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set colorbox

set cbtics 2 add ('${\le}10^{2}$' 2) add ('${\ge}10^{8}$' 8)
set notitle
plot "data/ps30-ts150.lad-non-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

unset colorbox
set cbrange [2:8]

set label 1 at screen 0.05, graph 0.5 center 'VF2' rotate by 90

set notitle
plot "data/ps10-ts150.vf2-non-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

unset label 1

set notitle
plot "data/ps20-ts150.vf2-non-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set colorbox

set cbtics 2 add ('${\le}10^{2}$' 2) add ('${\ge}10^{8}$' 8)
plot "data/ps30-ts150.vf2-non-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

