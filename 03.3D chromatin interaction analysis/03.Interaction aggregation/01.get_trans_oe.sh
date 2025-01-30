#!/bin/bash
#SBATCH --job-name=get_trans
#SBATCH --partition=cpu
#SBATCH --cpus-per-task=1
#SBATCH --mem=20000
#SBATCH --output=get_trans.o
#SBATCH --error=get_trans.e

for i in *_inter.hic; do perl get_trans_oe.pl Human.chr $i 500000; done
