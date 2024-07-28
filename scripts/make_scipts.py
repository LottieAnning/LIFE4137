headers_file_path = '../headers.txt'

# Read the headers from the file headers file as directories
with open(headers_file_path, 'r') as file:
    directories = file.read().splitlines()

template = """#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100g
#SBATCH --time=4:00:00
#SBATCH --job-name={directory_name}_paml
#SBATCH --output=/gpfs01/home/[username]/slurm-%x-%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=[username]@exmail.nottingham.ac.uk

cd /home/[username]/Paml/{directory_name}
../bin/codeml controlfile.ctl
"""

for directory in directories:
    script_content = template.format(directory_name=directory)
    script_filename = f"{directory}.sh"
    with open(script_filename, "w") as script_file:
        script_file.write(script_content)