#!/usr/bin/perl
use strict;
use List::Util qw/max min sum/;
#use Statistics::Descriptive;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
open(OUT,">$ARGV[2]") || die "Can't open OUT!\n";

my (%hash1,%hash2);
while(<IN1>){
	chomp;
	next if(/^Block/);
	my @tmp=split /\s+/,$_;
	$hash1{$tmp[5]}{$tmp[6]}=$tmp[7];
	$hash2{$tmp[5]}{$tmp[6]}=$tmp[0];
}

print OUT "Reptile\tAmniote\n";
my (%Block1,%Block2);
while(<IN2>){
	chomp;
	next if(/^Block/);
	my @tmp=split /\s+/,$_;
	my ($overlap,$block);
	foreach my $pos1(sort {$a <=> $b} keys %{$hash1{$tmp[5]}}){
		last if($pos1>$tmp[7]);
		my $pos2=$hash1{$tmp[5]}{$pos1};
		if($pos1<=$tmp[7] && $pos2>=$tmp[6]){
			my $tmp_len=min($tmp[7],$pos2)-max($tmp[6],$pos1);
			if($tmp_len>=$overlap){
				$overlap=$tmp_len;
				$block=$hash2{$tmp[5]}{$pos1};
			}
		}
	}
	next if($overlap eq "");
	my $ratio=$overlap/($tmp[7]-$tmp[6]) if($tmp[7]-$tmp[6]>0);
	next unless($ratio>=0.4);
	if(exists $Block1{$block}){
		if($overlap>$Block1{$block}){
			$Block1{$block}=$overlap;
			$Block2{$block}=$tmp[0];
		}
	}
	else{
		$Block1{$block}=$overlap;
		$Block2{$block}=$tmp[0];
	}
}

foreach my $key(sort {$a <=> $b} keys %Block2){
	print OUT "$Block2{$key}\t$key\n";
}
