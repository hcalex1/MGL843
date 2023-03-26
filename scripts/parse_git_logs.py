GIT_LOGS_PATH = "./inputs-outputs/git_logs.txt"
OUTPUT_PATH   = "./inputs-outputs/commits.csv"

output_content = "PathFile,Commit hash,Commit timestamp,Subject\n"
with open(GIT_LOGS_PATH, "r") as log_file:

    for line in log_file:
        key   = line[0]
        value = line[2:-1]

        if key == 'H':
            hash = value
        elif key == 'T':
            timestamp = value
        elif key == 'S':
            subject = value.replace(',', ';')
        elif key == 'M':
            output_content += f"{value},{hash},{timestamp},{subject}\n"

with open(OUTPUT_PATH, "w") as output_file:
    output_file.write(output_content)