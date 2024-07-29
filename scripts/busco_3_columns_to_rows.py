# Source: myself (Charlotte Anning, 20150512)
# This PYTHON job script is used to swap data in columns to rows, every 13th line

input_file = 'temp2.tsv'
output_file = 'supplementary_file_2.tsv'
chunk_size = 13

def combine_lines(lines, chunk_size):
    for i in range(0, len(lines), chunk_size):
        yield '\t'.join(line.strip() for line in lines[i:i+chunk_size])

# Read the input file
with open(input_file, 'r') as file:
    lines = file.readlines()

# Combine lines in chunks
combined_lines = list(combine_lines(lines, chunk_size))

# Write the output to a new file
with open(output_file, 'w') as file:
    file.write('\n'.join(combined_lines) + '\n')

# Now run busco_4_add_headers.sh
