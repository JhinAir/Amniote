#!/usr/bin/perl
use strict;
use List::Util qw/max min sum/;
#use Statistics::Descriptive;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT,">$ARGV[1]") || die "Can't open OUT!\n";

my %hash;
while(<IN>){
	chomp;
	next if(/^#/);
	s/\[|\]//g;
	my @tmp=split /\s+/,$_;
	my ($spe,$block)=split /\./,$tmp[0];
	my ($chr,$pos)=split /\:/,$block;
	my ($start,$end)=split /\-/,$pos;
	$hash{$tmp[-1]}{$spe}="$chr\t$start\t$end\t$tmp[1]";
}

foreach my $num(sort {$a <=> $b} keys %hash){
	foreach my $spe(sort {$a cmp $b} keys %{$hash{$num}}){
		print OUT "$num\t$spe\t$hash{$num}{$spe}\n";
	}
}
