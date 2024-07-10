# This script executes the following scripts: busco_1_remove_lines.py, busco_2_remove_specaes.sh, busco_3_columns_to_rows.py and busco_4_add_headers.sh 

python3 busco_1_remove_lines.py

echo "python has removed unecessary lines"

chmod +x busco_2_remove_spaces.sh

./busco_2_remove_spaces.sh

echo "bash has removed spaces"

python3 busco_3_columns_to_rows.py

echo "python has converted data from columns to rows"

chmod +x busco_4_add_headers.sh

./busco_4_add_headers.sh

echo "all done!"