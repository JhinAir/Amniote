#!/bin/bash

#SBATCH -J Boreoeutheria
#SBATCH -p cpu
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH -o Boreoeutheria.o
#SBATCH -e Boreoeutheria.e

~/Software/DESCHRAMBLER-master/DESCHRAMBLER.pl params.Boreoeutheria.txt
