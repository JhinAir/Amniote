#!/usr/bin/perl
use strict;
use List::Util qw/max min sum/;
#use Statistics::Descriptive;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
my $clade=$ARGV[1];
open(OUT,">>$ARGV[2]") || die "Can't open OUT!\n";

my $count;
my %hash;
while(<IN>){
	chomp;
	s/A//g;
	my @tmp=split /\s+/,$_;
	for(my $i=0;$i<=$#tmp;$i++){
		if($tmp[$i] eq $clade){
			$count=$tmp[$i+1];
			$hash{$tmp[0]}+=$tmp[$i+2];
			$hash{$tmp[1]}+=$tmp[$i+2];
		}
	}
}

foreach my $alg(sort {$a <=> $b} keys %hash){
	my $ratio=sprintf "%.4f", $hash{$alg}/$count if($count>0);
	print OUT "$alg\t$clade\t$ratio\n";
}
