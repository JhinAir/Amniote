#!/bin/bash
#SBATCH -J Chicken
#SBATCH -p cpu
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --output=Chicken.o
#SBATCH --error=Chicken.e

chainMergeSort /slurm/home/zju/zhanglab/liujing/Project/Amniote/Lastz_align/Chicken/chain/*.chain > /slurm/home/zju/zhanglab/liujing/Project/Amniote/Lastz_align/MafMerge/Chicken.chain
chainPreNet /slurm/home/zju/zhanglab/liujing/Project/Amniote/Lastz_align/MafMerge/Chicken.chain /slurm/home/zju/zhanglab/liujing/Project/Amniote/Chrom/Human.sizes /slurm/home/zju/zhanglab/liujing/Project/Amniote/Chrom/Chicken.sizes /slurm/home/zju/zhanglab/liujing/Project/Amniote/Lastz_align/MafMerge/Chicken.pre.chain
chainNet /slurm/home/zju/zhanglab/liujing/Project/Amniote/Lastz_align/MafMerge/Chicken.pre.chain -minSpace=1 /slurm/home/zju/zhanglab/liujing/Project/Amniote/Chrom/Human.sizes /slurm/home/zju/zhanglab/liujing/Project/Amniote/Chrom/Chicken.sizes stdout /dev/null | netSyntenic stdin /slurm/home/zju/zhanglab/liujing/Project/Amniote/Lastz_align/MafMerge/Chicken.net
netToAxt /slurm/home/zju/zhanglab/liujing/Project/Amniote/Lastz_align/MafMerge/Chicken.net /slurm/home/zju/zhanglab/liujing/Project/Amniote/Lastz_align/MafMerge/Chicken.pre.chain /slurm/home/zju/zhanglab/liujing/Project/Amniote/Chrom/Human.2bit /slurm/home/zju/zhanglab/liujing/Project/Amniote/Chrom/Chicken.2bit stdout | axtSort stdin /slurm/home/zju/zhanglab/liujing/Project/Amniote/Lastz_align/MafMerge/Chicken.axt
axtToMaf /slurm/home/zju/zhanglab/liujing/Project/Amniote/Lastz_align/MafMerge/Chicken.axt /slurm/home/zju/zhanglab/liujing/Project/Amniote/Chrom/Human.sizes /slurm/home/zju/zhanglab/liujing/Project/Amniote/Chrom/Chicken.sizes /slurm/home/zju/zhanglab/liujing/Project/Amniote/Lastz_align/MafMerge/Chicken.maf -tPrefix=Human. -qPrefix=Chicken.
