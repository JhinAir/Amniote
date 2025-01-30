#!/bin/bash

#SBATCH -J Archosauria
#SBATCH -p cpu
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH -o Archosauria.o
#SBATCH -e Archosauria.e

~/Software/DESCHRAMBLER-master/DESCHRAMBLER.pl params.Archosauria.txt

