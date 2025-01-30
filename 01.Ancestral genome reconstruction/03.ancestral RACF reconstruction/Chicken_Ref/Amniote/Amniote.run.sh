#!/bin/bash

#SBATCH -J Amniote
#SBATCH -p cpu
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH -o Amniote.o
#SBATCH -e Amniote.e

~/Software/DESCHRAMBLER-master/DESCHRAMBLER.pl params.Amniote.txt

