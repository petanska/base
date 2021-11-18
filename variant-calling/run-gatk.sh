#!/bin/bash
# exit when any command fails
set -e
rm -rf output/tmp/*
for bam in output/final/*.bam
do

        [[ $bam == *kiv2* ]] && continue
        [[ $bam == *.dedup.realigned.recal.* ]] && continue

	echo $bam
        NAME=${bam%.*}
        NAME=${NAME##*/}

        echo $NAME

# Remove Duplicate Reads

        java -jar bins/picard.jar MarkDuplicates -I $bam -O output/tmp/$NAME.dedup.bam -M output/tmp/$NAME.metrics.txt
        samtools index -@ 12 output/tmp/$NAME.dedup.bam
	# BGI performs this step with buildBamIndex

# Realign around InDels

	java -jar bins/GenomeAnalysisTK.jar -T IndelRealigner -R data/external/hg19.fasta -I output/tmp/$NAME.dedup.bam  -targetIntervals data/external/hg19_indels-realigner.intervals -known data/external/Mills_and_1000G_gold_standard.indels.hg19.sites.vcf -o output/tmp/$NAME.dedup.realigned.bam

# Base Quality Score Recalibration

        java -jar bins/GenomeAnalysisTK.jar -T BaseRecalibrator -R data/external/hg19.fasta -I output/tmp/$NAME.dedup.realigned.bam -knownSites data/external/dbsnp_138.hg19.vcf -knownSites data/external/Mills_and_1000G_gold_standard.indels.hg19.sites.vcf -o output/tmp/$NAME.recal.table

        java -jar bins/GenomeAnalysisTK.jar -T PrintReads -R data/external/hg19.fasta -I output/tmp/$NAME.dedup.realigned.bam -BQSR output/tmp/$NAME.recal.table -o output/final/$NAME.dedup.realigned.recal.bam
        samtools index -@ 12 output/final/$NAME.dedup.realigned.recal.bam

# Cleaning

#	rm output/final/$NAME.dedup.realigned.recal.bai
	# some command is generating this unwanted bai
	
# Variant Calling

        java -jar bins/GenomeAnalysisTK.jar -T HaplotypeCaller -R data/external/hg19.fasta -I output/final/$NAME.dedup.realigned.recal.bam --genotyping_mode DISCOVERY -L coordinates.bed -stand_call_conf 30 -stand_emit_conf 10 -minPruning 3 -o output/tmp/$NAME.variants.vcf

# Variant Filtering

	java -jar bins/GenomeAnalysisTK.jar -T SelectVariants -R data/external/hg19.fasta -V output/tmp/$NAME.variants.vcf -selectType SNP -o output/tmp/$NAME.raw_snps.vcf

	java -jar bins/GenomeAnalysisTK.jar -T VariantFiltration -R data/external/hg19.fasta -V output/tmp/$NAME.raw_snps.vcf --filterExpression "QD<2.0 || FS>60 || MQ<40 || MQRankSum<-12.5 || ReadPosRankSum<-8.0" --filterName "LowConfident" -o output/final/$NAME.gatk.vcf

done

