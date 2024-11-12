#!/bin/bash

if [ $# -ne heart.csv ]; then
  echo "Usage: $0 heart.csv"
  exit 1
fi

INPUT_FILE="heart.csv"
OUTPUT_FILE="generated_table.tex"

cat <<EOF > $OUTPUT_FILE
\documentclass{article}
\usepackage{geometry}
\usepackage{array}
\usepackage{longtable}
\geometry{margin=1in}
\title{HEART.CSV}
\date{}
\begin{document}
\maketitle
\begin{longtable}{|c|c|c|c|c|c|c|c|c|c|c|c|c|c|} 
EOF

while IFS=',' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14; do  # Adjust for the number of columns
  echo "$col1 & $col2 & $col3 & $col4 & $col5 & $col6 & $col7 & $col8 & $col9 & $col10 & $col11 & $col12 & $col13 & $col14\\\\ \\hline" >> $OUTPUT_FILE
done < "$INPUT_FILE"

cat <<EOF >> $OUTPUT_FILE
\end{longtable}

\end{document}
EOF

pdflatex $OUTPUT_FILE

rm -f *.aux *.log

echo "PDF generated successfully as ${OUTPUT_FILE%.tex}.pdf"

