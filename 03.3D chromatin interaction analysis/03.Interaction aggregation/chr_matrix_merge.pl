#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

my $dir="/data/home/zhou3lab/zhangxinpei/JingLiu/07_3DGenome/Human/Juicer";
opendir(DIR,"$dir") || die "Can't open DIR!\n";
my $file;
while($file=readdir(DIR)){
	if($file=~ /(.*)\_inter.hic\z/){
		my $stg=$1;
		open(OUT1,">$stg.500Kb.cis.oe.matrix") || die "Can't open IN1!\n";
		open(OUT2,">$stg.500Kb.trans.oe.matrix") || die "Can't open IN2!\n";
		opendir(DIR2,"$dir/$stg") || die "Can't open DIR2!\n";
		my $matrix;
		while($matrix=readdir(DIR2)){
			if($matrix=~ /(.*)\_500000.oe.matrix\z/){
				my ($chr1,$chr2)=split /\_/,$1;
				open(IN,"$dir/$stg/$matrix") || die "Can't open IN!\n";
				while(<IN>){
					chomp;
					my @tmp=split /\s+/,$_;
					print OUT2 "$chr1\t$tmp[0]\t$chr2\t$tmp[1]\t$tmp[2]\n";
				}
				close IN;
			}
			elsif($matrix=~ /(.*)\_500000.cis.oe.matrix\z/){
				my $chr=$1;
				open(IN,"$dir/$stg/$matrix") || die "Can't open IN!\n";
				while(<IN>){
					chomp;
					my @tmp=split /\s+/,$_;
					print OUT1 "$chr\t$tmp[0]\t$chr\t$tmp[1]\t$tmp[2]\n";
				}
				close IN;
			}
		}
	}
}
