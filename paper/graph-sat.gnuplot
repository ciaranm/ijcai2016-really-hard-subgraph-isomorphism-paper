# vim: set et ft=gnuplot sw=4 :

set terminal tikz standalone color size 7.7in,6.6in font '\scriptsize' preamble '\usepackage{times,microtype,amssymb,amsmath}'
set output "gen-graph-sat.tex"

unset xlabel
unset ylabel
set xrange [0:1]
set noxtics
set yrange [0:1]
set noytics
set size square
set cbtics out scale 0.5 nomirror offset -1

set multiplot layout 5,6 spacing 0.02, 0.02

load "puyl.pal"
unset colorbox

set label 1 at screen 0.07, graph 0.5 center 'Satisfiable?' rotate by 90

set title "$G(10,x){\\hookrightarrow}G(75,y)$"
set cbtics 0.5
plot "data/ps10-ts75.induced.proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

unset label 1

set title "$G(12,x){\\hookrightarrow}G(75,y)$"
set cbtics 0.5
plot "data/ps12-ts75.induced.proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

set title "$G(14,x){\\hookrightarrow}G(75,y)$"
set cbtics 0.5
plot "data/ps14-ts75.induced.proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

set title "$G(16,x){\\hookrightarrow}G(75,y)$"
set cbtics 0.5
plot "data/ps16-ts75.induced.proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

set title "$G(18,x){\\hookrightarrow}G(75,y)$"
set cbtics 0.5
plot "data/ps18-ts75.induced.proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

set colorbox

set title "$G(25, x){\\hookrightarrow}G(75,y)$"
set cbtics 0.5
plot "data/ps25-ts75.induced.proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

load "ylgnbu.pal"
set palette positive
set format cb '$10^{%.0f}$'
unset colorbox
set cbrange [2:6]

set label 1 at screen 0.07, graph 0.5 center 'Glasgow' rotate by 90

set notitle
set cbtics 1 add ('${\le}10^{2}$' 2) add ('${\ge}10^{6}$' 6)
plot "data/ps10-ts75.induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

unset label 1

set notitle
set cbtics 1 add ('${\le}10^{2}$' 2) add ('${\ge}10^{6}$' 6)
plot "data/ps12-ts75.induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
set cbtics 1 add ('${\le}10^{2}$' 2) add ('${\ge}10^{6}$' 6)
plot "data/ps14-ts75.induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
set cbtics 1 add ('${\le}10^{2}$' 2) add ('${\ge}10^{6}$' 6)
plot "data/ps16-ts75.induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
set cbtics 1 add ('${\le}10^{2}$' 2) add ('${\ge}10^{6}$' 6)
plot "data/ps18-ts75.induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set colorbox

set notitle
plot "data/ps25-ts75.induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

unset colorbox
set cbrange [2:8]

set label 1 at screen 0.07, graph 0.5 center 'Clasp (PB)' rotate by 90

set notitle
plot "data/ps10-ts75.clasp-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

unset label 1

set notitle
plot "data/ps12-ts75.clasp-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
plot "data/ps14-ts75.clasp-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
plot "data/ps16-ts75.clasp-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
plot "data/ps18-ts75.clasp-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set colorbox

set cbtics 2 add ('${\le}10^{2}$' 2) add ('${\ge}10^{8}$' 8)
plot "data/ps25-ts75.clasp-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set label 1 at screen 0.07, graph 0.5 center 'Glucose (SAT)' rotate by 90

unset colorbox
set cbrange [2:8]

set notitle
plot "data/ps10-ts75.glucose-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

unset label 1

set notitle
plot "data/ps12-ts75.glucose-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
plot "data/ps14-ts75.glucose-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
plot "data/ps16-ts75.glucose-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
plot "data/ps18-ts75.glucose-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set colorbox

set cbtics 2 add ('${\le}10^{2}$' 2) add ('${\ge}10^{8}$' 8)
plot "data/ps25-ts75.glucose-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

unset colorbox
set cbrange [2:8]

set label 1 at screen 0.07, graph 0.5 center 'BBMC (Clique)' rotate by 90

set notitle
plot "data/ps10-ts75.clique-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

unset label 1

set notitle
plot "data/ps12-ts75.clique-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
plot "data/ps14-ts75.clique-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
plot "data/ps16-ts75.clique-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set notitle
plot "data/ps18-ts75.clique-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

set colorbox

set cbtics 2 add ('${\le}10^{2}$' 2) add ('${\ge}10^{8}$' 8)
plot "data/ps25-ts75.clique-induced.average-nodes.plot" u ($2/50):($1/50):(log10($3+1)) matrix w image notitle

