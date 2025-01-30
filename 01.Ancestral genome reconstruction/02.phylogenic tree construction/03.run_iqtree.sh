#!/bin/bash
#SBATCH -J get_iqtree
#SBATCH -p cpu
#SBATCH -N 1
#SBATCH --cpus-per-task=8
#SBATCH --mem=20G
#SBATCH --output=get_iqtree.o
#SBATCH --error=get_iqtree.e

perl ./get_4DSites_maf2phy.pl Quy_species.list Human.4dtv All_species.maf All.4dtv.phy

iqtree2 -s All.4dtv.phy -nt 8 -bb 1000 -m TEST -o Tropical_f
