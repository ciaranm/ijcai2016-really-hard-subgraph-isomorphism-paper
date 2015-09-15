# vim: set et ft=gnuplot sw=4 :

set terminal tikz color size 7in,3.5in font '\scriptsize'
set output "gen-graph-induced.tex"

unset xlabel
unset ylabel
set xrange [0:1]
set noxtics
set yrange [0:1]
set noytics
set size square
set cbtics out scale 0.5 nomirror offset -1

set multiplot layout 3,6 spacing 0.01, 0.05

load "puor.pal"
unset colorbox

set title "$10 \\hookrightarrow 150$"
set cbtics 0.5
plot "ps10-ts150.induced.proportion-sat.plot" u ($2/25):($1/25):($3) matrix w image notitle

set title "$14 \\hookrightarrow 150$"
set cbtics 0.5
plot "ps14-ts150.induced.proportion-sat.plot" u ($2/25):($1/25):($3) matrix w image notitle

set title "$15 \\hookrightarrow 150$"
set cbtics 0.5
plot "ps15-ts150.induced.proportion-sat.plot" u ($2/25):($1/25):($3) matrix w image notitle

set title "$16 \\hookrightarrow 150$"
set cbtics 0.5
plot "ps16-ts150.induced.proportion-sat.plot" u ($2/25):($1/25):($3) matrix w image notitle

set title "$20 \\hookrightarrow 150$"
set cbtics 0.5
plot "ps20-ts150.induced.proportion-sat.plot" u ($2/25):($1/25):($3) matrix w image notitle

set colorbox

set title "$30 \\hookrightarrow 150$"
set cbtics 0.5
plot "ps30-ts150.induced.proportion-sat.plot" u ($2/25):($1/25):($3) matrix w image notitle

load "ylgnbu.pal"
set format cb '$10^{%.0f}$'
unset colorbox
set cbrange [2:6]

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
set cbtics 1 add ('${\le}10^{2}$' 2) add ('${\ge}10^{6}$' 6)
plot "ps20-ts150.induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set colorbox

set notitle
plot "ps30-ts150.induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

unset colorbox
set cbrange [3:7]

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

set label 1 at screen 0.05, screen 0.71 'Satisfiable' rotate by 90
set label 2 at screen 0.05, screen 0.43 'Glasgow' rotate by 90
set label 3 at screen 0.05, screen 0.17 'VF2' rotate by 90

set cbtics 1 add ('${\le}10^{3}$' 3) add ('${\ge}10^{7}$' 7)
plot "ps30-ts150.vf2-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

