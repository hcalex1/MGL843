#!/bin/bash

BASEDIR=$(pwd)

REPOS=$BASEDIR/repos
TS2FAMIX=$BASEDIR/FamixTypeScriptImporter/src/ts2famix-cli.ts
PHARO_INPUTS=$BASEDIR/inputs-outputs/pharo_inputs.csv
MODELS=$BASEDIR/inputs-outputs/models

echo "Project,Source,Model" > $PHARO_INPUTS

cd $REPOS

for repo in * ; do
    ts-node $TS2FAMIX -i "$repo/**/*.ts" -o $MODELS/$repo.json
    echo "$repo,$REPOS/$repo,$MODELS/$repo.json"
done

cd $BASEDIR