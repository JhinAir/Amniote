#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT,">$ARGV[0].Regions") || die "Can't open OUT!\n";

my $count;
my ($chr,$pos,$block1,$alg1);
while(<IN>){
	chomp;
	$count++;
	my @tmp=split /\s+/,$_;
	next if($tmp[2]<0);
	if($count>2){
		$count=1;
	}
	if($count==1){
		$chr=$tmp[0];
		$pos=$tmp[1];
		$block1=$tmp[3];
		$alg1=$tmp[-1];
	}
	else{
		my @arr=sort {$a <=> $b} ($block1,$tmp[3]);
		my $connect="$arr[0]\_$arr[1]";
		print OUT "$chr\t$pos\t$tmp[1]\t$tmp[2]\t$alg1\t$tmp[-1]\t$connect\n";
	}
}
