#!/bin/bash

#SBATCH -J Eutheria
#SBATCH -p cpu
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH -o Eutheria.o
#SBATCH -e Eutheria.e

~/Software/DESCHRAMBLER-master/DESCHRAMBLER.pl params.Eutheria.txt
