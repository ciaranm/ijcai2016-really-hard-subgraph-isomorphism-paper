# vim: set et ft=gnuplot sw=4 :

set terminal tikz color size 7in,6in font ',7'
set output "gen-graph-sat.tex"

unset xlabel
unset ylabel
set xrange [0:1]
set noxtics
set yrange [0:1]
set noytics
set size square
set cbtics out scale 0.5 nomirror offset -1

set multiplot layout 3,5 spacing 0.005, 0.05

set palette negative
load "puor.pal"
unset colorbox

set title "\\textbf{SAT} ($10 \\hookrightarrow 75$)"
set cbtics 0.5
plot "ps10-ts75.induced.proportion-sat.plot" u ($2/25):($1/25):($3) matrix w image notitle

set title "\\textbf{SAT} ($12 \\hookrightarrow 75$)"
set cbtics 0.5
plot "ps12-ts75.induced.proportion-sat.plot" u ($2/25):($1/25):($3) matrix w image notitle

set title "\\textbf{SAT} ($14 \\hookrightarrow 75$)"
set cbtics 0.5
plot "ps14-ts75.induced.proportion-sat.plot" u ($2/25):($1/25):($3) matrix w image notitle

set title "\\textbf{SAT} ($16 \\hookrightarrow 75$)"
set cbtics 0.5
plot "ps16-ts75.induced.proportion-sat.plot" u ($2/25):($1/25):($3) matrix w image notitle

set colorbox

set title "\\textbf{SAT} ($18 \\hookrightarrow 75$)"
set cbtics 0.5
plot "ps18-ts75.induced.proportion-sat.plot" u ($2/25):($1/25):($3) matrix w image notitle

set palette positive
load "ylgnbu.pal"
unset colorbox
set cbrange [2:6]

set title "\\textbf{Glasgow} ($10 \\hookrightarrow 75$)"
set cbtics 1 add ('${\le}10^{2}$' 2) add ('${\ge}10^{6}$' 6)
set format cb '$10^{%.0f}$'
plot "ps10-ts75.induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set title "\\textbf{Glasgow} ($12 \\hookrightarrow 75$)"
set format cb '$10^{%.0f}$'
plot "ps12-ts75.induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set title "\\textbf{Glasgow} ($14 \\hookrightarrow 75$)"
set format cb '$10^{%.0f}$'
plot "ps14-ts75.induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set title "\\textbf{Glasgow} ($16 \\hookrightarrow 75$)"
set format cb '$10^{%.0f}$'
plot "ps16-ts75.induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set colorbox

set title "\\textbf{Glasgow} ($18 \\hookrightarrow 75$)"
set format cb '$10^{%.0f}$'
plot "ps18-ts75.induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

unset colorbox
set cbrange [3:7]

set title "\\textbf{Glucose} ($10 \\hookrightarrow 75$)"
set format cb '$10^{%.0f}$'
plot "ps10-ts75.glucose-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set title "\\textbf{Glucose} ($12 \\hookrightarrow 75$)"
set format cb '$10^{%.0f}$'
plot "ps12-ts75.glucose-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set title "\\textbf{Glucose} ($14 \\hookrightarrow 75$)"
set format cb '$10^{%.0f}$'
plot "ps14-ts75.glucose-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set title "\\textbf{Glucose} ($16 \\hookrightarrow 75$)"
set format cb '$10^{%.0f}$'
plot "ps16-ts75.glucose-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

set colorbox

set title "\\textbf{Glucose} ($18 \\hookrightarrow 75$)"
set format cb '$10^{%.0f}$'
set cbtics 1 add ('${\le}10^{3}$' 3) add ('${\ge}10^{7}$' 7)
plot "ps18-ts75.glucose-induced.average-nodes.plot" u ($2/25):($1/25):(log10($3+1)) matrix w image notitle

