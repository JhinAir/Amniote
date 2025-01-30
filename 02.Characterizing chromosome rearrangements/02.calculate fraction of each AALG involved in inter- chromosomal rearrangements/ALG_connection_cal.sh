#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 <Quary_name> <cutoff>"
  exit 1
fi

Quary_name="$1"
cutoff="$2"

perl ../get_species_block.R2.pl ../Species.blocks.txt ../Amniote.Human.blocks.txt ../Ancestor.APCF.Reanchored ${Quary_name} Amniote.${Quary_name}.blocks.txt
perl chrom_percent_cal.A2D.pl Amniote.${Quary_name}.blocks.txt ${cutoff} Amniote.${Quary_name}.chrom_percent.txt
perl trans_fusion_event_count.pl Amniote.${Quary_name}.chrom_percent.txt ${Quary_name}.trans.out ${Quary_name}.fusion.out
awk '{if(NF!=1)print $0}' ${Quary_name}.trans.out > ${Quary_name}.trans.out.2
mv ${Quary_name}.trans.out.2 ${Quary_name}.trans.out
awk '{if(NF!=1)print $0}' ${Quary_name}.fusion.out > ${Quary_name}.fusion.out.2
mv ${Quary_name}.fusion.out.2 ${Quary_name}.fusion.out
