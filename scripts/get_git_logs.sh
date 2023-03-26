#!/bin/bash

BASEDIR=$(pwd)

col_a='Source'
INPUT=$BASEDIR/inputs-outputs/pharo_inputs.csv
OUTPUT=$BASEDIR/inputs-outputs/git_logs.txt

echo "" > $OUTPUT

loc_col_a=$(head -1 $INPUT | tr ',' '\n' | nl |grep -w "$col_a" | tr -d " " | awk -F " " '{print $1}')

while IFS="," read -r rec1
do
  cd $rec1
  git log --name-status --pretty=format:"H %H%nT %ct%nS %s" >> $OUTPUT
done < <(cut -d "," -f${loc_col_a} $INPUT | tail -n +2)
