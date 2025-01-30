####Mammal
ln -s ../../01.Ancestral genome reconstruction/04.reanchored into chromosomes/Ancestor.APCF.Reanchored Amniote.Genome_block_order
#sed -i "s/\-//g" Amniote.Genome_block_order
ln -s ../../01.Ancestral genome reconstruction/04.reanchored into chromosomes/Mammal.APCF.Reanchored.Renumber Mammal.Genome_block_order
#sed -i "s/\-//g" Mammal.Genome_block_order

perl get_aligned_blocks.pl Amniote Mammal

grimm -f Amniote.Mammal.aligned_blocks.txt -d -c -g 1,2 -S 2,3,4,5,6,7 > Amniote.Mammal.grimm_out.txt

####Reptile
perl get_New_Amniote_Reptile_GenomeOrder.pl Amniote.Reptile.Chicken_based.common_blocks Amniote.Genome_block_order Reptile.Genome_block_order Amniote.Reptile.aligned_blocks.txt
##trimme Amniote.Reptile.aligned_blocks.txt
grimm -f Amniote.Reptile.aligned_blocks.txt -d -c -g 1,2 -S 2,3,4,5,6,7 > Amniote.Reptile.grimm_out.txt
##The number of inversion is incorrected due to the block orientation
