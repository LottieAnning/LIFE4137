def process_file(input_file, output_file):
    with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
        for line in infile:
            if line.startswith('>'):
                outfile.write(line)
            else:
                # Remove any trailing newlines or spaces
                line = line.strip()
                # Split line into chunks of 3 characters
                spaced_line = ' '.join([line[i:i+3] for i in range(0, len(line), 3)])
                # Write the modified line to the output file
                outfile.write(spaced_line + '\n')

input_file = 'translatorx.fasta'
output_file = 'codon.nuc'
process_file(input_file, output_file)
