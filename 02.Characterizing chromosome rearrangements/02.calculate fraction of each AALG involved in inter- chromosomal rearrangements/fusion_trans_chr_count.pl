#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT,">$ARGV[1]") || die "Can't open OUT!\n";

print OUT "chr\tfusion\ttrans\n";
while(<IN>){
	chomp;
	next if(/ALG/);
	my @tmp=split /\s+/,$_;
	my $fusion=0;
	my $trans=0;
	for(my $i=1;$i<=$#tmp;$i++){
		my $type=(split /\_/,$tmp[$i])[0];
		if($type eq "T"){
			$trans++;
		}
		elsif($type eq "F"){
			$fusion++;
		}
	}
	print OUT "$tmp[0]\t$fusion\t$trans\n";
}

