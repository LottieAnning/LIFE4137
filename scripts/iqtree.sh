#!/bin/bash

# Source: myself (Charlotte Anning, 20150512)
# This SLURM job script is used to submit an IQTREE job to the cluster.
# Replace [username] with your actual username.

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100g
#SBATCH --time=2:00:00
#SBATCH --job-name=iqtree
#SBATCH --output=/gpfs01/home/[username]/slurm-%x-%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=[username]@exmail.nottingham.ac.uk

# First create the files to run iqtree on:
# With the file all_aa.fasta (created by compiling all the amino acid sequences from the faa files), upload to MAFFT and trim with TRIMAL

# Create conda environment:
conda create -n iqtree_env python=3.8

# Activate environment:
conda activate iqtree_env

# Configure environment and install iqtree:
conda config --add channels conda-forge
conda config --add channels bioconda
conda install iqtree

# Check the version of iqtree:
iqtree -v

# Run iqtree to search for the best tree model and run it:
iqtree -redo -s aa_alignment.aln -st AA -m MFP

# deactivate conda environment
conda deactivate
