#!/bin/bash
# exit when any command fails
set -e
rm -rf output/tmp/*

for bam in output/final/*hg19.dedup.realigned.recal.bam
do

        echo $bam
        NAME=${bam%-*.*.*.*.*}
        NAME=${NAME##*/}

        echo $NAME

	# Reads with a MapQ < 10 that overlap the regions specified in the bed get extracted

	samtools view -h -@ 15 -m 3G -L data/external/illuminaRL100.hg19.camo.LPA.realign.sorted.bed $bam | awk '$5 < 10 || $1 ~ "^@"' | samtools view -hb - | samtools sort -n -@ 15 -m 3G -o output/tmp/${NAME}-hg19_camo.bam -

	# The extracted reads get transformed into fastq files
	# Tthe bamtofastq outputs a lot of warnings when a read pair cannot be found, 2> /dev/null throws these Warning messages away

	/opt/tools/genetics/bedtools2/bin/bedtools bamtofastq -i output/tmp/${NAME}-hg19_camo.bam  -fq output/tmp/${NAME}-hg19_camo_R1.fastq  -fq2 output/tmp/${NAME}-hg19_camo_R2.fastq 2> /dev/null

	# The fastq files get aligned to a single kiv2 reference
	/opt/tools/genetics/bwa/bwa mem -t 15 -M data/external/kiv2.fasta -R "@RG\\tID:LPA-exome-${NAME}-hg19_camo-kiv2\\tSM:${NAME}\\tPL:ILLUMINA" output/tmp/${NAME}-hg19_camo_R1.fastq output/tmp/${NAME}-hg19_camo_R2.fastq | samtools sort -@ 15 -o output/final/$NAME-kiv2.ebb.bam -
        samtools index -@ 15 output/final/$NAME-kiv2.ebb.bam

done
