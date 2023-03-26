#!/bin/bash

BASEDIR=$(pwd)
TS2FAMIX=$BASEDIR/FamixTypeScriptImporter/src/ts2famix-cli.ts
REPOS=$BASEDIR/repos
MODELS=$BASEDIR/inputs-outputs/models
REPO_LIST=$BASEDIR/inputs-outputs/repos.txt

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
