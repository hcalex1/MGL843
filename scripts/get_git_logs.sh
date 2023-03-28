#!/bin/bash

BASEDIR=$(pwd)

OUTPUT=$BASEDIR/git_logs.txt

# Loop through arguments and process them
for arg in "$@"
do
    case $arg in

        -i|--input)
        INPUT=$(realpath $2)
        shift
        shift
        ;;

        -o|--output)
        OUTPUT=$(realpath $2)
        shift
        shift
        ;;

    esac
done

# Init output file
echo "" > $OUTPUT

# Define input CSV format
col_a='Source'
loc_col_a=$(head -1 $INPUT | tr ',' '\n' | nl |grep -w "$col_a" | tr -d " " | awk -F " " '{print $1}')

git config diff.renameLimit 999999

# Parse input CSV and get git logs
while IFS="," read -r rec1
do
  cd $rec1
  git log --name-status --pretty=format:"H %H%nT %ct%nS %s" >> $OUTPUT
done < <(cut -d "," -f${loc_col_a} $INPUT | tail -n +2)
