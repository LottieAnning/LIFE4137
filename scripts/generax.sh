#!/bin/bash

# Source: myself (Charlotte Anning, 20150512)
# This SLURM job script is used to submit a GENERAX job to the cluster.
# Replace [username] with your actual username.

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=50
#SBATCH --mem=100g
#SBATCH --time=10:00:00
#SBATCH --job-name=generax
#SBATCH --output=/gpfs01/home/[username]/slurm-%x-%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=[username]@exmail.nottingham.ac.uk

# Make a GeneRax directory:
mkdir GeneRax

# Change to the directory:
cd /home/[username]/GeneRax/

# Create an environment with correct versions for GeneRax:
conda create -n generax-env gcc_linux-64=9.3.0 gxx_linux-64=9.3.0 cmake=3.18.4 openmpi=4.0.5 -c conda-forge

# Activate said environment
conda activate generax-env

# Download from GitHub:
git clone --recursive https://github.com/BenoitMorel/GeneRax

# Build the sources
./install.sh

# Export generax to PATH:
export PATH=$PATH:~/GeneRax/build/bin

# Run the command
generax --families families.txt --species-tree eukarya.newick --rec-model UndatedDL --prefix generax --strategy EVAL

# Deactivate conda environment:
conda deactivate
