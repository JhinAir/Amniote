#!/usr/bin/perl
use strict;
use List::Util qw/max min sum/;
#use Statistics::Descriptive;

my $dir="/slurm/home/zju/zhanglab/liujing/Project/Amniote/Chrom";
opendir(DIR,"$dir") || die "Can't open DIR!\n";
open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT,">$ARGV[1]") || die "Can't open OUT!\n";

my %Clade;
while(<IN>){
	chomp;
	my @tmp=split /\s+/,$_;
	$Clade{$tmp[0]}=$tmp[1];
}

my (%hash1,%hash2);
my $file;
while($file=readdir(DIR)){
	if($file=~ /(.*).sizes\z/){
		my $spe=$1;
		open(IN,"$dir/$file") || die "Can't open IN!\n";
		my $total_len;
		while(<IN>){
			chomp;
			my @tmp=split /\s+/,$_;
			$total_len+=$tmp[-1];
			$hash1{$spe}{$tmp[0]}=$tmp[-1];
			$hash2{$spe}+=$tmp[-1];
		}
	}
}

foreach my $spe(sort {$a cmp $b} keys %hash1){
	foreach my $chr(sort {$a cmp $b} keys %{$hash1{$spe}}){
		my $ratio=sprintf "%.4f", $hash1{$spe}{$chr}/$hash2{$spe} if($hash2{$spe}>0);
		print OUT "$spe\t$Clade{$spe}\t$chr\t$hash1{$spe}{$chr}\t$ratio\n";
	}
}
