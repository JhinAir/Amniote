#!/usr/bin/perl
use strict;
use List::Util qw/max min sum/;
#use Statistics::Descriptive;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
open(IN3,"$ARGV[2]") || die "Can't open IN3!\n";
my $species=$ARGV[3];
open(OUT,">$ARGV[4]") || die "Can't open OUT!\n";

my %hash;
while(<IN1>){
	chomp;
	next if(/^#/);
	my @tmp=split /\s+/,$_;
	next unless($tmp[1] eq $species);
	$hash{$tmp[0]}="$tmp[2]\t$tmp[3]\t$tmp[4]\t$tmp[5]";
}


my %Ref;
while(<IN2>){
	chomp;
	next if(/^Block/);
	my @tmp=split /\s+/,$_;
	$Ref{$tmp[0]}="$tmp[1]\t$tmp[2]\t$tmp[3]\t$tmp[4]";
}

print OUT "Block\tchr1\tstart1\tend1\tstrand1\tchr2\tstart2\tend2\tstrand2\n";
while(<IN3>){
	chomp;
	next if(/^>|^#/);
	s/\-//g;
	my @tmp=split /\s+/,$_;
	foreach my $num(@tmp){
		next if($num eq "\$");
		print OUT "$num\t$Ref{$num}\t";
		if(exists $hash{$num}){
			print OUT "$hash{$num}\n";
		}
		else{
			print OUT "NA\tNA\tNA\tNA\n";
		}
	}
}
