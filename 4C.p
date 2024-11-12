set terminal png size 800,600
set output '4c.png'
set title "Correlation between Age and Cholesterol (No Heart Disease)"
set xlabel "Age"
set ylabel "Cholesterol"
set style data linespoints
set pointsize 1.5 
set linestyle 1 lt 1 lw 2 lc rgb "blue"
plot "< awk -F',' '$14==0 {print $1, $5}' heart.csv" using 1:2 with linespoints linestyle 1 title "No Heart Disease"

