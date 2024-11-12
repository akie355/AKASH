set terminal png size 800,600
set output '4b.png'
set title "Correlation between Age and Blood Pressure"
set xlabel "Age"
set ylabel "Blood Pressure (trestbps)"
set style data points
set pointsize 1.5 
set style fill transparent solid 0.5 
plot "< awk -F',' '{if ($1 ~ /^[0-9]+$/ && $4 ~ /^[0-9]+$/) print $1, $4}' heart.csv" using 1:2 with points pt 7 lc rgb "blue" title "Age vs Blood Pressure"

