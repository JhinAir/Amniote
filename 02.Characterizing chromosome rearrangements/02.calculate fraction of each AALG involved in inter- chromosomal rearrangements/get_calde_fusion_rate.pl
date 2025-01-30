#!/usr/bin/perl
use strict;
use List::Util qw/max min sum/;
#use Statistics::Descriptive;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT,">$ARGV[1]") || die "Can't open OUT!\n";

my (%Species,%Clade);
while(<IN>){
	chomp;
	my @tmp=split /\s+/,$_;
	if(!exists $Species{$tmp[0]}){
		$Clade{$tmp[-1]}++;
		$Species{$tmp[0]}=$tmp[-1];
	}
}
my $dir="/slurm/home/zju/zhanglab/liujing/Project/Amniote/Deschrambler/Amniote/Amniote_300Kb_r2/ALG_connection";
opendir(DIR,"$dir") || die "Can't open DIR!\n";
my $file;
my %hash;
while($file=readdir(DIR)){
	if($file=~ /(.*)\.fusion.out\z/){
		my $spe=$1;
		my $clade=$Species{$spe};
		open(INPUT,"$dir/$file") || die "Can't open INPUT!\n";
		my %TMP_hash;
		while(<INPUT>){
			chomp;
			my @tmp=split /\s+/,$_;
			#my %TMP_hash;
			for(my $i=1;$i<=$#tmp;$i++){
				my ($alg1,$alg2)=split /\_/,$tmp[$i];
				if(!exists $TMP_hash{$alg1}){
					$TMP_hash{$alg1}=1;
					$hash{$clade}{$alg1}++;
				}
				if(!exists $TMP_hash{$alg2}){
					$TMP_hash{$alg2}=1;
					$hash{$clade}{$alg2}++;
				}
			}
		}
	}
}

foreach my $clade(sort {$a cmp $b} keys %hash){
	next unless($clade=~ /R|M/);
	for(my $i=1;$i<=44;$i++){
		my $count=0;
		if(exists $hash{$clade}{$i}){
			$count=$hash{$clade}{$i};
		}
		my $ratio=sprintf "%.4f",$count/$Clade{$clade} if($Clade{$clade}>0);
		print OUT "$clade\t$i\t$ratio\n";
	}
}

