# LIFE4137

### This is the github page for my thesis titled "Understanding the Evolution of Control of Translation in Specialised Ribosomes: a Detailed Study of Ribosomal Protein S18", all scripts mentioned will be accomponied by instructions of what needs changing and how to execute them.

<img width="718" alt="pipeline_overview" src="https://github.com/user-attachments/assets/ed1d1407-65b8-4983-abb3-0a9388958de9">

## download_ncbi_databases.sh

Download the download_ncbi_databases.sh script from the scripts/ directory above. To repeat my data on a HPC simply change lines 10 and 43 to the location of your home directory and 12 to your email address, for the location of the standard output file, the directory in which you want the ncbi directories to be located and to recieve a notification when the script completes respectively. To execute the script first run ```sbatch download_ncbi_databases.sh```. If running as a bash script run: ```chmod +x download_ncbi_databases.sh``` then  ```./download_ncbi_databases.sh```. If using your own data, visit https://www.ncbi.nlm.nih.gov/datasets/genome/ and search for each of your species. Filter by: Reference genomes, Annotated genomes and Exclude atypical genomes. To retrive the download link, click on the name of the assembly, then datasets (see images below for more assisstance). Add this to the script and edit the '--include' flag to which files you require (I used '--include cds,protein,genome'), follow this by ```unzip ncbi_dataset.zip``` to unzip the file, then ```mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/[species_name].fna``` to move the genomic fna file to a directory containing all genomic fna files, then ```mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/[species_name].fna``` and ```mv ncbi_dataset/data/G*/protein.faa ../faa_files/[species_name].faa``` each time changing [species_name] to the species name of your choice, ```rm -rf ncbi_dataset```, then 'echo "\n\n[species common name] genome downloaded\n\n"' so you can check the progress in the slurm script. **Top Tip:** when searching for the next species in ncbi, type it into the search bar then remove the previous to keep the filters selected. 

<img width="1392" alt="Screenshot 2024-07-29 at 17 18 50" src="https://github.com/user-attachments/assets/2c4f8e9c-bc10-49a7-a519-402ea4e87730">

## all_busco.sh

Download the all_busco.sh script from the scripts/ directory above. Change the username on lines 10,12 and 15 for the slurm output file location, email address and directory in which the script operates. The name of the busco module on line 16 may also need to be edited, to search for your HPC's busco module use: ``` module avail busco```, if it is not listed create a conda environment: ```conda create -n busco_env -c conda-forge -c bioconda busco``` and activate the environment ```conda activate busco_env```. To execute the script on a HPC use ```sbatch all_busco.sh``` to execute as a bash script simply: ```chmod +x all_busco.sh``` then  ```./all_busco.sh```. This script will download the eukaryota_odb10 directory and run busco on all files in the genomic_fna_files/ directory. It will then produce an all.txt file which contains all the species busco results, which can be found in the supplementary files directory.

## busco_results.sh

Download the busco_1_remove_lines.py, busco_2_remove_specaes.sh, busco_3_columns_to_rows.py, busco_4_add_headers.sh and execute.sh scripts from the scripts/ directory above. These scripts will take the all.txt file produced by **all_busco.sh** and convert it to an easier to read .tsv file which can be viewed in excel. The file produced is called supplementary_file_2.tsv and can be found in the supplementary files directory. To run the above scripts use the **execute.sh** script by ```chmod +x busco_results.sh``` then ```./busco_results.sh```. Ensure all relevant files and scripts are in the directory you are working in. 

## all_blast.sh

Download the all_blast.sh script from the scripts/ directory and the reference.fasta file from the supplementary_files/ directory (this is the *Homo sapien* amino acid sequence for the RPS18 protien, downloaded from NCBI). This script will install blast, create a reference database with the reference.fasta file, run blast on all the species in the faa_files/ directory created earlier and create a merged file of all the data called supplementary_file_3.tsv (which can be found in the supplementary files directory). To execute this script either submit as a batch job (preferable): ```sbatch all_blast.sh``` or as a bash script ```chmod +x all_blast.sh``` then ```./all_blast.sh```.

## search_protein_ids.py

Download the search_protein_ids.py script from the scripts/ directory above. This script will take the blast output (supplementary_file_3.tsv) file created earlier and add a new column with gene ids. Execute this script in the cds_fna_files/ directory, with the supplementary_file_3.tsv file in it. To run the script simply use the ```python3 search_protein_ids.py``` command. The new file will be called check_isoforms.tsv (which can be found in the supplementary files directory). 

## create_all_nt_fasta.py

Download the create_all_nt_fasta.py script from the scripts/ directory above. This script will create a file called all_nt.fasta which contains all the nucleotide sequences for all the species, it will give each sequence a header in the format "proteinid_speciesname". To execute this script run ```python3 create_all_nt_fasta.py``` in the cds_fna_files/ directory created earlier and the blast output supplementary_file_3.tsv file (you may want to move or copy this file).

## trimal.sh

Download the trimal.sh script from the scripts/ directory above. This script will use homebrew to install Trimal and run the software on the msa_all_aa.aln and msa_all_nt.aln alignment files, producing aa_alignment.aln and nt_alignment.msa respectively.

## convert_to_codons.py

Download the convert_to_codons.py script from the scripts/ directory above. This script will take the fasta file that was produced earlier now called translatorx.fasta (which is the all_nt.fasta externally ran through translatorx), and seperated the nucleotides in groups of threes (aka codons). The file produced from this script is the codon.nuc file (which can be found in the supplementary files directory) which later used in PAML.

## create_all_aa_fasta.py

Download the create_all_aa_fasta.py script from the scripts/ directory above. This script will create a file called all_aa.fasta which contains all the amino acid sequences for all the species, it will give each sequence a header in the format "proteinid_speciesname". To execute this script run ```python3 create_all_aa_fasta.py``` in the faa_files/ directory created earlier and the blast output supplementary_file_3.tsv file (you may want to move or copy this file).

## process_tsv.py

Download the process_tsv.py script from the scripts/ directory above. This script will take supplementary_file_3.tsv file, produced earlier with the all_blast.sh script and create a new file 'mapping.link' for GeneRax. To execute this script run ```python3 process_tsv.py``` in the same directory as supplementary_file_3.tsv.

## iqtree.sh

Download the iqtree.sh script from the scripts/ directory above. This script will run IQtree on aa_alignment.aln (produced by the create_all_aa_fasta.py and trimal.sh scripts). The files produced from this are: aa_alignment.aln.bionj, aa_alignment.aln.ckp.gz, aa_alignment.aln.iqtree, aa_alignment.aln.log, aa_alignment.aln.mldist, aa_alignment.aln.model.gz, aa_alignment.aln.treefile, aa_alignment.aln.uniqueseq.phy. The tree file is the gene tree used for GeneRax, this needs to be renamed: ```mv aa_alignment.aln.treefile iqtree.newick```, this file can be found in the supplementary files directory above. To obtain the best fit model run ```grep "Best-fit model" aa_alignment.aln.log ```, in this case it was GTR+I+G.

## generax.sh

Download the generax.sh script from the scripts/ directory above. Change the username on lines 10,12 and 18 for the slurm output file location, email address and directory in which the script operates. This script also requires the files families.txt, eukarya.newick, iqtree.newick, mapping.link and nt_alignment.msa. As mentioned earlier, it used the best-fit model from IQtree (GTR+I+G). This run used a duplication and loss model, specified by the ```--rec-model UndatedDL``` parameter, to add horizontal gene transfers use ```--rec-model UndatedDTL```. The prefix is set to 'generax', so all files will be located in a directory called 'generax/', to change this change the ```--prefix generax``` parameter. The ```--strategy EVAL``` parameter specifies using the gene tree inference evaluation strategy to use for the inference. This produces the files and directories: fractionMissing.txt, gene_optimization_0/, generax.log, perSpeciesCoverage.txt, per_species_event_counts.txt, per_species_pair_transfers.txt, reconciliations/, results/, species_trees/, stats.txt. To obtain the reconciled gene tree upload the .nhx file from the reconciliations directory to the Notung software (use the Notung-2.9.1.5.zip download link on https://amberjack.compbio.cs.cmu.edu/Notung/download.html).

## create_branchsite_directories.py and create_null_branchsite_directories.py

First create a Paml directory by ```mkdir Paml```. To set up the paml environment, download the source files by running ```git clone https://github.com/abacus-gene/paml```, unzip the file ```gunzip paml-4.10.7-macosx-X86_64.tgz```, navigate to the src directory ```cd src```, in the Makefile file change 'icc' on line 2 to 'gcc' (can use ```nano Makefile``` to do this), then compile the program: ```make```, ```rm *.o```, ```mv baseml basemlg codeml pamp evolver yn00 chi2 ../bin```, ```../bin/codeml```. Make a new directory called Results/ by: ```mkdir Results```. Download the files headers.txt and null_headers.txt from the supplementary files directory along with the blank/ and null_blank directories. The blank/ and null_blank/ directories have the codon.nuc file, a tree.tree file which is the undated generax tree (with the number of species and trees on the first line) and a control file (blank with omega set to vary and null_blank assuming it wont). Execute the create_branchsite_directories.py and create_null_branchsite_directories.py (found in the scripts directory), by using ```python3 create_branchsite_directories.py``` and ```python3 create_null_branchsite_directories.py```, which will make directories and null directories for each of your species in the headers and null_headers texts files, adds a ' #1' to the tree file where the species is located (to tell Paml which branch to test) and edits the control files in each to have the output file in the directory name. 

## create_branch_directories.py 

The create_branch_directories.py script (found in the scripts directory), executes the same commands as the branch site scripts however the adding of the ' #1' has to be done manually. To execute the create_branch_directories.py script, download the numbered_headers.txt file and simply run ```python3 create_branch_directories.py``` in the same directory as the blank/ directory. This will create directories named 1-53 (Supplementary file 5 pertains the branches the numbers correspond to) with a codon.nuc file, control file with a directory specific text file and an un-tagged tree file. Now add the ' #1' to each of the tree files at the branch the directory relates to. Unlike the branch site the branch tree needs 3 ' #1's added, one outside the bracket encompassing the species and one outside the bracket or species the branch encompasses. Below is a simple example: 

<img width="775" alt="Screenshot 2024-07-30 at 17 02 31" src="https://github.com/user-attachments/assets/90312d54-a304-43e6-8883-dfd1b6b0854d">

## copy_to_null.py

Download the copy_to_null.py script from the scripts directory above. Execute by: ```python3 copy_to_null.py``` in the directory with directories 'branch_1' to 'branch_53'. This will create null directories with the same tree.trees file, but edits the control file to have the correct output file name and changes omega not to vary.

## make_scripts.py and submit.sh

Make a scripts directory by ```mkdir ../scripts``` (this should mean the scripts directory is directly under the Paml/ directory), download the all_headers.txt file and execute the make_scripts.py script (found in the scripts directory) from there, changing the username on lines 16,18 and 20 to match yours. To execute use: ```python3 make_scripts.py```. Submit these as sbatch jobs with the submit.sh script (found in the scripts directory), by using ```chmod +x submit.sh``` and ```./submit.sh``` and leave these running. This has just submitted 214 jobs. You can check the status of the scripts by using ```squeue -u [username] -o "%.18i %.10P %.30j %.8u %.8T %.10M %.10l %.6D %.15R"``` which will display in long format.

## create_paml_results_tsv.sh

Download the create_paml_results_tsv.sh script from the scripts directory above. Execute this script in the Paml directory created earlier with the 214 directories, this will take all the logarithm of the Liklihood (lnL) values of the parameter and null tests and run a liklihood ratio test, chi-squared test and false discovery rate test (FDR). To execute this script add executive permissions ```chmod +x create_paml_results_tsv.sh``` and run ```./create_paml_results_tsv.sh```. This requires some manual editing in Excel, instructions in the script. This produces supplementary file 4.

## pymol.sh

Follow the instructions in this script to observe the RPS18 protein in the ribosome structure and colour by charge. 

# ```print('All Done!!')```

