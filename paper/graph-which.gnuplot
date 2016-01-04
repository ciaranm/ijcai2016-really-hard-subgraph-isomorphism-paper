# vim: set et ft=gnuplot sw=4 :

set terminal tikz color size 8.1in,3in font '\tiny'
set output "gen-graph-which.tex"

unset xlabel
unset ylabel
set xrange [0:1]
set noxtics
set yrange [0:1]
set noytics
set size square
set cbtics out scale 0.5 nomirror offset -1

set multiplot layout 2,7 spacing 0.02, 0.02

load "puor.pal"
unset colorbox

set title "$G(8,x){\\hookrightarrow}G(150,y)$"
set cbtics 0.5
plot "data/ps8-ts150.induced.proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

unset label 1
unset label 2
unset label 3
unset label 4
unset label 5
unset label 6
unset label 7

set title "$G(10,x){\\hookrightarrow}G(150,y)$"
plot "data/ps10-ts150.induced.proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

set title "$G(14,x){\\hookrightarrow}G(150,y)$"
plot "data/ps14-ts150.induced.proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

set title "$G(15,x){\\hookrightarrow}G(150,y)$"
plot "data/ps15-ts150.induced.proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

set title "$G(16,x){\\hookrightarrow}G(150,y)$"
plot "data/ps16-ts150.induced.proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

set title "$G(20,x){\\hookrightarrow}G(150,y)$"
plot "data/ps20-ts150.induced.proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

set colorbox

set title "$G(30,x){\\hookrightarrow}G(150,y)$"
set cbtics 1 add ("unsat" 0) ("sat" 1)
plot "data/ps30-ts150.induced.proportion-sat.plot" u ($2/50):($1/50):($3) matrix w image notitle

unset colorbox

set cbtics 1 add ("flip" 1) ("keep" -1) ("neutral" 0)

load "moreland.pal"
unset colorbox

set title "$G(8,x){\\hookrightarrow}G(150,y)$"
plot "data/ps8-ts150.induced-which-rev-both.plot" u ($2/50):($1/50):($3) matrix w image notitle

set title "$G(10,x){\\hookrightarrow}G(150,y)$"
plot "data/ps10-ts150.induced-which-rev-both.plot" u ($2/50):($1/50):($3) matrix w image notitle

set title "$G(14,x){\\hookrightarrow}G(150,y)$"
plot "data/ps14-ts150.induced-which-rev-both.plot" u ($2/50):($1/50):($3) matrix w image notitle

set title "$G(15,x){\\hookrightarrow}G(150,y)$"
plot "data/ps15-ts150.induced-which-rev-both.plot" u ($2/50):($1/50):($3) matrix w image notitle

set title "$G(16,x){\\hookrightarrow}G(150,y)$"
plot "data/ps16-ts150.induced-which-rev-both.plot" u ($2/50):($1/50):($3) matrix w image notitle

set title "$G(20,x){\\hookrightarrow}G(150,y)$"
plot "data/ps20-ts150.induced-which-rev-both.plot" u ($2/50):($1/50):($3) matrix w image notitle

set colorbox

set title "$G(30,x){\\hookrightarrow}G(150,y)$"
plot "data/ps30-ts150.induced-which-rev-both.plot" u ($2/50):($1/50):($3) matrix w image notitle


