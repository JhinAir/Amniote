#!/usr/bin/perl
use strict;
use List::Util qw/max min sum/;
#use Statistics::Descriptive;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT,">$ARGV[1]") || die "Can't open OUT!\n";

my (%hash1,%hash2);
my $count;
while(<IN>){
	chomp;
	$count++;
	my @tmp=split /\s+/,$_;
	$hash1{$count}=$_;
	if(!exists $hash2{$tmp[-1]}){
		$hash2{$tmp[-1]}{1}=$tmp[3];
		$hash2{$tmp[-1]}{2}=$tmp[3];
	}
	else{
		if($tmp[3]<$hash2{$tmp[-1]}{1}){
			$hash2{$tmp[-1]}{1}=$tmp[3];
		}
		elsif($tmp[3]>$hash2{$tmp[-1]}{2}){
			$hash2{$tmp[-1]}{2}=$tmp[3];
		}
	}
}

foreach my $key(sort {$a <=> $b} keys %hash1){
	my @tmp=split /\s+/,$hash1{$key};
	my $index=($tmp[3]-$hash2{$tmp[-1]}{1})/($hash2{$tmp[-1]}{2}-$hash2{$tmp[-1]}{1}) if($hash2{$tmp[-1]}{2}-$hash2{$tmp[-1]}{1}>0);
	print OUT "$hash1{$key}\t$index\n";
}
