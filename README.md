# MGL843

## Setup

1. Clone the project:
```sh
git clone https://github.com/hcalex1/MGL843.git
```
The list of GitHub repositories for this analysis can be found in `inputs-outputs/repos.txt`.

2. Download [Pharo](https://pharo.org/download) and launch it. 

3. Create a Moose Suite 10 image inside Pharo and launch it.

4. Import the FamixTypeScript metamodel. Open the Moose Playground with `Ctrl+O+W` and run the following script:

```ts
Metacello new 
    githubUser: 'dig2root' project: 'FamixTypeScript' commitish: 'master' path: 'src';
    baseline: 'FamixTypeScript';
    load.
```

5. Add the [metrics generation package](https://github.com/dig2root/PharoPackageMGL843) with Iceberg. 
    1. Open Iceberg with `Ctrl+O+I` or by going to **Sources > Iceberg**.
    2. Click on **Add**.
    3. Select the **Clone From github.com** tab.
    4. Enter *dig2root* in the **Owner name** field, *PharoPackageMGL843* in the **Project name** field, *HTTPS* in the **Protocol** field and click on **OK**.
    5. In the *Iceberg* window, double click on **PharoPackageMGL843**.
    6. In the pop-up window right-click on **MGL843-Core** and select **Load**

*TODO: insert flow diagram*

## 1. Clone Repos and Generate Famix Models

Clone the GitHub repositories listed in `inputs-outputs/repos.txt` to `repos/`, generate a Famix TypeScript model for each and saving them to `inputs-outputs/models` (this also generates `inputs-outputs/models/repo_list.csv` containing the paths to each repository's source code and Famix model)::
```sh
./scripts/prepare_repos.sh -c repos -i ./inputs-outputs/repos.txt -o inputs-outputs/models
```

## 2. Generate Class Metrics
Open the Moose Playground with `Ctrl+O+W` and run the following script:
```st
| repoListFile metricsOutputFile |

repoListFile := '/home/school/MGL843/inputs-outputs/models/repo_list.csv' asFileReference.
metricsOutputFile := '/home/school/MGL843/inputs-outputs/metrics.csv' asFileReference.

"Remove all previously imported models"
MooseModel resetRoot.

"Imports models listed in repoListFile"
ClassMetricsCsvGenerator importFamixTypeScriptModels: repoListFile.

"Exports class metrics in CSV format to metricsOutputFile"
ClassMetricsCsvGenerator writeToFile: metricsOutputFile.
```

## 3. Get git logs
Save git logs of projects in `inputs-outputs/models/repo_list.csv` to `inputs-outputs/git_logs.txt` and parse them to `inputs-outputs/commits.csv`:
```sh
./scripts/get_git_logs.sh -i inputs-outputs/models/repo_list.csv -o inputs-outputs/git_logs.txt
python scripts/parse_git_logs.py -i inputs-outputs/git_logs.txt -o inputs-outputs/commits.csv
```

## 4. Analysis
Data analysis is in `notebooks/analysis.ipynb`.