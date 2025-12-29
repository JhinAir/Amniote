#!/usr/bin/perl
use strict;
use List::Util qw/max min sum/;
#use Statistics::Descriptive;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
open(OUT,">$ARGV[2]") || die "Can't open OUT!\n";

my %hash;
while(<IN1>){
	chomp;
	next unless(/Human/);
	my @tmp=split /\s+/,$_;
	$hash{$tmp[2]}{$tmp[3]}=$tmp[0];
}

print OUT "Amniote\tMammal\n";
while(<IN2>){
	chomp;
	next unless(/Human/);
	my @tmp=split /\s+/,$_;
	if(exists $hash{$tmp[2]}{$tmp[3]}){
		print OUT "$hash{$tmp[2]}{$tmp[3]}\t$tmp[0]\n";
	}
}
