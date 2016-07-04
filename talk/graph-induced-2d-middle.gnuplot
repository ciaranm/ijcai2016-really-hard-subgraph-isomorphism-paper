# vim: set et ft=gnuplot sw=4 :

set terminal tikz color size 4in,2.8in font '\tiny'
set output "gen-graph-induced-2d-middle.tex"

load "puor.pal"

unset xlabel
unset ylabel
set xrange [0:1]
set noxtics
set yrange [0:1]
set noytics
set size square
set cbtics out scale 0.5 nomirror offset -1

set multiplot layout 2,3 scale 1, 1

unset colorbox
set notitle

set label 1 at screen 0.66, graph 0.5 center 'Satisfiable?' rotate by 90

set multiplot next
set multiplot next

set cbtics 0.5
set colorbox user origin screen 0.98, graph 0 size character 1, graph 1

set label 2 at graph 0.5, screen 1 center "$G(30,x){\\hookrightarrow}G(150,y)$"
plot "ps30-ts150.induced.proportion-sat.plot" u ($2/100):($1/100):($3) matrix w image notitle, \
    "ps30-ts150.induced.predicted-line.plot" u 1:2 w line notitle lc "black", \
    "ps30-ts150.induced.predicted-line.plot" u 4:5 w line notitle lc "black"

unset label 2

load "ylgnbu.pal"

set palette positive
set format cb '$10^{%.0f}$'
unset colorbox
set cbrange [2:8]

set label 1 at screen 0.01, graph 0.5 center 'Difficulty' rotate by 90

set label 2 at graph 0.5, screen 0 center "VF2"

plot "ps30-ts150.vf2-induced.average-nodes.plot" u ($2/100):($1/100):(log10($3+1)) matrix w image notitle

unset label 1

set label 2 at graph 0.5, screen 0 center "LAD"
plot "ps30-ts150.lad-induced.average-nodes.plot" u ($2/100):($1/100):(log10($3+1)) matrix w image notitle

set colorbox user origin screen 0.98, graph 0 size character 1, graph 1

set label 2 at graph 0.5, screen 0 center "Glasgow"
set cbtics 2 add ('${\le}10^{2}$' 2) add ('${\ge}10^{8}$' 8)
plot "ps30-ts150.induced.average-nodes.plot" u ($2/100):($1/100):(log10($3+1)) matrix w image notitle

