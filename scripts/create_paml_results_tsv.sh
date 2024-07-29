# This script will take only the site/branch name and lnL value from the PAML output files and put them into one tsv which can then be edited to retrieve results (supplementary file 4)

grep -r "lnL" ./ | grep -v "(ntime" > all.tsv 								# Take all lnL results from the rsv file, -v is to not obtain the same result from the .txt file
sed -i.bak -e 's#\./##g' -e 's#/rst##g' -e 's#:lnL = ##g' all.tsv			# Remove all unwanted characters
sed -i.bak 's/-/\t-/g' all.tsv												# Seperate Species names with a tab
sort all.tsv > paml_results.tsv												# Put the branches/sites in alphabetical order.

# Open paml_results.tsv in Excel
# copy the null values to their corresponding parameter tests (this can be done in one go as the output has been ordered alphabetically)
# Add a new column with the function 2*(parameter-null) called LRT
# Add another new column that does CHISQ.DIST.RT([LRT], 1) which is the chi-squared p-value
# You can use conditional formatting to make any value of p that are >0.05 show in red (Conditional Formatting > Highlight cell rules > Highlight cells Less than).
# Copy the site/branch name and p value to a new sheet, 
## order by p value size (smallest to largest), 
## add a column and asign each site/branch a number from 1 to maximum (i), 
## add a column with 0.05 which is the FDR, 
## add a column with 107 is which is the number of tests (m), 
## add a column calculating the threshold ((i/m)*FDR)
## add a final column calculating the threshold minus the chi-squared p value
## any results that are positive are truly significant and arent false discoveries due to over testing