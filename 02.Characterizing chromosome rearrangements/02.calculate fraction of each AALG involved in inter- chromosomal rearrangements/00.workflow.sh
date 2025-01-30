perl cal_Chrom_ALGType.pl Amniote.Human.ALG_type Species.Chrom.ALG_Percentage.txt
perl get_Clade_NormChr_ALGPercent.pl Species.clades.chrom_sizes.norm Species.Norm_chr.ALG_precentage.txt
perl get_species_norm_chr_size.pl Species.list Species.chrom.norm_sizes
perl size_group.pl Species.chrom.norm_sizes 0.005 Species.chrom.norm_sizes.groups

####get trans and fusion events from *.blocks.txt
perl getshell.pl Species.list ALG_connection.run.sh
bash ALG_connection.run.sh
perl get_AllClades.Trans_Fusion.event.pl Amniote.Human.ALG_type Species.clades.chrom_sizes AllClades.Fusion.event_count.txt AllClades.Trans.event_count.txt
perl get_calde_fusion_rate.pl Species.clades.chrom_sizes AllClades.Fusion.counts
for i in {1..4}; do perl get_calde_trans_rate.pl AllClades.Fusion.event_count.txt M${i} AllClades.Fusion.counts; perl get_calde_trans_rate.pl AllClades.Fusion.event_count.txt R${i} AllClades.Fusion.counts; done

####ALG-ALG heatmap
bash cal_ALG_ALG_percentage.sh
perl get_ALG_ALG_percentage.clade_ave.pl Species.clades.chrom_sizes All_Species.ALG_ALG_percentage.txt
perl get_ALG_ALG_percentage.clade_ave.r2.pl Species.clades.chrom_sizes All_Species.ALG_ALG_percentage.r2.txt
perl get_unchanged_precentage.pl All_Species.ALG_ALG_percentage.txt All_Species.ALG_ALG_percentage.add_unchanged.txt
perl get_unchanged_precentage.pl All_Species.ALG_ALG_percentage.r2.txt All_Species.ALG_ALG_percentage.add_unchanged.r2.txt

####chr_ALG_percentage_count
perl fusion_trans_chr_percentage.pl Platypus.fusion.out Platypus.trans.out Amniote.Platypus.blocks.txt Amniote.Platypus.fusion_trans_chr_percentage

