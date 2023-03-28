import argparse

parser = argparse.ArgumentParser()
parser.add_argument('-i', type=str)
parser.add_argument('-o', type=str)

args = parser.parse_args()

git_logs_path = args.i
output_path   = args.o

output_content = "PathFile,Commit hash,Commit timestamp,Subject\n"
with open(git_logs_path, "r") as log_file:

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

with open(output_path, "w") as output_file:
    output_file.write(output_content)