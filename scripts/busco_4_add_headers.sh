# Add headers to file
headers="Species\tComplete BUSCOs\tComplete and single-copy BUSCOs\tComplete and duplicated BUSCOs\tFragmented BUSCOs\tMissing BUSCOs\tTotal BUSCO groups searched\tNumber of scaffolds\tNumber of contigs\tTotal length\tPercent gaps\tScaffold N50\tContigs N50"
file="supplementary_file_2.tsv"
echo -e "$headers\n$(cat "$file")" > temp_file && mv temp_file "$file"
