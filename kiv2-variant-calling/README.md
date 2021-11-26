# QC, Alignment & LPA Variant Calling 

## Directory Structure

```bash
.
├── bins
├── data
│   ├── external
│   └── raw
├── docs
├── output
│   ├── final
│   └── tmp
└── reports

9 directories
```

The scripts located in the PWD (`/mnt/genepi-lehre/projects/projectName/`) access the files in `data/raw/` and `data/external/` to write their output in `output/tmp/` and `output/final/`. The tools are located in `bins/`.

## FASTQ clean-up

The `run-fastp.sh` pipeline has not been evaluated yet and would only be applicable to LPA-TarSeq data, since the WES data is already "cleaned".
"Cleaned" FASTQ data, according to the BGI, means:
1. Removing reads containing sequencing adapter;
2. Removing reads whose low-quality base ratio (base quality less than or equal to 12) is more than 50%;
3. Removing reads whose unknown base ('N' base) ratio is more than 10%.

The `run-fastp.sh` script includes the tools fastp and cutadapt.

     cd /mnt/genepi-lehre/projects/projectName/
     sh run-fastp.sh <input> <output>
     
Original FASTQ files should be removed and stored elsewhere since all further analyses are to be performed on the clean data.     

## Alignment

### bwa mem

Input data (fastq.gz) must be located in `data/raw/`.  
Output will be written in `output/final/`.

     cd /mnt/genepi-lehre/projects/projectName/
     sh run-bwa.sh <ref>
     
It is recommended to perform all alignments to the different references (hg19, kiv2, mask) in one go,
so that subsequent variant calling scripts can loop over all available bam files.

### ######´s strategy

uses a standard hg19-alignment from the alignment step above as input and extracts reads in regions of low mapping quality (MapQ).  
These regions were specified using a certain algorithm (see https://github.com/#######/################) that looked at MapQs of 100 bp WES reads that were aligned to hg19.  
These KIV-2-specific regions are specified in `data/external/illuminaRL100.hg19.####.LPA.realign.sorted.bed`.  
The extracted reads are realigned to the KIV-2 reference sequence.

Input data (bam) must be located in `output/final`.  
Output will be written in `output/final/`.  
  
Loops over hg19-aligned bams.

     cd /mnt/genepi-lehre/projects/projectName/
     sh run-######.sh

This script creates new bams.

## Variant Calling

### GATK

Input data (bam) must be located in `output/final`.  
Output will be written in `output/final/`.  
  
Loops over hg19- and mask-aligned bam files.

     cd /mnt/genepi-lehre/projects/projectName/
     sh run-gatk.sh
     
This script creates new bams (GATK best practices).

### DeepVariant

Input data (bam) must be located in `output/final`.  
Output will be written in `output/final/`.

     cd /mnt/genepi-lehre/projects/projectName/
     sh run-deepvariant.sh

### Mutserve

Input data (bam) must be located in `output/final`.  
Output will be written in `output/final/`.  
  
Loops over kiv2-aligned bams.

     cd /mnt/genepi-lehre/projects/projectName/
     sh run-mutserve.sh
     
### GATK Ploidy

Input data (bam) must be located in `output/final`.  
Output will be written in `output/final/`.  
  
Loops over kiv2-aligned bams.

     cd /mnt/genepi-lehre/projects/projectName/
     sh run-gatkPL.sh <NUM>
     
With <NUM> the user can specify the ploidy (100 is recommended).

### Masked reference

Input data (bam) must be located in `output/final`.  
Output will be written in `output/final/`.  
  
Loops over mask-aligned bams.

     cd /mnt/genepi-lehre/projects/projectName/
     sh run-mask.sh

This script creates new bams.
This script performs variant calling with Mutserve (#####) and GATK (PL=100).

### ######### ####### ############ (Mutserve)

Input data (bam) must be located in `output/final`.  
Output will be written in `output/final/`.  
  
Loops over kiv2-aligned bams.

     cd /mnt/genepi-lehre/projects/projectName/
     sh run-mutserve##.sh <NUM>

With \<NUM> the user can specify the ######### ####### (## is recommended).
     

## Compare VCF results

### Non-repetitive region

`run-diff.sh` compares two VCFs and provides a variant count as well as a list of differing variants.

The original VCF results are located in `output/final/` and end with `\_wes-hg19.gatk.vcf` or `\_wes-mask.gatk.vcf`.  
BGI VCF results are located in `/###/############/########/#######################/#########/*/*/###############/###/*.snp.vcf.gz`.  
Master Thesis VCF results are located in `/###/############/########/#######################/*/###/###/####/*_wes-chr#.vcf`.  
     
     cd /mnt/genepi-lehre/projects/projectName/
     sh run-diff.sh <output/final/*_wes.gatk.vcf> <file2.vcf>
     
### Repetitive region

`run-binClas.sh` performs binary classification analyses for KIV-2 variant calling results
by comparing them to gold standard KIV-2 variant sets of the different samples.

Sample names are being automatically detected by the script, but it is only comaptible with 
result files from the above mentioned scripts. Differently styled file-names may present a problem for `run-binClas.sh`.  

**Note that the Mutserve performance command will output inaccurate specificity values, when working with exon-filtered vcfs!**  

Input data (bam) must be located in `output/final`.  
Output will be written to stdout.  
  
Loops over kiv2 vcfs.

     cd /mnt/genepi-lehre/projects/projectName/
     sh run-binClas.sh
     
Since the output is written to stdout, the script works great with a piped `grep` command.
