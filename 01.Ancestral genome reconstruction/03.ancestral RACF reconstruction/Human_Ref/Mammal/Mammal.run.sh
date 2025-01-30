#!/bin/bash

#SBATCH -J Mammal
#SBATCH -p cpu
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH -o Mammal.o
#SBATCH -e Mammal.e

~/Software/DESCHRAMBLER-master/DESCHRAMBLER.pl params_r1.txt
