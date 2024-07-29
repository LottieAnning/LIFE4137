#!/bin/bash

# Source: myself (Charlotte Anning, 20150512)
# This SLURM job script is used to submit a BLAST job to the cluster.
# Replace [username] with your actual username.

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100g
#SBATCH --time=1:00:00
#SBATCH --job-name=all_blast
#SBATCH --output=/gpfs01/home/[username]/slurm-%x-%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=[username]@exmail.nottingham.ac.uk

cd /gpfs01/home/[username]

# First, create a conda environment: 
conda create -n blast

# Finally, install the datasets conda package: 
conda install -c bioconda blast

# Create a reference fasta file:
## nano faa_files/reference.fasta

# Convert fasta file into a blast reference database:
makeblastdb -in faa_files/reference.fasta -dbtype prot -out reference_db

# Then, activate your new environment: 
source /gpfs01/home/[username]/miniconda3/etc/profile.d/conda.sh
conda activate blast

# Run the command 
# Iterate over each file in faa_files directory:
for file in faa_files/*.faa; do
    # Get the filename without extension
    filename=$(basename "$file" .faa)
    # Run BUSCO for the current file
    blastp -query "$file" -db faa_files/reference_db -outfmt 6 -evalue 1e-7 -out blast/blast_"$filename".tsv
done

conda deactivate

for file in blast/blast_*.tsv; do
    # Get the filename without extension
    filename=$(basename "$file" .tsv)
    # Remove blast_ prefix
    filename="${filename#blast_}"
    # Add the filename to the first column of the file
    awk -F'\t' -v OFS='\t' -v filename="$filename" '{print filename, $0}' "$file" > result_"$filename".tsv
done

# Merge all files to a combined results file
cat result_*.tsv > supplementary_file_3.tsv

# Add headers to file
headers="Species\tQuery sequence ID\tSubject sequence ID\tPercentage identity\tAlignment length\tNumber of mismatches\tNumber of gap openings\tStart of alignment in query\tEnd of alignment in query\tStart of alignment in subject\tEnd of alignment in subject\tE-value\tBit score"
file="supplementary_file_3.tsv"
echo -e "$headers\n$(cat "$file")" > temp_file && mv temp_file "$file"

