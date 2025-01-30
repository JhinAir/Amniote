#!/bin/bash

if [ $# -ne 3 ]; then
	echo "Usage: $0 <Ref_spe> <Ref_chr> <Quy_spe>"
	exit 1
fi

Ref_spe="$1"
Ref_chr="$2"
Quy_spe="$3"
dir="/slurm/home/zju/zhanglab/liujing/Project/Amniote"
mkdir -p $dir/Lastz_align/${Quy_spe}/${Ref_chr}
for j in $dir/Chrom/${Quy_spe}/chr*.nib
do
	lastz $dir/Chrom/${Ref_spe}/${Ref_chr}.nib $j H=2000 Y=3400 L=6000 K=2200 > $dir/Lastz_align/${Quy_spe}/${Ref_chr}/`basename $j .nib`.lav
	lavToPsl $dir/Lastz_align/${Quy_spe}/${Ref_chr}/`basename $j .nib`.lav $dir/Lastz_align/${Quy_spe}/${Ref_chr}/`basename $j .nib`.psl
	axtChain linearGap=loose -psl $dir/Lastz_align/${Quy_spe}/${Ref_chr}/`basename $j .nib`.psl $dir/Chrom/${Ref_spe}.2bit $dir/Chrom/${Quy_spe}.2bit $dir/Lastz_align/${Quy_spe}/${Ref_chr}/`basename $j .nib`.chain
done

