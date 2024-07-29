# Source: myself (Charlotte Anning, 20150512)
# This PYTHON job script is used to add gene IDs for protien IDs in the blast output supplementary file 3

import csv
import re

def extract_gene_locus_tag(line):
    gene_match = re.search(r'\[gene=.*?\]', line)
    locus_tag_match = re.search(r'\[locus_tag=.*?\]', line)
    gene = gene_match.group(0) if gene_match else ""
    locus_tag = locus_tag_match.group(0) if locus_tag_match else ""
    return f"{gene} {locus_tag}".strip()

def search_protein_in_files(tsv_file, output_tsv):
    updated_rows = []

    with open(tsv_file, 'r') as file:
        reader = csv.reader(file, delimiter='\t')
        for row in reader:
            if len(row) < 2:
                row.append("No match")  # Append "No match" if there are not enough columns
                updated_rows.append(row)
                continue

            file_name = row[0] + ".fna"
            protein_id = row[1]
            match_found = False

            try:
                with open(file_name, 'r') as fna_file:
                    for line in fna_file:
                        if protein_id in line:
                            extracted_info = extract_gene_locus_tag(line)
                            if extracted_info:
                                row.append(extracted_info)
                                match_found = True
                                break  # Stop searching after the first match
                if not match_found:
                    row.append("No match")
            except FileNotFoundError:
                row.append("File not found")
            except Exception as e:
                row.append(f"Error: {e}")

            updated_rows.append(row)

    # Write the updated rows to the output TSV file
    with open(output_tsv, 'w', newline='') as file:
        writer = csv.writer(file, delimiter='\t')
        writer.writerows(updated_rows)

search_protein_in_files('blast_output.tsv', 'check_isoforms.tsv')
