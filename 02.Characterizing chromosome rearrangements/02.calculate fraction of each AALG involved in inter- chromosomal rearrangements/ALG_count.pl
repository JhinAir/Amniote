#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT,">$ARGV[1]") || die "Can't open OUT!\n";

my ($count1,$count2);
while(<IN>){
	chomp;
	next if(/ALG/);
	my @tmp=split /\s+/,$_;
	$count1++;
	for(my $i=1;$i<=$#tmp;$i++){
		my @arr=split /\:/,$tmp[$i];
		if($arr[1]>=0.1 || $arr[2]>=0.1){
			$count2++;
		}
	}
}

my $ave=$count2/$count1 if($count1>0);
print OUT "$count1\t$count2\t$ave\n";
