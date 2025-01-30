#!/bin/perl
use strict;
use List::Util qw/max min/;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT,">$ARGV[1]") || die "Can't open OUT!\n";

my (%hash1,%hash2,%Species);
while(<IN>){
	chomp;
	next if(/score/);
	my @tmp=split /\s+/,$_;
	$Species{$tmp[0]}{$tmp[2]}="$tmp[0]\t$tmp[1]\t$tmp[2]\t$tmp[4]\t$tmp[7]";
	$hash1{$tmp[0]}{$tmp[2]}++;
	$hash2{$tmp[0]}{$tmp[2]}+=$tmp[-1];
}
print OUT "spe\tclade\tchr\tsize\torigin\tscore\n";
foreach my $spe(sort {$a cmp $b} keys %hash1){
	foreach my $chr(sort {$a cmp $b} keys %{$hash1{$spe}}){
		my $ave=$hash2{$spe}{$chr}/$hash1{$spe}{$chr} if($hash1{$spe}{$chr}>0);
		print OUT "$Species{$spe}{$chr}\t$ave\n";
	}
}
