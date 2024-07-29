#!/bin/bash

# Source: myself (Charlotte Anning, 20150512)
# This SLURM job script is used to submit all PAML scripts to the cluster.

# Loop through each script file matching the pattern '*.sh'
for script in *.sh; do
  echo "Submitting $script"
  sbatch "$script"
done
