#!/bin/bash

BASEDIR=$(pwd)
TS2FAMIXDIR=/tmp/FamixTypeScriptImporter
TS2FAMIX=$TS2FAMIXDIR/src/ts2famix-cli.ts
REPOS=$BASEDIR/repos
MODELS=$BASEDIR/inputs-outputs/models
REPO_LIST=$BASEDIR/inputs-outputs/repos.txt

# Clone FamixTypeScriptImporter repo
git clone https://github.com/dig2root/FamixTypeScriptImporter.git $TS2FAMIXDIR

#Init CSV
CSV=$BASEDIR/inputs-outputs/repo_list.csv
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

  # Write paths to csv
  echo "$char2,$source,$model" >> $CSV
done

rm -rf $TS2FAMIXDIR