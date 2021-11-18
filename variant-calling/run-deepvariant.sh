#!/bin/bash
# exit when any command fails
set -e
INPUT_DIR="${PWD}"
OUTPUT_DIR="${PWD}/output"
BIN_VERSION="1.1.0"
for bam in output/final/*.bam
do
        echo $bam
        NAME=${bam%.*}
        NAME=${NAME##*/}
	echo $NAME
	
	docker run   -v "${INPUT_DIR}":"/input"   -v "${OUTPUT_DIR}":"/output"   google/deepvariant:"${BIN_VERSION}"   /opt/deepvariant/bin/run_deepvariant   --model_type=WES --ref=/input/data/external/hg19.fasta   --reads=/input/output/final/"${NAME}".dedup.realigned.recal.bam   --regions "chr#:#########-#########"   --output_vcf=/output/final/"$NAME".dv.vcf   --num_shards=12
done
