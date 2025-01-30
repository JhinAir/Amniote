#!/usr/bin/perl
use strict;
use List::Util qw/max min sum/;
#use Statistics::Descriptive;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT,">$ARGV[1]") || die "Can't open OUT!\n";

my %Chrom;
while(<IN>){
	chomp;
	my @tmp=split /\s+/,$_;
	$tmp[0]=~ s/A//g;
	$Chrom{$tmp[0]}=$tmp[2];
}

my $dir="/slurm/home/zju/zhanglab/liujing/Project/Amniote/Deschrambler/Amniote/Amniote_300Kb_r2/ALG_connection";
opendir(DIR,"$dir") || die "Can't open DIR!\n";
my $file;
my (%hash1,%hash2);
while($file=readdir(DIR)){
	if($file=~ /Amniote.(.*).blocks.txt\z/){
		my $spe=$1;
		open(INPUT,"$dir/$file") || die "Can't open INPUT!\n";
		while(<INPUT>){
			chomp;
			next if(/^Block/);
			my @tmp=split /\s+/,$_;
			$tmp[1]=~ s/A//g;
			next if($tmp[5] eq "NA");
			$hash1{$spe}{$tmp[5]}+=$tmp[3]-$tmp[2];
			$hash2{$spe}{$tmp[5]}{$Chrom{$tmp[1]}}+=$tmp[3]-$tmp[2];
		}
	}
}

foreach my $spe(sort {$a cmp $b} keys %hash2){
	foreach my $chr(sort {$a cmp $b} keys %{$hash2{$spe}}){
		my $ratio1=0;
		my $ratio2=0;
		my $ratio3=0;
		next unless($hash1{$spe}{$chr}>0);
		if(exists $hash2{$spe}{$chr}{"Macro"}){
			$ratio1=$hash2{$spe}{$chr}{"Macro"}/$hash1{$spe}{$chr};
		}
		if(exists $hash2{$spe}{$chr}{"Medium"}){
			$ratio2=$hash2{$spe}{$chr}{"Medium"}/$hash1{$spe}{$chr};
		}
		if(exists $hash2{$spe}{$chr}{"Micro"}){
			$ratio3=$hash2{$spe}{$chr}{"Micro"}/$hash1{$spe}{$chr};
		}
		print OUT "$spe\t$chr\t$ratio1\t$ratio2\t$ratio3\n";
	}
}

