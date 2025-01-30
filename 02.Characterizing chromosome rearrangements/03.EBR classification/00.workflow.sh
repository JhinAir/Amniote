####get EBR
perl block_merge.pl Amniote.Human.blocks.txt Amniote.Human.blocks.merge.txt
perl get_species_EBR.pl Amniote.Human.blocks.txt Amniote.Human.blocks.merge.txt 0.05 Amniote.Human.EBR
perl get_EBR_Regions.pl Amniote.Human.EBR
##
perl getshell.pl Species.list EBR_detection.all_species.run.sh
bash EBR_detection.all_species.run.sh

############abnormal cases:
perl get_species_EBR.r2.pl Amniote.Asian_elephant.blocks.txt Amniote.Asian_elephant.blocks.merge.txt 0.05 Amniote.Asian_elephant.EBR
perl get_species_EBR.r2.pl Amniote.Cheetah.blocks.txt Amniote.Cheetah.blocks.merge.txt 0.05 Amniote.Cheetah.EBR
for i in *.EBR; do perl get_EBR_Regions.pl $i; done