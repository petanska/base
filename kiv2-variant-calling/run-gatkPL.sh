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

        java -jar bins/GenomeAnalysisTK.jar -T HaplotypeCaller -R data/external/kiv2.fasta -I output/final/$NAME.bam --genotyping_mode DISCOVERY --sample_ploidy $1 --dontUseSoftClippedBases -o output/tmp/$NAME.all.gatkP$1.vcf
	java -jar bins/GenomeAnalysisTK.jar -T SelectVariants -R data/external/kiv2.fasta -V output/tmp/$NAME.all.gatkP$1.vcf -selectType SNP -o output/final/$NAME.gatkP$1.vcf

# Command as in https://github.com/#######/##########################/####/######/#######/###########/##################

done

