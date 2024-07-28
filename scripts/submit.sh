#!/bin/bash

# Loop through each script file matching the pattern '*.sh'
for script in *.sh; do
  echo "Submitting $script"
  sbatch "$script"
done
