set terminal png size 800,600
set output '4a.png'
set title "Sex vs. Heart Disease"
set style fill solid
set ylabel "Count"
set xlabel "Sex"
set style data histogram
set key inside top left box title "target" 

plot \
    "< awk -F',' '$14==1 {count[$2,1]++} END {for (key in count) print key, count[key]}' heart.csv" using 2:xtic(1) title "1" lc rgb "blue", \
    "< awk -F',' '$14==0 {count[$2,0]++} END {for (key in count) print key, count[key]}' heart.csv" using 2:xtic(1) title "0" lc rgb "orange"

