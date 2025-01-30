#!/bin/bash

#SBATCH -J Archelosauria
#SBATCH -p cpu
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH -o Archelosauria.o
#SBATCH -e Archelosauria.e

~/Software/DESCHRAMBLER-master/DESCHRAMBLER.pl params.Archelosauria.txt

