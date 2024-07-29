# Source: myself (Charlotte Anning, 20150512)
# This PYTHON job script is used to create directorys for each of the branches with a customised control file, tree file and codon.nuc file

# For each header in numbered_headers.txt copy the 'blank/' directory and name as the header:

import os
import shutil

# Path to the headers file
headers_file_path = 'numbered_headers.txt'
# Path to the source directory to be copied
source_directory = 'blank/'

# Read the headers from the file
with open(headers_file_path, 'r') as file:
    headers = file.read().splitlines()

# Iterate through each header and copy the blank directory
for header in headers:
    # Define the target directory name
    target_directory = header
    
    # Check if the target directory already exists
    if not os.path.exists(target_directory):
        # Copy the directory
        shutil.copytree(source_directory, target_directory)
        print(f'Copied {source_directory} to {target_directory}')
    else:
        print(f'Target directory {target_directory} already exists, skipping...')

print('Directories copied.')

directories = [d for d in os.listdir() if os.path.isdir(d) and '_' in d]

# Edit the controlfile to have customised output file name

for directory in directories:
    controlfile_path = os.path.join(directory, 'controlfile.ctl')

    # Check if the controlfile.ctl exists
    if os.path.exists(controlfile_path):
        with open(controlfile_path, 'r') as file:
            lines = file.readlines()

        # Modify line 3 (2 in python) to an output file with the directory name
        if len(lines) >= 3:
            lines[2] = f"      outfile = {directory}.txt            * Path to the output file\n"

        # Write the modified lines back to controlfile.ctl
        with open(controlfile_path, 'w') as file:
            file.writelines(lines)
    else:
        print(f"controlfile.ctl not found in {directory}")

print('Operation completed.')
