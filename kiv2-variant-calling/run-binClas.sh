#!/bin/bash
# exit when any command fails
set -e
rm -rf output/tmp/*

for vcf in output/final/*kiv2*.vcf
do

	echo -e "\n[CAVE: The specificity value is not accurate as we set an exaggerated number of true negatives: 5104 instead of 742]"
	
	echo -e "\n$vcf"
        NAME=${vcf%.*}
        NAME=${NAME##*/}
	sample=${NAME%_*}

	#Extract the entries from the VCF
	grep -v \# $vcf > output/tmp/${NAME}_perf1.txt

	#Extract the columns for CHROM POS and ALT
	awk '{print $1"\t"$2"\t"$5}' output/tmp/${NAME}_perf1.txt > output/tmp/${NAME}_perf2.txt

	#Replace the CHROM column with the sample ID
	awk -v ID="$NAME" '$1=ID' output/tmp/${NAME}_perf2.txt > output/tmp/${NAME}_perf3.txt

	#Create a header
	echo -e "ID\tPOS\tALT" > output/tmp/header.txt

	#Concatenate them
	cat output/tmp/header.txt output/tmp/${NAME}_perf3.txt > output/tmp/${NAME}_perf4.txt

	#Replace the whitespaces with tab separators
	awk -v OFS"=\t" '$1=$1' output/tmp/${NAME}_perf4.txt > output/tmp/${NAME}_test.txt

	#Filtering the VCFs for exonic variants +- 100 bp intronic context sequence
	awk '$2=="POS" || $2>=481 && $2<=840 || $2>=4644 && $2<=5025' output/tmp/${NAME}_test.txt > output/tmp/${NAME}_test.ex.txt
	awk '$2=="POS" || $2>=481 && $2<=840 || $2>=4644 && $2<=5025' output/tmp/${sample}_gold.txt > output/tmp/${sample}_gold.ex.txt

	#Calculating the Sensitivity, Sensitivity and Precision
	java -jar /opt/tools/genetics/mutserve/mutserve-1.2.1-lpa.jar performance --in output/tmp/${NAME}_test.ex.txt --gold output/tmp/${sample}_gold.ex.txt --length 5104

done

echo -e "\n\nYou can perform greps on this output: sh run-binClass.sh | grep mut"
