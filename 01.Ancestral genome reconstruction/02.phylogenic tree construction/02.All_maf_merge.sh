#!/bin/bash
#SBATCH -J multiz
#SBATCH -p cpu
#SBATCH -N 1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50G
#SBATCH --output=multiz.o
#SBATCH --error=multiz.e

multiz Aardvark.maf Asian_elephant.maf 1 out1 out2 > tmp0.maf
multiz tmp0.maf Australian_echidna.maf 1 out1 out2 > tmp1.maf
multiz tmp1.maf Brown_bat.maf 1 out1 out2 > tmp2.maf
multiz tmp2.maf Burmese_python.maf 1 out1 out2 > tmp3.maf
multiz tmp3.maf Cheetah.maf 1 out1 out2 > tmp4.maf
multiz tmp4.maf Chicken.maf 1 out1 out2 > tmp5.maf
multiz tmp5.maf Chinese_alligator.maf 1 out1 out2 > tmp6.maf
multiz tmp6.maf Chinese_pangolin.maf 1 out1 out2 > tmp7.maf
multiz tmp7.maf Crag_lizard.maf 1 out1 out2 > tmp8.maf
multiz tmp8.maf Donkey.maf 1 out1 out2 > tmp9.maf
multiz tmp9.maf Emu.maf 1 out1 out2 > tmp10.maf
multiz tmp10.maf Eurasian_nightjar.maf 1 out1 out2 > tmp11.maf
multiz tmp11.maf European_otter.maf 1 out1 out2 > tmp12.maf
multiz tmp12.maf European_rabbit.maf 1 out1 out2 > tmp13.maf
multiz tmp13.maf Fruit_bat.maf 1 out1 out2 > tmp14.maf
multiz tmp14.maf Gray_squirrel.maf 1 out1 out2 > tmp15.maf
multiz tmp15.maf Great_bustard.maf 1 out1 out2 > tmp16.maf
multiz tmp16.maf Hooded_crow.maf 1 out1 out2 > tmp17.maf
multiz tmp17.maf Killer_whale.maf 1 out1 out2 > tmp18.maf
multiz tmp18.maf Leopard_gecko.maf 1 out1 out2 > tmp19.maf
multiz tmp19.maf Monk_parakeet.maf 1 out1 out2 > tmp20.maf
multiz tmp20.maf Mouse.maf 1 out1 out2 > tmp21.maf
multiz tmp21.maf Panther_chameleon.maf 1 out1 out2 > tmp22.maf
multiz tmp22.maf Pig.maf 1 out1 out2 > tmp23.maf
multiz tmp23.maf Platypus.maf 1 out1 out2 > tmp24.maf
multiz tmp24.maf Giant_anteater.maf 1 out1 out2 > tmp25.maf
multiz tmp25.maf Rhesus_macaque.maf 1 out1 out2 > tmp26.maf
multiz tmp26.maf Sea_snake.maf 1 out1 out2 > tmp27.maf
multiz tmp27.maf Sea_turtle.maf 1 out1 out2 > tmp28.maf
multiz tmp28.maf Sheep.maf 1 out1 out2 > tmp29.maf
multiz tmp29.maf Siamese_crocodile.maf 1 out1 out2 > tmp30.maf
multiz tmp30.maf Softshell_turtle.maf 1 out1 out2 > tmp31.maf
multiz tmp31.maf Tasmanian_devil.maf 1 out1 out2 > tmp32.maf
multiz tmp32.maf Tropical_frog.maf 1 out1 out2 > tmp33.maf
multiz tmp33.maf Whip_snake.maf 1 out1 out2 > All_species.maf
