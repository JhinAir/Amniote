#!/bin/bash

#SBATCH --job-name=ESC.agg
#SBATCH --partition=cpu
#SBATCH --cpus-per-task=1
#SBATCH --mem=30000
#SBATCH --output=ESC.agg.o
#SBATCH --error=ESC.agg.e

perl get_aggregated_OE.pl ESC.100Kb.oe.matrix.centromere_rm Human_100Kb.SINE.High_density.bins ESC_SINE.100Kb_0.4.Aggreated_OE
perl get_aggregated_OE.pl ESC.100Kb.oe.matrix.centromere_rm Human_100Kb.LINE.High_density.bins ESC_LINE.100Kb_0.5.Aggreated_OE

perl get_aggregated_OE.pl ESC.100Kb.oe.matrix.centromere_rm AluJ.100Kb_0.025.wins ESC_AluJ.100Kb_0.025.Aggreated_OE
perl get_aggregated_OE.pl ESC.100Kb.oe.matrix.centromere_rm AluSx.100Kb_0.18.wins ESC_AluSx.100Kb_0.18.Aggreated_OE
perl get_aggregated_OE.pl ESC.100Kb.oe.matrix.centromere_rm AluSz.100Kb_0.05.wins ESC_AluSz.100Kb_0.05.Aggreated_OE
perl get_aggregated_OE.pl ESC.100Kb.oe.matrix.centromere_rm AluY.100Kb_0.03.wins ESC_AluY.100Kb_0.03.Aggreated_OE
