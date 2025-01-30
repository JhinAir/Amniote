#!/bin/bash

#SBATCH -J Reptile
#SBATCH -p cpu
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH -o Reptile.o
#SBATCH -e Reptile.e

~/Software/DESCHRAMBLER-master/DESCHRAMBLER.pl params.txt
