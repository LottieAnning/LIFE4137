# This script downloads and runs IQtree

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
iqtree -redo -s aa_alignment.aln -st AA -m MFP	# best model: Q.insect+I+G4

# deactivate conda environment
conda deactivate