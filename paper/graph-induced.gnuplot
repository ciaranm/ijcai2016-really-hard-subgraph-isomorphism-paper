# vim: set et ft=gnuplot sw=4 :

set terminal tikz color size 7.8in,5.3in font '\scriptsize'
set output "gen-graph-induced.tex"

unset xlabel
unset ylabel
set xrange [0:1]
set noxtics
set yrange [0:1]
set noytics
set size square
set cbtics out scale 0.5 nomirror offset -1

set multiplot layout 4,6 spacing 0.02, 0.02

set label 1 at screen 0.08, screen 0.75 'Satisfiable' rotate by 90
set label 2 at screen 0.08, screen 0.55 'Glasgow' rotate by 90
set label 3 at screen 0.08, screen 0.36 'LAD' rotate by 90
set label 4 at screen 0.08, screen 0.16 'VF2' rotate by 90

load "puor.pal"
unset colorbox

set title "$G(10,x) \\hookrightarrow G(150,y)$"
set cbtics 0.5
plot "ps10-ts150.induced.proportion-sat.plot" u ($2/25):($1/25):($3) matrix w image notitle

unset label 1
unset label 2
unset label 3
unset label 4

set title "$G(14,x) \\hookrightarrow G(150,y)$"
set cbtics 0.5
plot "ps14-ts150.induced.proportion-sat.plot" u ($2/25):($1/25):($3) matrix w image notitle

set title "$G(15,x) \\hookrightarrow G(150,y)$"
set cbtics 0.5
plot "ps15-ts150.induced.proportion-sat.plot" u ($2/25):($1/25):($3) matrix w image notitle

set title "$G(16,x) \\hookrightarrow G(150,y)$"
set cbtics 0.5
plot "ps16-ts150.induced.proportion-sat.plot" u ($2/25):($1/25):($3) matrix w image notitle

set title "$G(20,x) \\hookrightarrow G(150,y)$"
set cbtics 0.5
plot "ps20-ts150.induced.proportion-sat.plot" u ($2/25):($1/25):($3) matrix w image notitle

set colorbox

set title "$G(30,x) \\hookrightarrow G(150,y)$"
set cbtics 0.5
plot "ps30-ts150.induced.proportion-sat.plot" u ($2/25):($1/25):($3) matrix w image notitle

load "ylgnbu.pal"
set format cb '$10^{%.0f}$'
unset colorbox
set cbrange [2:8]

set notitle
set cbtics 1 add ('${\le}10^{2}$' 2) add ('${\ge}10^{6}$' 6)
plot "ps10-ts150.induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
set cbtics 1 add ('${\le}10^{2}$' 2) add ('${\ge}10^{6}$' 6)
plot "ps14-ts150.induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
set cbtics 1 add ('${\le}10^{2}$' 2) add ('${\ge}10^{6}$' 6)
plot "ps15-ts150.induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
set cbtics 1 add ('${\le}10^{2}$' 2) add ('${\ge}10^{6}$' 6)
plot "ps16-ts150.induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
set cbtics 1 add ('${\le}10^{2}$' 2) add ('${\ge}10^{8}$' 8)
plot "ps20-ts150.induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set colorbox

set notitle
plot "ps30-ts150.induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

unset colorbox
set cbrange [2:8]

set notitle
plot "ps10-ts150.lad-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
plot "ps14-ts150.lad-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
plot "ps15-ts150.lad-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
plot "ps16-ts150.lad-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
plot "ps20-ts150.lad-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set colorbox

set notitle
set cbtics 1 add ('${\le}10^{2}$' 2) add ('${\ge}10^{8}$' 8)
plot "ps30-ts150.lad-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

unset colorbox
set cbrange [2:8]

set notitle
plot "ps10-ts150.vf2-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
plot "ps14-ts150.vf2-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
plot "ps15-ts150.vf2-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
plot "ps16-ts150.vf2-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set notitle
plot "ps20-ts150.vf2-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set colorbox

set cbtics 1 add ('${\le}10^{2}$' 2) add ('${\ge}10^{8}$' 8)
plot "ps30-ts150.vf2-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

