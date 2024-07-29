#!/bin/bash

# Source: myself (Charlotte Anning, 20150512)
# This SLURM job script is used to submit a NCBI dataset squisition job to the cluster.
# Replace [username] with your actual username.

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100g
#SBATCH --time=5:00:00
#SBATCH --job-name=download_ncbi_databases
#SBATCH --output=/gpfs01/home/[username]/slurm-%x-%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=[username]@exmail.nottingham.ac.uk

# This script will download all the genomes, protein and coding files of the animals, fungi, plants and unicellular eukarya you specify 
# It will download these files into the relative kingdom directories
# To execute the script first run ```sbatch download_ncbi_databases.sh```

# Download the data sets for the pre determined species https://www.ncbi.nlm.nih.gov/datasets/genome/
# Filter by: 
# Reference genomes
# Annotated genomes
	# Annotated by NCBI RefSeq
	# Annotated by GenBank submitter
# Exclude atypical genomes

# First, create a conda environment: 

conda create -n ncbi_datasets

# Then, activate your new environment: 

conda activate ncbi_datasets

# Finally, install the datasets conda package: 

conda install -c conda-forge ncbi-datasets-cli


##################################
######### Animal Kingdom #########
##################################

cd /home/[username]
mkdir genomic_fna_files
mkdir cds_fna_files
mkdir faa_files
mkdir animalia
cd animalia

# Homo sapien
datasets download genome accession GCF_000001405.40 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/homo_sapien.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/homo_sapien.fna
mv ncbi_dataset/data/G*/protein.faa ../faa_files/homo_sapien.faa
rm -rf ncbi_dataset
echo "\n\nhuman genome downloaded\n\n"

# Mus musculus
datasets download genome accession GCF_000001635.27 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/mus_musculus.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/mus_musculus.fna
mv ncbi_dataset/data/G*/protein.faa ../faa_files/mus_musculus.faa
rm -rf ncbi_dataset
echo "\n\nmouse genome downloaded\n\n"

# Danio rerio
datasets download genome accession GCF_000002035.6 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/danio_rerio.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/danio_rerio.fna
mv ncbi_dataset/data/G*/protein.faa ../faa_files/danio_rerio.faa
rm -rf ncbi_dataset
echo "\n\nzebra fish genome downloaded\n\n"

# Drosophila melanogaster 
datasets download genome accession GCF_000001215.4 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/drosophila_melanogaster.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/drosophila_melanogaster.fna
mv ncbi_dataset/data/G*/protein.faa ../faa_files/drosophila_melanogaster.faa
rm -rf ncbi_dataset
echo "\n\nfly genome downloaded\n\n"

# Caenorhabditis elegans
datasets download genome accession GCF_000002985.6 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/caenorhabditis_elegans.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/caenorhabditis_elegans.fna
mv ncbi_dataset/data/G*/protein.faa ../faa_files/caenorhabditis_elegans.faa
rm -rf ncbi_dataset
echo "\n\nroundworm genome downloaded\n\n"

# Scylla paramamosain
datasets download genome accession GCF_035594125.1 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/scylla_paramamosain.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/scylla_paramamosain.fna
mv ncbi_dataset/data/G*/protein.faa ../faa_files/scylla_paramamosain.faa
rm -rf ncbi_dataset
echo "\n\ncrab genome downloaded\n\n"

# Xenopus laevis
datasets download genome accession GCF_017654675.1 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/xenopus_laevis.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/xenopus_laevis.fna
mv ncbi_dataset/data/G*/protein.faa ../faa_files/xenopus_laevis.faa
rm -rf ncbi_dataset
echo "\n\nfrog genome downloaded\n\n"

# Octopus sinensis 
datasets download genome accession GCF_006345805.1 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/octopus_sinensis.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/octopus_sinensis.fna
mv ncbi_dataset/data/G*/protein.faa ../faa_files/octopus_sinensis.faa
rm -rf ncbi_dataset
echo "\n\noctopus genome downloaded\n\n"

# Hydractinia symbiolongicarpus
datasets download genome accession GCF_029227915.1 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/hydractinia_symbiolongicarpus.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/hydractinia_symbiolongicarpus.fna
mv ncbi_dataset/data/G*/protein.faa ../faa_files/hydractinia_symbiolongicarpus.faa
rm -rf ncbi_dataset
echo "\n\nsnail fur genome downloaded\n\n"

# Corticium candelabrum
datasets download genome accession GCF_963422355.1 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/corticium_candelabrum.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/corticium_candelabrum.fna
mv ncbi_dataset/data/G*/protein.faa ../faa_files/corticium_candelabrum.faa
rm -rf ncbi_dataset
echo "\n\nsponge genome downloaded\n\n"

rm -f ncbi_dataset.zip
cd ../

###################################
########## Fungi Kingdom ##########
###################################

mkdir fungi
cd fungi

# Kwoniella botswanensis (Basidiomycota)
datasets download genome accession GCF_036426115.1 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/kwoniella_botswanensis.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/kwoniella_botswanensis.fna
mv ncbi_dataset/data/G*/protein.faa ../faa_files/kwoniella_botswanensis.faa
rm -rf ncbi_dataset
echo "\n\ngenome downloaded\n\n"

# Mycena venus (Basidiomycota)
datasets download genome accession GCA_014462655.1 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/mycena_venus.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/mycena_venus.fna
mv ncbi_dataset/data/G*/protein.faa ../faa_files/mycena_venus.faa
rm -rf ncbi_dataset
echo "\n\nmushroom genome downloaded\n\n"

# Vanrija pseudolonga
datasets download genome accession GCF_020906515.1 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/vanrija_pseudolonga.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/vanrija_pseudolonga.fna
mv ncbi_dataset/data/G*/protein.faa ../faa_files/vanrija_pseudolonga.faa
rm -rf ncbi_dataset
echo "\n\ngenome downloaded\n\n"

# Mycena sanguinolenta (Basidiomycota)
datasets download genome accession GCA_014462675.1 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/mycena_sanguinolenta.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/mycena_sanguinolenta.fna
mv ncbi_dataset/data/G*/protein.faa ../faa_files/mycena_sanguinolenta.faa
rm -rf ncbi_dataset
echo "\n\nbleeding bonnet genome downloaded\n\n"

# Saccharomyces cerevisiae S288C (Ascomycota)
datasets download genome accession GCF_000146045.2 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/saccharomyces_cerevisiae.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/saccharomyces_cerevisiae.fna
mv ncbi_dataset/data/G*/protein.faa ../faa_files/saccharomyces_cerevisiae.faa
rm -rf ncbi_dataset
echo "\n\nyeast genome downloaded\n\n"

# Neurospora tetraspora (Ascomycota)
datasets download genome accession GCF_033439725.1 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/neurospora_tetraspora.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/neurospora_tetraspora.fna
mv ncbi_dataset/data/G*/protein.faa ../faa_files/neurospora_tetraspora.faa
rm -rf ncbi_dataset
echo "\n\nmushroom genome downloaded\n\n"

# Candida auris (Ascomycota)
datasets download genome accession GCF_003013715.1 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/candida_auris.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/candida_auris.fna
mv ncbi_dataset/data/G*/protein.faa ../faa_files/candida_auris.faa
rm -rf ncbi_dataset
echo "\n\nyeast genome downloaded\n\n"

# Bombardia bombarda (Ascomycota)
datasets download genome accession GCA_030512295.1 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/bombardia_bombarda.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/bombardia_bombarda.fna
mv ncbi_dataset/data/G*/protein.faa ../faa_files/bombardia_bombarda.faa
rm -rf ncbi_dataset
echo "\n\ngenome downloaded\n\n"

# Podospora appendiculata (Ascomycota)
datasets download genome accession GCA_033675105.1 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/podospora_appendiculata.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/podospora_appendiculata.fna
mv ncbi_dataset/data/G*/protein.faa ../faa_files/podospora_appendiculata.faa
rm -rf ncbi_dataset
echo "coprophilous fungus genome downloaded"

# Rhizophagus clarus (glomeromycotina)
datasets download genome accession GCA_015698045.1 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/rhizophagus_clarus.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/rhizophagus_clarus.fna
mv ncbi_dataset/data/G*/protein.faa ../faa_files/rhizophagus_clarus.faa
rm -rf ncbi_dataset
echo "spearmint genome downloaded"

rm -f ncbi_dataset.zip
cd ../

###################################
########## Plant Kingdom ##########
###################################

mkdir plantae
cd plantae

# Arabidopsis thaliana (angiosperm)
datasets download genome accession GCF_000001735.4 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/arabidopsis_thaliana.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/arabidopsis_thaliana.fna
mv ncbi_dataset/data/G*/protein.faa ../faa_files/arabidopsis_thaliana.faa
rm -rf ncbi_dataset
echo "\n\nthale cress genome downloaded\n\n"

# Theobroma cacao (angiosperm)
datasets download genome accession GCF_000208745.1 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/theobroma_cacao.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/theobroma_cacao.fna
mv ncbi_dataset/data/G*/protein.faa ../faa_files/theobroma_cacao.faa
rm -rf ncbi_dataset
echo "\n\ncoco genome downloaded\n\n"

# Glycine max (angiosperm)
datasets download genome accession GCF_000004515.6 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/glycine_max.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/glycine_max.fna
mv ncbi_dataset/data/G*/protein.faa ../faa_files/glycine_max.faa
rm -rf ncbi_dataset
echo "\n\nsoy bean genome downloaded\n\n"

# Zea mays (angiosperm)
datasets download genome accession GCF_902167145.1 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/zea_mays.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/zea_mays.fna
mv ncbi_dataset/data/G*/protein.faa ../faa_files/zea_mays.faa
rm -rf ncbi_dataset
echo "\n\corn genome downloaded\n\n"

# Physcomitrium patens (moss)
datasets download genome accession GCF_000002425.4 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/physcomitrium_patens.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/physcomitrium_patens.fna
mv ncbi_dataset/data/G*/protein.faa ../cds_fna_files/physcomitrium_patens.faa
rm -rf ncbi_dataset
echo "\n\nearthmoss genome downloaded\n\n"

# Sphagnum fallax
datasets download genome accession GCA_021442195.1 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/sphagnum_fallax.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/sphagnum_fallax.fna
mv ncbi_dataset/data/G*/protein.faa ../faa_files/sphagnum_fallax.faa
rm -rf ncbi_dataset
echo "\n\bogmoss genome downloaded\n\n"

# Marchantia polymorpha subsp. ruderalis (liverwort)
datasets download genome accession GCA_037833965.1 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/marchantia_polymorpha.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/marchantia_polymorpha.fna
mv ncbi_dataset/data/G*/protein.faa ../faa_files/marchantia_polymorpha.faa
rm -rf ncbi_dataset
echo "\n\numbrella liverwort genome downloaded\n\n"

# Klebsormidium nitens (klebsormidiales)
datasets download genome accession GCA_000708835.1 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/klebsormidium_nitens.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/klebsormidium_nitens.fna
mv ncbi_dataset/data/G*/protein.faa ../faa_files/klebsormidium_nitens.faa
rm -rf ncbi_dataset
echo "\n\ncharophyte genome downloaded\n\n"

# Micromonas commoda 
datasets download genome accession GCF_000090985.2 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/micromonas_commoda.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/micromonas_commoda.fna
mv ncbi_dataset/data/G*/protein.faa ../faa_files/micromonas_commoda.faa
rm -rf ncbi_dataset
echo "\n\npicophytoplankton genome downloaded\n\n"

# Cyanidioschyzon merolae strain 10D (red algae)
datasets download genome accession GCF_000091205.1 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/cyanidioschyzon_merolae.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/cyanidioschyzon_merolae.fna
mv ncbi_dataset/data/G*/protein.faa ../faa_files/cyanidioschyzon_merolae.faa
rm -rf ncbi_dataset
echo "\n\nred algae genome downloaded\n\n"

cd ../

###################################
####### Unicellular Eukarya #######
###################################

mkdir unicellular_eukarya
cd unicellular_eukarya

# Tetrahymena thermophila SB210
datasets download genome accession GCF_000189635.1 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/tetrahymena_thermophila.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/tetrahymena_thermophila.fna
mv ncbi_dataset/data/G*/protein.faa ../faa_files/tetrahymena_thermophila.faa
rm -rf ncbi_dataset
echo "\n\ngenome downloaded\n\n"

# Giardia intestinalis
datasets download genome accession GCF_000002435.2 --include cds,protein,genome
unzip ncbi_dataset.zip 
mv ncbi_dataset/data/G*/G*_genomic.fna ../genomic_fna_files/giardia_intestinalis.fna
mv ncbi_dataset/data/G*/cds_from_genomic.fna ../cds_fna_files/giardia_intestinalis.fna
mv ncbi_dataset/data/G*/protein.faa ../faa_files/giardia_intestinalis.faa
rm -rf ncbi_dataset
echo "beaver fever genome downloaded"

echo "downloads complete!"
conda deactivate
