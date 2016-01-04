# vim: set et ft=gnuplot sw=4 :

set terminal tikz color size 7.8in,8.5in font '\scriptsize'
set output "gen-graph-induced.tex"

unset xlabel
unset ylabel
set xrange [0:1]
set noxtics
set yrange [0:1]
set noytics
set size square
set cbtics out scale 0.5 nomirror offset -1

set multiplot layout 6,7 spacing 0.02, 0.02

set label 1 at screen 0.08, screen 0.74 'Satisfiable' rotate by 90
set label 2 at screen 0.08, screen 0.61 'Predicted' rotate by 90
set label 3 at screen 0.08, screen 0.55 'Bound' rotate by 90
set label 4 at screen 0.08, screen 0.41 'Glasgow' rotate by 90
set label 5 at screen 0.08, screen 0.28 'LAD' rotate by 90
set label 6 at screen 0.08, screen 0.14 'VF2' rotate by 90

load "puor.pal"
unset colorbox

set title "$G(8,x) \\hookrightarrow G(150,y)$"
set cbtics 0.5
plot "data/ps8-ts150.supinduced.proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

unset label 1
unset label 2
unset label 3
unset label 4
unset label 5
unset label 6
unset label 7

set title "$G(10,x) \\hookrightarrow G(150,y)$"
set cbtics 0.5
plot "data/ps10-ts150.induced.proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

set title "$G(14,x) \\hookrightarrow G(150,y)$"
set cbtics 0.5
plot "data/ps14-ts150.induced.proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

set title "$G(15,x) \\hookrightarrow G(150,y)$"
set cbtics 0.5
plot "data/ps15-ts150.induced.proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

set title "$G(16,x) \\hookrightarrow G(150,y)$"
set cbtics 0.5
plot "data/ps16-ts150.induced.proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

set title "$G(20,x) \\hookrightarrow G(150,y)$"
set cbtics 0.5
plot "data/ps20-ts150.induced.proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

set colorbox

set title "$G(30,x) \\hookrightarrow G(150,y)$"
set cbtics 0.5
plot "data/ps30-ts150.induced.proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

unset colorbox
set cbrange [0:1]

set notitle

plot "data/ps8-ts150.induced.predicted.plot" u ($1/50):($2/50):($3) matrix w image notitle

plot "data/ps10-ts150.induced.predicted.plot" u ($1/50):($2/50):($3) matrix w image notitle

plot "data/ps14-ts150.induced.predicted.plot" u ($1/50):($2/50):($3) matrix w image notitle

plot "data/ps15-ts150.induced.predicted.plot" u ($1/50):($2/50):($3) matrix w image notitle

plot "data/ps16-ts150.induced.predicted.plot" u ($1/50):($2/50):($3) matrix w image notitle

plot "data/ps20-ts150.induced.predicted.plot" u ($1/50):($2/50):($3) matrix w image notitle

set colorbox

set cbtics 0 add ('unsat' 0) add ('sat' 1)
plot "data/ps30-ts150.induced.predicted.plot" u ($1/50):($2/50):($3) matrix w image notitle

unset colorbox
set notitle
set cbrange [0:1]

set cbtics 0.5
plot "data/ps8-ts150.induced.predicted-proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

set cbtics 0.5
plot "data/ps10-ts150.induced.predicted-proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

set cbtics 0.5
plot "data/ps14-ts150.induced.predicted-proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

set cbtics 0.5
plot "data/ps15-ts150.induced.predicted-proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

set cbtics 0.5
plot "data/ps16-ts150.induced.predicted-proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

set cbtics 0.5
plot "data/ps20-ts150.induced.predicted-proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

set colorbox

set cbtics 0.5
plot "data/ps30-ts150.induced.predicted-proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

load "ylgnbu.pal"
set palette positive
set format cb '$10^{%.0f}$'
unset colorbox
set cbrange [2:8]

set notitle
set cbtics 1 add ('${\le}10^{2}$' 2) add ('${\ge}10^{6}$' 6)
plot "data/ps8-ts150.supinduced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
set cbtics 1 add ('${\le}10^{2}$' 2) add ('${\ge}10^{6}$' 6)
plot "data/ps10-ts150.supinduced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
set cbtics 1 add ('${\le}10^{2}$' 2) add ('${\ge}10^{6}$' 6)
plot "data/ps14-ts150.induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
set cbtics 1 add ('${\le}10^{2}$' 2) add ('${\ge}10^{6}$' 6)
plot "data/ps15-ts150.induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
set cbtics 1 add ('${\le}10^{2}$' 2) add ('${\ge}10^{6}$' 6)
plot "data/ps16-ts150.induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
set cbtics 1 add ('${\le}10^{2}$' 2) add ('${\ge}10^{8}$' 8)
plot "data/ps20-ts150.induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set colorbox

set notitle
plot "data/ps30-ts150.induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

unset colorbox
set cbrange [2:8]

set notitle
plot "data/ps8-ts150.lad-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
plot "data/ps10-ts150.lad-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
plot "data/ps14-ts150.lad-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
plot "data/ps15-ts150.lad-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
plot "data/ps16-ts150.lad-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
plot "data/ps20-ts150.lad-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set colorbox

set notitle
set cbtics 1 add ('${\le}10^{2}$' 2) add ('${\ge}10^{8}$' 8)
plot "data/ps30-ts150.lad-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

unset colorbox
set cbrange [2:8]

set notitle
plot "data/ps8-ts150.vf2-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
plot "data/ps10-ts150.vf2-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
plot "data/ps14-ts150.vf2-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
plot "data/ps15-ts150.vf2-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
plot "data/ps16-ts150.vf2-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
plot "data/ps20-ts150.vf2-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set colorbox

set cbtics 1 add ('${\le}10^{2}$' 2) add ('${\ge}10^{8}$' 8)
plot "data/ps30-ts150.vf2-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

