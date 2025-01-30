#!/bin/bash

#SBATCH -J Amniote1
#SBATCH -p cpu
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH -o Amniote1.o
#SBATCH -e Amniote1.e

~/Software/DESCHRAMBLER-master/DESCHRAMBLER.pl params.txt
