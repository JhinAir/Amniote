#!/usr/bin/perl
use strict;
use List::Util qw/max min/;
#use Statistics::Basic qw(:all);
#use Statistics::Test::WilcoxonRankSum;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
open(IN3,"$ARGV[2]") || die "Can't open IN3!\n";
my $select_cutoff=$ARGV[3];
open(OUT1,">$ARGV[4]") || die "Can't open OUT1!\n";
open(OUT2,">$ARGV[5]") || die "Can't open OUT2!\n";

my %hash;
while(<IN1>){
	chomp;
	s/chr//g;
	my @tmp=split /\s+/,$_;
	my $start=(int($tmp[1]/500000))*500000-2000000;
	my $end=$tmp[1];
	for(my $i=$start;$i<=$end;$i+=500000){
		$hash{$tmp[0]}{$i}=1;
	}
}

while(<IN2>){
	chomp;
	s/chr//g;
	my @tmp=split /\s+/,$_;
	my $start=(int($tmp[1]/500000))*500000-2000000;
	my $end=(int($tmp[2]/500000)+1)*500000+2000000;
	for(my $i=$start;$i<=$end;$i+=500000){
		$hash{$tmp[0]}{$i}=1;
	}
}

my %INPUT;
my @array;
my $count;
while(<IN3>){
	chomp;
	my @tmp=split /\s+/,$_;
	next if(exists $hash{$tmp[0]}{$tmp[1]} || exists $hash{$tmp[2]}{$tmp[3]});
	next if($tmp[1]<=2000000 || $tmp[3]<=2000000);
	$count++;
	$INPUT{$count}=$_;
	push(@array,$tmp[-1]);
}

my @sort_arr=sort {$a <=> $b} @array;
my $high_index=int($#sort_arr*0.99);
my $low_index=int($#sort_arr*0.01);
my $high_cutoff=$sort_arr[$high_index];
my $low_cutoff=$sort_arr[$low_index];
$select_cutoff=int($#sort_arr*0.99*(1-$select_cutoff));
$select_cutoff=$sort_arr[$select_cutoff];
print "$low_cutoff\t$high_cutoff\t$select_cutoff\n";
foreach my $key(sort {$a <=> $b} keys %INPUT){
	my @tmp=split /\s+/,$INPUT{$key};
	next if($tmp[-1]<$low_cutoff || $tmp[-1]>$high_cutoff);
	print OUT1 "$INPUT{$key}\n";
	if($tmp[-1]>=$select_cutoff){
		print OUT2 "$INPUT{$key}\n";
	}
}
