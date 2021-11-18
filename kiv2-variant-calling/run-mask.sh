#!/bin/bash
# exit when any command fails
set -e
rm -rf output/tmp/*
for bam in output/final/*mask.bam
do

        echo $bam
        NAME=${bam%.*}
        NAME=${NAME##*/}

        echo $NAME
	echo ${NAME}.kiv2.bam
	echo ${NAME}.kiv2.mut.vcf


	samtools view -b -h $bam "chr#:#########-#########" > output/final/${NAME}.kiv2.bam

	samtools index output/final/${NAME}.kiv2.bam

	#Variant calling with Mutserve
#	java -jar /opt/tools/genetics/mutserve/mutserve-1.3.1.jar analyse-local --input output/final/${NAME}.kiv2.bam --reference data/external/mask_chr#.fasta --output output/tmp/${NAME}.kiv2.mut.vcf --level 0.01 --noBaq --deletions --############

	#coordinate transformation
#	awk '($2 !~ /^[0-9]+$/) {print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8"\t"$9"\t"$10"\t"$11"\t"$12}' output/tmp/${NAME}.kiv2.mut.vcf > output/tmp/${NAME}.kiv2.mut.POS.RC.vcf
#	awk '($2 ~ /^[0-9]+$/) {print $1"\t"($2-#########)*(-1)+1"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8"\t"$9"\t"$10"\t"$11"\t"$12}' output/tmp/${NAME}.kiv2.mut.vcf >> output/tmp/${NAME}.kiv2.mut.POS.RC.vcf


	#reverse complement
#	sed -i 's/\tA\t/\tt\t/;s/\tC\t/\tg\t/;s/\tG\t/\tc\t/;s/\tT\t/\ta\t/' output/tmp/${NAME}.kiv2.mut.POS.RC.vcf
#	sed -i 's/\ta\t/\tA\t/;s/\tc\t/\tC\t/;s/\tg\t/\tG\t/;s/\tt\t/\tT\t/' output/tmp/${NAME}.kiv2.mut.POS.RC.vcf

#	cp output/tmp/${NAME}.kiv2.mut.POS.RC.vcf output/final/${NAME}.kiv2.mut.vcf

	#Variant calling with GATK (Ploidy 100)
        java -jar bins/GenomeAnalysisTK.jar -T HaplotypeCaller -R data/external/mask.fasta -I output/final/${NAME}.kiv2.bam --genotyping_mode DISCOVERY --sample_ploidy 100 --dontUseSoftClippedBases -o output/tmp/${NAME}.kiv2.all.gatkP100.vcf
        java -jar bins/GenomeAnalysisTK.jar -T SelectVariants -R data/external/mask.fasta -V output/tmp/${NAME}.kiv2.all.gatkP100.vcf -selectType SNP -o output/tmp/${NAME}.kiv2.gatkP100.vcf

	#coordinate transformation
        awk '($2 !~ /^[0-9]+$/) {print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8"\t"$9"\t"$10"\t"$11"\t"$12}' output/tmp/${NAME}.kiv2.gatkP100.vcf > output/tmp/${NAME}.kiv2.gatkP100.POS.RC.vcf
        awk '($2 ~ /^[0-9]+$/) {print $1"\t"($2-#########)*(-1)+1"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8"\t"$9"\t"$10"\t"$11"\t"$12}' output/tmp/${NAME}.kiv2.gatkP100.vcf >> output/tmp/${NAME}.kiv2.gatkP100.POS.RC.vcf


        #reverse complement
        sed -i 's/\tA\t/\tt\t/;s/\tC\t/\tg\t/;s/\tG\t/\tc\t/;s/\tT\t/\ta\t/' output/tmp/${NAME}.kiv2.gatkP100.POS.RC.vcf
        sed -i 's/\ta\t/\tA\t/;s/\tc\t/\tC\t/;s/\tg\t/\tG\t/;s/\tt\t/\tT\t/' output/tmp/${NAME}.kiv2.gatkP100.POS.RC.vcf

        cp output/tmp/${NAME}.kiv2.gatkP100.POS.RC.vcf output/final/${NAME}.kiv2.gatkP100.vcf

done
#
