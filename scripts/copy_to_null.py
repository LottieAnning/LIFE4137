import os
import shutil

# Function to copy directory and modify controlfile.ctl
def copy_and_modify_dir(src_dir, dest_dir):
    # Copy the directory
    shutil.copytree(src_dir, dest_dir)

    # Path to the controlfile.ctl in the destination directory
    ctl_file_path = os.path.join(dest_dir, 'controlfile.ctl')

    # Read the controlfile.ctl
    with open(ctl_file_path, 'r') as file:
        lines = file.readlines()

    # Modify lines 3, 17 and 18 (2, 16 and 17 in python)
    lines[2] = '      outfile = '+f'null_branch_{i}.txt'+'            * Path to the output file'
    lines[16] = '    fix_omega = 1         * Estimate or fix omega\n'
    lines[17] = '        omega = 1        * Initial or fixed omega\n'

    # Write the modified lines back to the controlfile.ctl
    with open(ctl_file_path, 'w') as file:
        file.writelines(lines)

# Base directory path
base_dir = ''

# Iterate over directories 1 to 53
for i in range(1, 54):
    src_dir = os.path.join(base_dir, f'branch_{i}')
    dest_dir = os.path.join(base_dir, f'null_branch_{i}')

    # Check if source directory exists
    if os.path.exists(src_dir):
        copy_and_modify_dir(src_dir, dest_dir)
        print(f'Copied and modified {src_dir} to {dest_dir}')
    else:
        print(f'Source directory {src_dir} does not exist')

print('Task completed.')

