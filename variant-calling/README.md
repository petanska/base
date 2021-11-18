# QC, Alignment & Variant calling

## Data Structure

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
