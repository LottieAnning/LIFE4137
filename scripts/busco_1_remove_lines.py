# Source: myself (Charlotte Anning, 20150512)
# This PYTHON job script is used to remove unecessary characters from the BUSCO output.

# First move to the busco directory where the all.txt file should be.

# Remove unecessary lines:
def process_file(input_file, output_file):
    lines_to_remove = {1, 2, 4, 5, 6, 7, 8, 9, 16, 17} | set(range(24, 31))
    pattern_length = 30
    
    with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
        for line_number, line in enumerate(infile, start=1):
            if (line_number - 1) % pattern_length + 1 not in lines_to_remove:
                outfile.write(line)

input_file = 'all.txt'
output_file = 'temp.txt'
process_file(input_file, output_file)

# Now make every 13th line, starting from line 1, just include the species name:
import re

def process_file(input_file, output_file):
    pattern = re.compile(r'# Summarized benchmarking in BUSCO notation for file .*/(.+)\.fna')
    lines_to_modify = {1 + i*13 for i in range(1000)}  # Adjust the range if you have more lines in your file

    with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
        for line_number, line in enumerate(infile, start=1):
            if line_number in lines_to_modify:
                match = pattern.match(line.strip())
                if match:
                    new_line = f"{match.group(1)}\n"
                    outfile.write(new_line)
                else:
                    outfile.write(line)
            else:
                outfile.write(line)

input_file = 'temp.txt'
output_file = 'temp2.txt'
process_file(input_file, output_file)

# Now run busco_2_remove_spaces.sh to remove all other unecessary text and tabs/spaces
