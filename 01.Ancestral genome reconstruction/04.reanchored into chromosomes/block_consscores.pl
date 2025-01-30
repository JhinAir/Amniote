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
	#s/\-//g;
	my @tmp=split /\s+/,$_;
	$tmp[0]=~ s/\-//g;
	$tmp[1]=~ s/\-//g;
	$hash{$tmp[0]}{$tmp[1]}=$tmp[2];
	$hash{$tmp[1]}{$tmp[0]}=$tmp[2];
}

while(<IN2>){
	chomp;
	my @tmp=split /\s+/,$_;
	my $score=0;
	if(exists $hash{$tmp[0]}{$tmp[1]} && $hash{$tmp[0]}{$tmp[1]}>$score){
		$score=$hash{$tmp[0]}{$tmp[1]};
	}
	if(exists $hash{$tmp[1]}{$tmp[0]} && $hash{$tmp[1]}{$tmp[0]}>$score){
		$score=$hash{$tmp[1]}{$tmp[0]};
	}
	if($score==0){
		$score="NA";
	}
	print OUT "$_\t$score\n";
}
