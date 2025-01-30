#!/usr/bin/perl
use strict;
use List::Util qw/max min sum/;
#use Statistics::Descriptive;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT,">$ARGV[1]") || die "Can't open OUT!\n";

while(<IN>){
	chomp;
	my @tmp=split /\s+/,$_;
	print OUT "./EBR_detection.sh $tmp[0] 0.05\n";
}
