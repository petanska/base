#!/bin/bash
# exit when any command fails
set -e

for f in $(ls data/raw/*.gz | sed -r 's/_R[12].fastq.gz//' | uniq)
do
        echo ${f}_R1.fastq.gz ${f}_R2.fastq.gz
        NAME=${f%_*.*.*}
	NAME=${NAME##*/}

	REF=${1%.*}
	REF=${REF##*/}

	/opt/tools/genetics/bwa/bwa mem -t 12 -M $1 -R "@RG\\tID:LPA-exome-${NAME}-${REF}\\tSM:${NAME}\\tPL:ILLUMINA" ${f}_R1.fastq.gz ${f}_R2.fastq.gz | samtools sort -@ 12 -o output/final/$NAME-$REF.bam -
        samtools index -@ 6 output/final/$NAME-$REF.bam
done
