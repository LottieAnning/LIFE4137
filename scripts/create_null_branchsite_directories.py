# Source: myself (Charlotte Anning, 20150512)
# This PYTHON job script is used to creates null directorys for each of the species with a customised control file, customsied tree file and codon.nuc file

# For each header in null_headers.txt copy the 'null_blank/' directory and name as the header:

import os
import shutil

# Path to the headers file
headers_file_path = 'null_headers.txt'
# Path to the source directory to be copied
source_directory = 'null_blank/'

# Read the headers from the file
with open(headers_file_path, 'r') as file:
    headers = file.read().splitlines()

# Iterate through each header and copy the null_blank directory
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

# Now edit control and trees files

directories = [d for d in os.listdir() if os.path.isdir(d) and '_' in d]

for directory in directories:
    controlfile_path = os.path.join(directory, 'controlfile.ctl')
    treefile_path = os.path.join(directory, 'tree.trees')

    # Check if the controlfile.ctl exists
    if os.path.exists(controlfile_path):
        with open(controlfile_path, 'r') as file:
            lines = file.readlines()

        # Modify line 3 to an output file with the directory name
        if len(lines) >= 3:
            lines[2] = f"      outfile = {directory}.txt            * Path to the output file\n"

        # Write the modified lines back to controlfile.ctl
        with open(controlfile_path, 'w') as file:
            file.writelines(lines)
    else:
        print(f"controlfile.ctl not found in {directory}")

    # Add a #1 where the branch occurs in tree.trees and save it in the same directory
    if os.path.exists(treefile_path):
        with open(treefile_path, 'r') as file:
            tree_lines = file.read()
        dir_name = directory.replace("null_", "")
        new_data = tree_lines.replace(dir_name, dir_name + " #1")
        with open(treefile_path, 'w') as file:
            file.write(new_data)
    else:
        print(f"{treefile_path} does not exist")

print('Operation completed.')
