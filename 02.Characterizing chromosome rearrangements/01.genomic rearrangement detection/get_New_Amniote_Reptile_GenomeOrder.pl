#!/usr/bin/perl
use strict;
use List::Util qw/max min sum/;
#use Statistics::Descriptive;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";##Amniote
open(IN3,"$ARGV[2]") || die "Can't open IN2!\n";##Reptile
open(OUT,">$ARGV[3]") || die "Can't open OUT!\n";

my (%hash1,%hash2);
my $count;
while(<IN1>){
	chomp;
	next if(/^Reptile/);
	my @tmp=split /\s+/,$_;
	$count++;
	$hash1{$tmp[1]}=$count;
	$hash2{$tmp[0]}=$count;
}

while(<IN2>){
	chomp;
	if(/^\>/){
		print OUT ">Amniote\n";
	}
	elsif(/^#/){
		s/ APCF//g;
		print OUT "$_\n";
	}
	else{
		my @tmp=split /\s+/,$_;
		for(my $i=0;$i<=$#tmp-1;$i++){
			my $block=$tmp[$i];
			$block=~ s/\-//g;
			next unless(exists $hash1{$block});
			if($tmp[$i]=~ /^\-/){
				print OUT "-$hash1{$block} ";
			}
			else{
				print OUT "$hash1{$block} ";
			}
		}
		print OUT "\$\n";
	}
}

while(<IN3>){
	chomp;
	if(/^\>/){
		print OUT ">Reptile\n";
	}
	elsif(/^#/){
		s/ APCF//g;
		print OUT "$_\n";
	}
	else{
		my @tmp=split /\s+/,$_;
		for(my $i=0;$i<=$#tmp-1;$i++){
			my $block=$tmp[$i];
			$block=~ s/\-//g;
			next unless(exists $hash2{$block});
			if($tmp[$i]=~ /^\-/){
				print OUT "-$hash2{$block} ";
			}
			else{
				print OUT "$hash2{$block} ";
			}
		}
		print OUT "\$\n";
	}
}
