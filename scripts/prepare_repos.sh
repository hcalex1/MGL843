#!/bin/bash

BASEDIR=$(pwd)
TS2FAMIXDIR=/tmp/FamixTypeScriptImporter
TS2FAMIX=$TS2FAMIXDIR/src/ts2famix-cli.ts
MODELS=$BASEDIR
REPOS=/tmp/repos

# Loop through arguments and process them
for arg in "$@"
do
    case $arg in

        -i|--input)
        REPO_LIST=$2
        shift
        shift
        ;;

        -o|--output)
        MODELS=$(realpath $2)
        shift
        shift
        ;;

        -c|--clone-dir)
        REPOS=$(realpath $2)
        shift
        shift
        ;;

    esac
done

# Clone FamixTypeScriptImporter repo
git clone https://github.com/dig2root/FamixTypeScriptImporter.git $TS2FAMIXDIR
cd $TS2FAMIXDIR && npm install ; cd $BASEDIR

#Init CSV
mkdir -p $MODELS
CSV=$MODELS/repo_list.csv
echo "Project,Source,Model" > $CSV

# Iterate each GitHub repo
cat $REPO_LIST | while read line; do
  urlGit="https://github.com/"$line".git"
  IFS='/' read -r char1 char2 <<< "$line"
  source="$REPOS/$char2"
  model=$MODELS/$char2.json


  # Clone project
  git clone $urlGit $source

  # Create model
  ts-node $TS2FAMIX -i "$source/**/*.ts" -o $model

  # Write paths to csv if successful
  if [ -f "$model" ]
  then
    echo "$char2,$source,$model" >> $CSV
  fi
done

rm -rf $TS2FAMIXDIR