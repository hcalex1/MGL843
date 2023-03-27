# MGL843

## Setup

1. Clone the project:
```
git clone https://github.com/hcalex1/MGL843.git
cd MGL843
```
The list of GitHub repositories for this analysis can be found in `inputs-outputs/repos.txt`.

2. Clone FamixTypeScriptImporter:
```
git clone https://github.com/dig2root/FamixTypeScriptImporter.git
```

3. Download [Pharo](https://pharo.org/download) and launch it. 

4. Create a Moose Suite 10 image inside Pharo and launch it.

5. Import the [FamixTypeScript metamodel](https://github.com/dig2root/FamixTypeScript). This can be done from the Moose Playground:
```
Metacello new 
    githubUser: 'dig2root' project: 'FamixTypeScript' commitish: 'master' path: 'src';
    baseline: 'FamixTypeScript';
    load.
```

6. Add the [metrics generation package](https://github.com/dig2root/PharoPackageMGL843) with Iceberg (`Ctrl+O+I`). 

*TODO: insert flow diagram*

## 1. Clone Repos and Generate Famix Models

Clone the GitHub repositories listed in `inputs-outputs/repos.txt` to `repos/`, generate a Famix TypeScript model for each and saving them to `inputs-outputs/models` (this also generates `inputs-outputs/repo_list.csv` containing the paths to each repository's source code and Famix model)::
```
./scripts/process_repos.sh
```

## 2. Generate Class Metrics
*TODO in pharo*

## 3. Get git logs
Save git logs to `inputs-outputs/git_logs.txt` and parse them to `inputs-outputs/commits.csv`:
```
./scripts/get_git_logs.sh
python scripts/parse_git_logs.py
```

## 4. Analysis
Data analysis is in `notebooks/analysis.ipynb`.