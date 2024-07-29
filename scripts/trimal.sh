# Source: myself (Charlotte Anning, 20150512)
# This SHELL job script is used to prepare data for IQtree and GeneRax and produces the alignment files aa_alignment.aln and nt_alignment.msa.

# On a macOS or Linux system, install trimal with the following command:
brew install trimal

# This may require the downloading of Homebrew:
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Or the updating of HomeBrew
brew update

# Run trimal with gappy out to remove columns with gaps:

## For the IQtree alignment file, enter the following into the command line:
trimal -in msa_all_aa.aln -out aa_alignment.aln -gappyout

## For the GeneRax alignment file, enter the following into the command line:
trimal -in msa_all_nt.aln -out nt_alignment.msa -gappyout
