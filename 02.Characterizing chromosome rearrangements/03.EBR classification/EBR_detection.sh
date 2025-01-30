#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 <Quary_name> <cutoff>"
  exit 1
fi

Quary_name="$1"
cutoff="$2"

perl block_merge.pl Amniote.${Quary_name}.blocks.txt Amniote.${Quary_name}.blocks.merge.txt
perl get_species_EBR.pl Amniote.${Quary_name}.blocks.txt Amniote.${Quary_name}.blocks.merge.txt ${cutoff} Amniote.${Quary_name}.EBR
perl get_EBR_Regions.pl Amniote.${Quary_name}.EBR

