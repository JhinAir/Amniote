#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
open(OUT,">$ARGV[2]") || die "Can't open OUT!\n";

my %Matrix;
while(<IN1>){
	chomp;
	s/chr//g;
	my @tmp=split /\s+/,$_;
	$Matrix{$tmp[0]}{$tmp[1]}{$tmp[2]}{$tmp[3]}=$tmp[4];
	#$Matrix{$tmp[2]}{$tmp[3]}{$tmp[0]}{$tmp[1]}=$tmp[4];
}

my %Bin;
while(<IN2>){
	chomp;
	s/chr//g;
	my @tmp=split /\s+/,$_;
	$Bin{$tmp[0]}{$tmp[1]}=$tmp[-1];
}

my (%hash1,%hash2);
foreach my $chr1(sort {$a <=> $b} keys %Bin){
	foreach my $win1(sort {$a <=> $b} keys %{$Bin{$chr1}}){
		foreach my $chr2(sort {$a <=> $b} keys %Bin){
			next if($chr1 eq $chr2);
			foreach my $win2(sort {$a <=> $b} keys %{$Bin{$chr2}}){
				for(my $i=-50;$i<=50;$i++){
					my $pos1=$win1+$i*100000;
					for(my $j=-50;$j<=50;$j++){
						$hash1{$i}{$j}++;
						$hash1{$j}{$i}++;
						my $pos2=$win2+$j*100000;
						if(exists $Matrix{$chr1}{$pos1}{$chr2}{$pos2}){
							$hash2{$i}{$j}+=$Matrix{$chr1}{$pos1}{$chr2}{$pos2};
							$hash2{$j}{$i}+=$Matrix{$chr1}{$pos1}{$chr2}{$pos2};
						}
					}
				}
			}
		}
	}
}

foreach my $i(sort {$a <=> $b} keys %hash1){
	foreach my $j(sort {$a <=> $b} keys %{$hash1{$i}}){
		my $ave=$hash2{$i}{$j}/$hash1{$i}{$j} if($hash1{$i}{$j}>0);
		print OUT "$i\t$j\t$hash1{$i}{$j}\t$hash2{$i}{$j}\t$ave\n";
	}
}
