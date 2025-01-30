#!/bin/perl
use strict;
use List::Util qw/max min/;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT,">$ARGV[1]") || die "Can't open OUT!\n";

my %hash;
while(<IN>){
	chomp;
	my @tmp=split /\s+/,$_;
	$hash{$tmp[0]}{$tmp[1]}{$tmp[2]}=$tmp[3];
}

foreach my $clade(sort {$a cmp $b} keys %hash){
	foreach my $type1(sort {$a cmp $b} keys %{$hash{$clade}}){
		my $sum;
		foreach my $type2(sort {$a cmp $b} keys %{$hash{$clade}{$type1}}){
			print OUT "$clade\t$type1\t$type2\t$hash{$clade}{$type1}{$type2}\n";
			$sum+=$hash{$clade}{$type1}{$type2};
		}
		my $type3="Unchanged";
		my $ratio=1-$sum;
		print OUT "$clade\t$type1\t$type3\t$ratio\n";
	}
}
