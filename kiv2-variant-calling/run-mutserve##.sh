#!/bin/bash
# exit when any command fails
set -e
rm -rf output/tmp/*
for bam in output/final/*wes-kiv2*.bam
do

	echo $bam
        NAME=${bam%.*}
        NAME=${NAME##*/}

        echo $NAME

## Variant Calling ##

	java -jar /opt/tools/genetics/mutserve/mutserve-1.3.1.jar analyse-local --input output/final/"$NAME".bam --reference data/external/kiv2.fasta --output output/final/"$NAME".mut.vcf --level 0.01 --noBaq --deletions --###############

done

