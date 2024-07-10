# This script removes the text from the lines with numbered data and any tabs or spaces

sed -i '' 's/Complete BUSCOs (C)//g' temp2.txt
sed -i '' 's/Complete and single-copy BUSCOs (S)//g' temp2.txt
sed -i '' 's/Complete and duplicated BUSCOs (D)//g' temp2.txt
sed -i '' 's/Fragmented BUSCOs (F)//g' temp2.txt
sed -i '' 's/Missing BUSCOs (M)//g' temp2.txt
sed -i '' 's/Total BUSCO groups searched//g' temp2.txt
sed -i '' 's/Number of scaffolds//g' temp2.txt
sed -i '' 's/Number of contigs//g' temp2.txt
sed -i '' 's/Total length//g' temp2.txt
sed -i '' 's/Percent gaps//g' temp2.txt
sed -i '' 's/Scaffold N50//g' temp2.txt
sed -i '' 's/Contigs N50//g' temp2.txt
sed -i '' -e 's/[[:space:]]\{1,\}/ /g' -e 's/^ *//' -e 's/ *$//' temp2.txt

mv temp2.txt temp2.tsv