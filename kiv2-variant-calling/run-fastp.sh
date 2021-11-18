#!/bin/bash
# exit when any command fails
set -e

for f in $(ls data/raw/*.gz | sed -r 's/_R[12].fastq.gz//' | uniq)
do
        echo ${f}_R1.fastq.gz ${f}_R2.fastq.gz
        NAME=${f%_*.*.*}
        NAME=${NAME##*/}

	No.1: Removing reads containing seq adapter
	/bins/cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -o $NAME_R1.trimmed.fastq.gz -p $NAME_R2.trimmed.fastq.gz $f_R1.fastq.gz $f_R2.fastq.gz
	/bins/cutadapt --discard-trimmed [--pair-filter=any or --pair-filter=both ?] -o $NAME_R1.trimmedout.fastq.gz -p $NAME_R2.trimmedout.fastq.gz $NAME_R1.trimmed.fastq.gz $NAME_R2.trimmed.fastq.gz

	No.1.alt: trimming sequence adapters
	/bins/fastp/

	No.2: Removing reads whose low-quality base ratio (<=12) is more than 50% 
        /bins/fastp -q 12 -u 50 $NAME_R1.trimmedout.fastq.gz $NAME_R2.trimmedout.fastq.gz

	No.3: Removing reads whose unknown base ratio is more than 10%
	/bins/cutadapt --max-n 0.1 [--pair-filter=any or --pair-filter=both ?] -o $NAME_R1.clean.fastq.gz -p $NAME_R2.clean.fastq.gz $NAME_R1.trimmedout.fastq.gz $NAME_R2.trimmedout.fastq.gz

done

