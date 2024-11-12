reset
set datafile separator ","
set terminal pdfcairo size 8,6 font "Arial,12"
set output "4d.pdf"

stats 'heart.csv' using (column("age") >= 40 && column("age") < 50 && column("target") == 1 ? 1 : 0) nooutput
heart_40_50 = STATS_sum
stats 'heart.csv' using (column("age") >= 50 && column("age") < 60 && column("target") == 1 ? 1 : 0) nooutput
heart_50_60 = STATS_sum
stats 'heart.csv' using (column("age") >= 60 && column("age") < 70 && column("target") == 1 ? 1 : 0) nooutput
heart_60_70 = STATS_sum
stats 'heart.csv' using (column("age") >= 70 && column("age") < 80 && column("target") == 1 ? 1 : 0) nooutput
heart_70_80 = STATS_sum
stats 'heart.csv' using (column("age") >= 80 && column("age") < 90 && column("target") == 1 ? 1 : 0) nooutput
heart_80_90 = STATS_sum
stats 'heart.csv' using (column("age") >= 90 && column("age") <= 100 && column("target") == 1 ? 1 : 0) nooutput
heart_90_100 = STATS_sum

total_cases = heart_40_50 + heart_50_60 + heart_60_70 + heart_70_80 + heart_80_90 + heart_90_100
if (total_cases == 0) total_cases = 1  

percent_40_50 = heart_40_50 / total_cases * 100
percent_50_60 = heart_50_60 / total_cases * 100
percent_60_70 = heart_60_70 / total_cases * 100
percent_70_80 = heart_70_80 / total_cases * 100
percent_80_90 = heart_80_90 / total_cases * 100
percent_90_100 = heart_90_100 / total_cases * 100

angle_40_50 = percent_40_50 * 3.6
angle_50_60 = percent_50_60 * 3.6
angle_60_70 = percent_60_70 * 3.6
angle_70_80 = percent_70_80 * 3.6
angle_80_90 = percent_80_90 * 3.6
angle_90_100 = percent_90_100 * 3.6

start_50_60 = angle_40_50
start_60_70 = start_50_60 + angle_50_60
start_70_80 = start_60_70 + angle_60_70
start_80_90 = start_70_80 + angle_70_80
start_90_100 = start_80_90 + angle_80_90

set style fill solid 1.0 border -1
set title "Percentage of Heart Disease Cases by Age Group"
unset key
unset border
unset tics
set xrange [-1.5:1.5]
set yrange [-1.5:1.5]

set object 1 circle at 0,0 size 1.0 arc [0:angle_40_50] fillcolor rgb "red"
set object 2 circle at 0,0 size 1.0 arc [start_50_60:start_50_60+angle_50_60] fillcolor rgb "blue"
set object 3 circle at 0,0 size 1.0 arc [start_60_70:start_60_70+angle_60_70] fillcolor rgb "green"
set object 4 circle at 0,0 size 1.0 arc [start_70_80:start_70_80+angle_70_80] fillcolor rgb "yellow"
set object 5 circle at 0,0 size 1.0 arc [start_80_90:start_80_90+angle_80_90] fillcolor rgb "purple"
set object 6 circle at 0,0 size 1.0 arc [start_90_100:360] fillcolor rgb "cyan"

radius = 1.3  # Distance from center for labels
set label 1 sprintf("40-50: %.2f%%", percent_40_50) at first (radius * cos((angle_40_50 / 2) * pi / 180)), (radius * sin((angle_40_50 / 2) * pi / 180)) center
set label 2 sprintf("50-60: %.2f%%", percent_50_60) at first (radius * cos((start_50_60 + angle_50_60 / 2) * pi / 180)), (radius * sin((start_50_60 + angle_50_60 / 2) * pi / 180)) center
set label 3 sprintf("60-70: %.2f%%", percent_60_70) at first (radius * cos((start_60_70 + angle_60_70 / 2) * pi / 180)), (radius * sin((start_60_70 + angle_60_70 / 2) * pi / 180)) center
set label 4 sprintf("70-80: %.2f%%", percent_70_80) at first (radius * cos((start_70_80 + angle_70_80 / 2) * pi / 180)), (radius * sin((start_70_80 + angle_70_80 / 2) * pi / 180)) center
set label 5 sprintf("80-90: %.2f%%", percent_80_90) at first (radius * cos((start_80_90 + angle_80_90 / 2) * pi / 180)), (radius * sin((start_80_90 + angle_80_90 / 2) * pi / 180)) center
set label 6 sprintf("90-100: %.2f%%", percent_90_100) at first (radius * cos((start_90_100 + angle_90_100 / 2) * pi / 180)), (radius * sin((start_90_100 + angle_90_100 / 2) * pi / 180)) center

plot NaN notitle

