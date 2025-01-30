#!/usr/bin/perl
use strict;
use List::Util qw/max min sum/;
#use Statistics::Descriptive;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT,">$ARGV[1]") || die "Can't open OUT!\n";

my (%Clade1,%Clade2);
while(<IN>){
	chomp;
	my @tmp=split /\s+/,$_;
	if(!exists $Clade1{$tmp[0]}){
		$Clade1{$tmp[0]}=$tmp[1];
		$Clade2{$tmp[1]}++;
	}
}

my $dir="/slurm/home/zju/zhanglab/liujing/Project/Amniote/Deschrambler/Amniote/Amniote_300Kb_r2/ALG_connection";
opendir(DIR,"$dir") || die "Can't open DIR!\n";
my $file;
my %hash;
my %ALG;
while($file=readdir(DIR)){
	if($file=~ /Amniote.(.*).ALG_ALG_percentage.txt\z/){
		my $clade=$Clade1{$1};
		open(IN,"$dir/$file") || die "can't open IN!\n";
		while(<IN>){
			chomp;
			my @tmp=split /\s+/,$_;
			$ALG{$tmp[0]}=1;
			$hash{$clade}{$tmp[0]}{$tmp[1]}+=$tmp[2];
		}
	}
}

foreach my $clade(sort {$a cmp $b} keys %hash){
	next if($clade eq "");
	my $count=$Clade2{$clade};
	foreach my $alg1(sort {$a cmp $b} keys %ALG){
		foreach my $alg2(sort {$a cmp $b} keys %ALG){
			my $ave=0;
			if(exists $hash{$clade}{$alg1}{$alg2}){
				$ave=$hash{$clade}{$alg1}{$alg2}/$count if($count>0);
			}
			print OUT "$clade\t$alg1\t$alg2\t$ave\n";
		}
	}
}
