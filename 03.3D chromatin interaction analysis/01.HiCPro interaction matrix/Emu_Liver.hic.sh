#!/bin/bash

#SBATCH --job-name=Emu_Liver.hic
#SBATCH --partition=mem
#SBATCH --cpus-per-task=8
#SBATCH --mem=60000
#SBATCH --output=Emu_Liver.hic.o
#SBATCH --error=Emu_Liver.hic.e

module load bwa-0.7.17
module load samtools-1.11

trimmomatic PE -phred33 -threads 8 ../../Data/HiC/Emu/Emu_Liver_R1.fastq.gz ../../Data/HiC/Emu/Emu_Liver_R2.fastq.gz ../../Data/HiC/Emu/Emu_Liver_R1.clean.fastq.gz Emu_Liver_R1.unpaired.fastq.gz ../../Data/HiC/Emu/Emu_Liver_R2.clean.fastq.gz Emu_Liver_R2.unpaired.fastq.gz ILLUMINACLIP:../../Data/HiC/SRA/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
rm Emu_Liver_R1.unpaired.fastq.gz Emu_Liver_R2.unpaired.fastq.gz
bwa mem -A 1 -B 4 -E 50 -L 0 -t 8 ../../Reference/Emu/Emu.fa ../../Data/HiC/Emu/Emu_Liver_R1.clean.fastq.gz | samtools view -Shb -@ 8 - > Emu_Liver_R1.bam
bwa mem -A 1 -B 4 -E 50 -L 0 -t 8 ../../Reference/Emu/Emu.fa ../../Data/HiC/Emu/Emu_Liver_R2.clean.fastq.gz | samtools view -Shb -@ 8 - > Emu_Liver_R2.bam
hicBuildMatrix --samFiles Emu_Liver_R1.bam Emu_Liver_R2.bam --binSize 10000 --restrictionCutFile ../../Reference/Emu/Emu.MboI.rest_site_positions --restrictionSequence GATC --danglingSequence GATC --minMappingQuality 10 --outFileName Emu_Liver.10Kb.h5 --QCfolder Emu_Liver.10Kb_QC --threads 8
hicMergeMatrixBins --matrix Emu_Liver.10Kb.h5 --outFileName Emu_Liver.50Kb.h5 --numBins 5
hicCorrectMatrix correct --matrix Emu_Liver.50Kb.h5 --correctionMethod KR --outFileName Emu_Liver.50Kb.corrected.h5 --chromosomes chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10 chr4a chr11 chr12 chr13 chr14 chr15 chr17 chr18 chr19 chr20 chr21 chr22 chr23 chr24 chr25 chr26 chr27 chr28 chr29 chr30 chr31 chr32 chr33 chr35 chr36 chr37 chr38 chrZ
hicMergeMatrixBins --matrix Emu_Liver.10Kb.h5 --outFileName Emu_Liver.100Kb.h5 --numBins 10
hicCorrectMatrix correct --matrix Emu_Liver.100Kb.h5 --correctionMethod KR --outFileName Emu_Liver.100Kb.corrected.h5 --chromosomes chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10 chr4a chr11 chr12 chr13 chr14 chr15 chr17 chr18 chr19 chr20 chr21 chr22 chr23 chr24 chr25 chr26 chr27 chr28 chr29 chr30 chr31 chr32 chr33 chr35 chr36 chr37 chr38 chrZ
hicConvertFormat -m Emu_Liver.100Kb.corrected.h5 --inputFormat h5 --outputFormat ginteractions -o Emu_Liver.100Kb.ginteractions --resolutions 100000
hicConvertFormat --matrices Emu_Liver.100Kb.corrected.h5 --inputFormat h5 --outputFormat cool --resolutions 100000 --outFileName Emu_Liver.100Kb.cool
cooler balance Emu_Liver.100Kb.cool
cd /data/home/zhou3lab/liujing/Amniote/Reference/Emu
cut -f1,2 Emu.fa.fai > Emu.chrom.sizes
bedtools makewindows -g Emu.chrom.sizes -w 50000 | bedtools nuc -fi Emu.fa -bed stdin | grep -v "#" | cut -f1,2,3,5 > Emu.50Kb.GC
bedtools makewindows -g Emu.chrom.sizes -w 100000 | bedtools nuc -fi Emu.fa -bed stdin | grep -v "#" | cut -f1,2,3,5 > Emu.100Kb.GC
cd -
cooltools call-compartments Emu_Liver.100Kb.cool -o Emu_Liver.100Kb --reference-track ../../Reference/Emu/Emu.100Kb.GC

mkdir -p Liver/fastq && cd Liver/fastq && ln -s ../../../../Data/HiC/Emu/Emu_Liver_R1.clean.fastq.gz && ln -s ../../../../Data/HiC/Emu/Emu_Liver_R2.clean.fastq.gz && cd ../
/data/home/zhou3lab/liujing/Amniote/HiC_analysis/scripts/juicer.sh -g Emu -s MboI -d /data/home/zhou3lab/liujing/Amniote/HiC_analysis/Emu/Liver -p ../../../Reference/Emu/Emu.chrom.sizes -y ../../../Reference/Emu/Emu_MboI.txt -z ../../../Reference/Emu/Emu.fa -D /data/home/zhou3lab/liujing/Amniote/HiC_analysis -f -t 8
mv ./aligned/merged_nodups.txt ../Emu_Liver.merged_nodups.txt
mv ./aligned/inter.hic ../Emu_Liver.inter.hic
mv ./aligned/inter_30.hic ../Emu_Liver.inter_30.hic
gzip ../Emu_Liver.merged_nodups.txt
