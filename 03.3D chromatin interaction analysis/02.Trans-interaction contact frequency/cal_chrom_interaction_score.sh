#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 <Quary_name>"
  exit 1
fi

Quary_name="$1"

perl cal_chrom_interaction.pl ${Quary_name}.50Kb.ginteractions.tsv out1 out2 > out3
perl cal_chrom_interaction_score.pl out3 out2 out1 ${Quary_name}.score
perl score_convert.pl /data/home/zhou3lab/liujing/Amniote/Reference/${Quary_name}/${Quary_name}.chrom.sizes Amniote.Human.ALG_type.r2 Amniote.${Quary_name}.blocks.txt ${Quary_name}.score ${Quary_name}.convert.score.txt
rm out*
