#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100g
#SBATCH --time=2:00:00
#SBATCH --job-name=all_busco
#SBATCH --output=/gpfs01/home/[username]/slurm-%x-%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=[username]@exmail.nottingham.ac.uk

export NUMEXPR_MAX_THREADS=50                     # optimise speed of job
cd /home/[username]                                 #change to your home directory
module load busco-uoneasy/5.4.7-foss-2023a              #load the busco module

# download the lineages file to the enivornment:
busco --download eukaryota_odb10

# iterate over each file in fna_files directory
for file in genomic_fna_files/*.fna; do
    # Get the filename without extension
    filename=$(basename "$file" .fna)
    # Run BUSCO for the current file
    busco -i "$file" -m genome -l eukaryota_odb10 -o busco/busco_"$filename" -c 50
done

# Create a merged file of all the data
cd busco
cat busco_*/short_summary.specific.eukaryota_odb10.busco_*.txt > all.txt
