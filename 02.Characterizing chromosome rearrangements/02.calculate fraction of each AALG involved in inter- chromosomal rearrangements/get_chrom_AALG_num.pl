#!/bin/perl
use strict;
use List::Util qw/max min/;

#open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT,">>$ARGV[0]") || die "Can't open OUT!\n";

my $dir="/slurm/home/zju/zhanglab/liujing/Project/Amniote/Deschrambler/Amniote/Amniote_300Kb_r2/ALG_connection";
my $file;
opendir(DIR,"$dir") || die "Can't open DIR!\n";
while($file=readdir(DIR)){
	if($file=~ /Amniote.(.*).chrom_percent.txt\z/){
		my $spe=$1;
		my ($count1,$count2);
		open(IN,"$dir/$file") || die "Can't open IN!\n";
		while(<IN>){
			chomp;
			next if(/ALG/);
			my @tmp=split /\s+/,$_;
			$count1++;
			for(my $i=1;$i<=$#tmp;$i++){
				my @arr=split /\:/,$tmp[$i];
				if($arr[1]>=0.1){
					$count2++;
				}
			}
		}
		my $ave=$count2/$count1 if($count1>0);
		print OUT "$spe\t$ave\n";
	}
}
