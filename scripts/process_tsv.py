# Source: myself (Charlotte Anning, 20150512)
# This PYTHON job script is used to create the mapping.link file for GeneRax

import csv

# Function to process the input .tsv file and produce the desired output
def process_tsv(input_file, output_file):
    data = {}

    # Read the .tsv file
    with open(input_file, newline='') as tsvfile:
        reader = csv.reader(tsvfile, delimiter='\t')
        next(reader)  # Skip the header row
        for row in reader:
            species = row[0].replace('_', '').lower()
            identifier = row[1].replace('_', '')
            if species not in data:
                data[species] = []
            data[species].append(f"{identifier}_{species}")

    # Write the output to a new file
    with open(output_file, 'w') as outfile:
        for species, ids in data.items():
            outfile.write(f"{species}:{';'.join(ids)}\n")

# Define input and output file paths
input_file = 'supplementary_file_3.tsv'
output_file = 'mapping.link'

# Process the input file and generate the output file
process_tsv(input_file, output_file)
