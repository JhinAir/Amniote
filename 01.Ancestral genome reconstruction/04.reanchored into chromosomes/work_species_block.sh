#########01_step
perl get_blocks.pl Amniote.APCFs Species.blocks.txt
perl get_species_block.R1.pl Species.blocks.txt Amniote.APCF.Reanchored Human Amniote.Human.blocks.txt
perl get_species_block.R2.pl Species.blocks.txt Amniote.Human.blocks.txt Ancestor.APCF.Reanchored Chicken Amniote.Chicken.blocks.txt
perl block_consscores.pl block_consscores.txt Amniote.Human_chr_connection.breakpoint_blocks.txt Amniote.Human_chr_connection.breakpoint_blocks.scores

#########02.Amniote_Mammal
perl get_Amniote_Mammal.block_num.pl Species.blocks.txt Mammal.Species.blocks.txt Amniote_Mammal.aligned.block_num
perl get_new_ALG_block_order.pl Amniote_Mammal.aligned.block_num Mammal.APCF.Reanchored Mammal.APCF.Reanchored.Renumber

#########03.Amniote_Reptile
perl get_Amniote_Reptile_common_blocks.pl Amniote.Chicken.blocks.txt Reptile.Chicken.blocks.txt Amniote.Reptile.Chicken_based.common_blocks
