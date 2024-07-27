import csv

def search_protein_sequences(tsv_file, output_file):
    with open(output_file, 'w') as output:
        with open(tsv_file, 'r') as file:
            reader = csv.reader(file, delimiter='\t')
            next(reader)  # Skip the header row
            for row in reader:
                if len(row) < 2:
                    continue  # Skip rows that do not have at least two columns
                file_name = row[0] + ".fna"
                species_name = row[0].replace('_', '')
                protein_id = row[1]
                no_underscores_or_fullstops_protien_id = row[1].replace('_', '').replace('.', '')
                sequence_found = False

                try:
                    with open(file_name, 'r') as fna_file:
                        write_sequence = False
                        sequence_lines = []

                        for line in fna_file:
                            if line.startswith('>'):
                                if write_sequence:
                                    # Write the collected sequence to the output file
                                    output.write(f">{no_underscores_or_fullstops_protien_id}_{species_name}\n" + ''.join(sequence_lines) + '\n')
                                    sequence_found = True
                                    break  # Stop searching after finding the sequence

                                # Check if this header contains the protein ID
                                write_sequence = protein_id in line
                                sequence_lines = []  # Reset sequence lines

                            elif write_sequence:
                                sequence_lines.append(line.strip())

                    if not sequence_found:
                        output.write(f"{species_name} \nNo sequence found\n")

                except FileNotFoundError:
                    output.write(f"{species_name}\nFile not found\n")
                except Exception as e:
                    output.write(f"{species_name}\nError: {e}\n")

search_protein_sequences('blast_output.tsv', 'all_nt.fasta')
