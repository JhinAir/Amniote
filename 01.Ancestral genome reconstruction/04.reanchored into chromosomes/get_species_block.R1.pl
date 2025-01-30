#!/usr/bin/perl
use strict;
use List::Util qw/max min sum/;
#use Statistics::Descriptive;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
my $species=$ARGV[2];
open(OUT,">$ARGV[3]") || die "Can't open OUT!\n";

my %hash;
while(<IN1>){
	chomp;
	next if(/^#/);
	my @tmp=split /\s+/,$_;
	next unless($tmp[1] eq $species);
	$hash{$tmp[0]}="$tmp[2]\t$tmp[3]\t$tmp[4]\t$tmp[5]";
}
print OUT "Block\tchr1\tstart1\tend1\tstrand1\tchr2\tstart2\tend2\tstrand2\n";
my $apcf;
my $pos=1;
while(<IN2>){
	chomp;
	next if(/^>/);
	if(/^#/){
		$apcf=(split /\s+/,$_)[-1];
		$pos=1;
	}
	else{
		s/\-//g;
		my @tmp=split /\s+/,$_;
		foreach my $num(@tmp){
			next if($num eq "\$");
			my @arr=split /\t/,$hash{$num};
			my $len=$arr[2]-$arr[1]+1;
			my $tmp_pos=$pos+$len-1;
			print OUT "$num\tA$apcf\t$pos\t$tmp_pos\t+\t$hash{$num}\n";
			$pos=$tmp_pos;
		}
	}
}
