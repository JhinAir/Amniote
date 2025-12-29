#########01_step: extract synteny blocks from raw APCFs generated from primary Deschrambler output
perl get_blocks.pl Amniote.APCFs Species.blocks.txt
###We manually reanchored the Amniote.APCFs into .Reanchored, based on the connection principle described in the manuscript methods. The reason is that, the primary Deschrambler RACFs are too fragmented (76 in our amniote case). So we followed the way did in previous mammalian recontruction (https://doi.org/10.1073/pnas.2209139119) with a stricter criterion. For details, please check the 'Ancestral chromosome reconstruction' section in the Methods.
perl get_species_block.R1.pl Species.blocks.txt Amniote.APCF.Reanchored Human Amniote.Human.blocks.txt ##to extract human synteny_blocks
perl get_species_block.R2.pl Species.blocks.txt Amniote.Human.blocks.txt Ancestor.APCF.Reanchored Chicken Amniote.Chicken.blocks.txt ##to extract chicken synteny_blocks
perl block_consscores.pl block_consscores.txt Amniote.Human_chr_connection.breakpoint_blocks.txt Amniote.Human_chr_connection.breakpoint_blocks.scores ##this is in-house script to collect the block_consscores for the junctions of APCF connections. 'block_consscores.txt' is the Deschrambler output to show the connection scores.

#########02.Amniote_Mammal
perl get_Amniote_Mammal.block_num.pl Species.blocks.txt Mammal.Species.blocks.txt Amniote_Mammal.aligned.block_num
perl get_new_ALG_block_order.pl Amniote_Mammal.aligned.block_num Mammal.APCF.Reanchored Mammal.APCF.Reanchored.Renumber

#########03.Amniote_Reptile
perl get_Amniote_Reptile_common_blocks.pl Amniote.Chicken.blocks.txt Reptile.Chicken.blocks.txt Amniote.Reptile.Chicken_based.common_blocks
