# LIFE4137

## This is the github page for my thesis titled "...", all scripts mentioned will be accomponied by instructions of what needs changing and how to execute them

## download_ncbi_databases.sh

Download the download_ncbi_databases.sh script from the scripts/ directory above. To repeat my data on a HPC simply change lines 10 and 43 to the location of your home directory and 12 to your email address, for the location of the standard output file, the directory in which you want the ncbi directories to be located and to recieve a notification when the script completes respectively. To execute the script first run ```sbatch download_ncbi_databases.sh```. If running as a bash script run: ```chmod +x download_ncbi_databases.sh``` then  ```./download_ncbi_databases.sh```. If using your own data, visit https://www.ncbi.nlm.nih.gov/datasets/genome/ and search for each of your species. Filter by: Reference genomes, Annotated genomes and Exclude atypical genomes. To retrive the download link, click on the name of the assembly, then datasets (see images below for more assisstance). Add this to the script and edit the '--include' flag to which files you require (I used '--include cds,protein,genome'), follow this by ```unzip ncbi_dataset.zip``` to unzip the file, then ```mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/[species_name].fna``` to move the genomic fna file to a directory containing all genomic fna files, then ```mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/[species_name].fna``` and ```mv ncbi_dataset/data/G*/protein.faa ../faa_files/[species_name].faa``` each time changing [species_name] to the species name of your choice, ```rm -rf ncbi_dataset```, then 'echo "\n\n[species common name] genome downloaded\n\n"' so you can check the progress in the slurm script. **Top Tip:** when searching for the next species in ncbi, type it into the search bar then remove the previous to keep the filters selected. 

## all_busco.sh

Download the all_busco.sh script from the scripts/ directory above. Change the username on lines 10,12 and 15 for the slurm output file location, email address and directory in which the script operates. The name of the busco module on line 16 may also need to be edited, to search for your HPC's busco module use: ``` module avail busco```, if it is not listed create a conda environment: ```conda create -n busco_env -c conda-forge -c bioconda busco``` and activate the environment ```conda activate busco_env```. To execute the script on a HPC use ```sbatch all_busco.sh``` to execute as a bash script simply: ```chmod +x all_busco.sh``` then  ```./all_busco.sh```. This script will download the eukaryota_odb10 directory and run busco on all files in the genomic_fna_files/ directory. It will then produce an all.txt file which contains all the species busco results, which can be found in the supplementary files directory.

## busco_1_remove_lines.py, busco_2_remove_specaes.sh, busco_3_columns_to_rows.py and busco_4_add_headers.sh 

These files will take the all.txt file produced by **all_busco.sh** and convert it to an easier to read .tsv file which can be viewed in excel. The file produced is called all_busco.tsv and can be found in the supplementary files directory. To run the above scripts use the **execute.sh** script by ```chmod +x execute.sh``` then ```./execute.sh```. Ensure all relevant files and scripts are in the directory you are working in. 

## all_blast.sh

Download the all_blast.sh script from the scripts/ directory and the reference.fasta file from the supplementary_files/ directory. This script will install blast, create a reference database with the reference.fasta file, run blast on all the species in the faa_files/ directory created earlier and create a merged file of all the data called blast_output.tsv (which can be found in the supplementary files directory). To execute this script either submit as a batch job (preferable): ```sbatch all_blast.sh``` or as a bash script ```chmod +x all_blast.sh``` then ```./all_blast.sh```.

## search_protein_ids.py

Download the search_protein_ids.py script from the scripts/ directory above. This script will take the blast_output.tsv file created earlier and add a new column with gene ids. Execute this script in the cds_fna_files/ directory, with the blast_output.tsv file in it. To run the script simply use the ```python3 search_protein_ids.py``` command. The new file will be called check_isoforms.tsv.

## create_all_nt_fasta.py

Download the create_all_nt_fasta.py script from the scripts/ directory above. This script will create a file called all_nt.fasta which contains all the nucleotide sequences for all the species, it will give each sequence a header in the format "proteinid_speciesname". To execute this script run ```python3 create_all_nt_fasta.py``` in the cds_fna_files/ directory created earlier and the blast_output.tsv file (you may want to move or copy this file).

## create_all_aa_fasta.py

Download the create_all_aa_fasta.py script from the scripts/ directory above. This script will create a file called all_aa.fasta which contains all the amino acid sequences for all the species, it will give each sequence a header in the format "proteinid_speciesname". To execute this script run ```python3 create_all_aa_fasta.py``` in the faa_files/ directory created earlier and the blast_output.tsv file (you may want to move or copy this file).
