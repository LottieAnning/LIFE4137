# Source: myself (Charlotte Anning, 20150512)
# This SHELL job script describes how to view the RPS18 protein in PYMOL

# Download Mouse Kidney Ribosome from: https://www.rcsb.org/structure/7CPU
# Load into Pymol

# To only look at the protein structure run:
select protein_only, polymer.protein
hide everything
show cartoon, protein_only

# To colour by hydrophobicity run the color_h.py script created by Sian:
run color_h.py
color_h all

# To find the protein you want in the pdb file, e.g. protein RPS18, first search for the protein name which will be in this format:
58 polymer     nat '40S ribosomal protein S18'                17759.777   1   ?         ? ? ? 
# Note the number of the protein, in this case '58'
# Then find the section in the following format, where the first 58 corresponds to the protein you are after
# 'SS' is the chain the protein is on
# This protein is 1-152 amino acids long, as shown by the numbers in the third column
FB 58 1    MET 1    1    ?    ?   ?   SS . n 
FB 58 2    SER 2    2    2    SER SER SS . n 
FB 58 3    LEU 3    3    3    LEU LEU SS . n 
...
FB 58 150  LYS 150  150  ?    ?   ?   SS . n 
FB 58 151  LYS 151  151  ?    ?   ?   SS . n 
FB 58 152  LYS 152  152  ?    ?   ?   SS . n 

# To select RPS18:
select chain SS and resi 1-152
set_name sele,RpS18 				# Now use the executive command in Pymol to colour green

# To select areas under strong positive selection, first work out from supplementary file 6 what number amino acid the codon pertains to in the amino acid sequence by removing gaps 
select chain SS and resi 1+5+7+10+12+13+16+78
set_name sele,strong_pos_sele		# Now use the executive command in Pymol to colour blue
