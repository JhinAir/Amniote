#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
open(IN3,"$ARGV[2]") || die "Can't open IN3!\n";
open(OUT,">$ARGV[3]") || die "Can't open OUT!\n";

my %Fusion;
while(<IN1>){
	chomp;
	my @tmp=split /\s+/,$_;
	for(my $i=1;$i<=$#tmp;$i++){
		my ($a,$b)=split /\_/,$tmp[$i];
		$Fusion{$tmp[0]}{$a}=1;
		$Fusion{$tmp[0]}{$b}=1;
	}
}

my %Trans;
while(<IN2>){
	chomp;
	my @tmp=split /\s+/,$_;
	for(my $i=1;$i<=$#tmp;$i++){
		my ($a,$b)=split /\_/,$tmp[$i];
		if(!exists $Fusion{$tmp[0]}{$a}){
			$Trans{$tmp[0]}{$a}=1;
		}
		if(!exists $Fusion{$tmp[0]}{$b}){
			$Trans{$tmp[0]}{$b}=1;
		}
	}
}

my %Total;
my %Count;
print OUT "chr\tfusion\ttrans\n";
while(<IN3>){
	chomp;
	next if(/^Block/);
	s/A//g;
	my @tmp=split /\s+/,$_;
	next if($tmp[5]=~ /N/);
	my $len=$tmp[7]-$tmp[6]+1;
	$Total{$tmp[5]}+=$len;
	if(exists $Fusion{$tmp[5]}{$tmp[1]}){
		$Count{$tmp[5]}{1}+=$len;
	}
	elsif(exists $Trans{$tmp[5]}{$tmp[1]}){
		$Count{$tmp[5]}{2}+=$len;
	}
}

foreach my $chr(sort {$a cmp $b} keys %Total){
	my $fusion=$Count{$chr}{1}/$Total{$chr} if($Total{$chr}>0);
	my $trans=$Count{$chr}{2}/$Total{$chr} if($Total{$chr}>0);
	print OUT "$chr\t$fusion\t$trans\n";
}
