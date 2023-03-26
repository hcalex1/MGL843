# MGL843

## Setup

Clone the project:
```
git clone https://github.com/hcalex1/MGL843.git
cd MGL843
```
The list of GitHub repositories for this analysis can be found in `inputs-outputs/repos.txt`.

Clone FamixTypeScriptImporter:
```
git clone https://github.com/dig2root/FamixTypeScriptImporter.git
```

Download and extract Pharo:
```
wget https://files.pharo.org/pharo-launcher/linux64
unzip PharoLauncher-linux-*.zip
```

Install Moose in Pharo. Next open Moose and import the [FamixTypeScript metamodel](https://github.com/dig2root/FamixTypeScript) and the [metrics generation package](https://github.com/dig2root/PharoPackageMGL843). *TODO: expand on this* 

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