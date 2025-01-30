#!/bin/perl
use strict;
use List::Util qw/max min/;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";##species_size
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";##alg_type
open(IN3,"$ARGV[2]") || die "Can't open IN3!\n";##blocks
open(IN4,"$ARGV[3]") || die "Can't open IN4!\n";##interaction-score
open(OUT,">$ARGV[4]") || die "Can't open OUT!\n";

my %ChromLen;
while(<IN1>){
	chomp;
	my @tmp=split /\s+/,$_;
	$ChromLen{$tmp[0]}=sprintf "%.4f",$tmp[1]/1000000;
}

my %ALG_type;
while(<IN2>){
	chomp;
	my @tmp=split /\s+/,$_;
	$ALG_type{$tmp[0]}=$tmp[-1];
}
my %hash;
while(<IN3>){
	chomp;
	next if(/start/);
	my @tmp=split /\s+/,$_;
	my $type=$ALG_type{$tmp[1]};
	$hash{$tmp[5]}{$type}+=$tmp[3]-$tmp[2]+1;
}

my %hash2;
foreach my $chr(sort {$a cmp $b} keys %hash){
	my $type1="Macro";
	my $type2="Medium";
	my $type3="Micro";
	my $ratio2=$hash{$chr}{$type2}/($hash{$chr}{$type1}+$hash{$chr}{$type2}+$hash{$chr}{$type3});
	my $ratio3=$hash{$chr}{$type3}/($hash{$chr}{$type1}+$hash{$chr}{$type2}+$hash{$chr}{$type3});
	$hash2{$chr}=$ratio2*0.5+$ratio3;
}

print OUT "chr1\tchr2\tsize1\tsize2\tsize3\torigin1\torigin2\torigin3\tscore\n";
while(<IN4>){
	chomp;
	next if(/NA|score|X|Y|Z|W/);
	my @tmp=split /\s+/,$_;
	my $size3=$ChromLen{$tmp[0]}*$ChromLen{$tmp[1]};
	my $origin3=$hash2{$tmp[0]}*$hash2{$tmp[1]};
	print OUT "$tmp[0]\t$tmp[1]\t$ChromLen{$tmp[0]}\t$ChromLen{$tmp[1]}\t$size3\t$hash2{$tmp[0]}\t$hash2{$tmp[1]}\t$origin3\t$tmp[2]\n";
}
