#!/bin/bash
#SBATCH -J Chick_1
#SBATCH -p cpu
#SBATCH -N 1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5000
#SBATCH --output=Chicken_chr1.o
#SBATCH --error=Chicken_chr1.e

../lastz_align.sh Human chr1 Chicken
