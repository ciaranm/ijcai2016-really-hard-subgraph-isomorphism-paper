# vim: set et ft=gnuplot sw=4 :

set terminal tikz color size 3.3in,5.6in font '\scriptsize'
set output "gen-graph-non-induced.tex"

unset xlabel
unset ylabel
set xrange [0:1]
set noxtics
set yrange [0:1]
set noytics
set size square
set cbtics out scale 0.5 nomirror offset -1

set multiplot layout 5,3 spacing 0.03, 0.02

load "puor.pal"
unset colorbox

set label 1 at screen 0.05, screen 0.79 'Satisfiable' rotate by 90
set label 2 at screen 0.05, screen 0.62 'Prediction' rotate by 90
set label 3 at screen 0.05, screen 0.47 'Glasgow' rotate by 90
set label 4 at screen 0.05, screen 0.31 'LAD' rotate by 90
set label 5 at screen 0.05, screen 0.15 'VF2' rotate by 90

set title "$G(10,x){\\rightarrowtail}G(150,y)$" offset character -1.5
set cbtics 0.5
plot "data/ps10-ts150.non-induced.proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

unset label 1
unset label 2
unset label 3
unset label 4
unset label 5

set title "$G(20,x){\\rightarrowtail}G(150,y)$" offset character 0
set cbtics 0.5
plot "data/ps20-ts150.non-induced.proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

set colorbox

set title "$G(30,x){\\rightarrowtail}G(150,y)$" offset character 1.5
plot "data/ps30-ts150.non-induced.proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

unset colorbox

set cbrange [0:1]
set notitle
plot "data/ps10-ts150.non-induced.predicted.plot" u ($1/50):($2/50):($3) matrix w image notitle

set notitle
plot "data/ps20-ts150.non-induced.predicted.plot" u ($1/50):($2/50):($3) matrix w image notitle

set colorbox

set notitle
set cbtics 0 add ('unsat' 0) add ('sat' 1)
plot "data/ps30-ts150.non-induced.predicted.plot" u ($1/50):($2/50):($3) matrix w image notitle

load "ylgnbu.pal"
set palette positive
set format cb '$10^{%.0f}$'
unset colorbox
set cbrange [2:8]

set notitle
plot "data/ps10-ts150.non-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
plot "data/ps20-ts150.non-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set colorbox

set notitle
set cbtics 2 add ('${\le}10^{2}$' 2) add ('${\ge}10^{8}$' 8)
plot "data/ps30-ts150.non-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

unset colorbox
set cbrange [3:7]

set notitle
plot "data/ps10-ts150.lad-non-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
plot "data/ps20-ts150.lad-non-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set colorbox

set cbtics 1 add ('${\le}10^{3}$' 3) add ('${\ge}10^{7}$' 7)
set notitle
plot "data/ps30-ts150.lad-non-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

unset colorbox
set cbrange [3:7]

set notitle
plot "data/ps10-ts150.vf2-non-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
plot "data/ps20-ts150.vf2-non-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set colorbox

set cbtics 1 add ('${\le}10^{3}$' 3) add ('${\ge}10^{7}$' 7)
plot "data/ps30-ts150.vf2-non-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

