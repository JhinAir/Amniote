#!/usr/bin/perl
use strict;
use List::Util qw/max min sum/;
#use Statistics::Descriptive;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
my $cutoff=$ARGV[1];
open(OUT,">$ARGV[2]") || die "Can't open OUT!\n";

my (%hash1,%hash2,%hash3);
my (%Block1,%Block2);
while(<IN>){
	chomp;
	next if(/^Block/);
	my @tmp=split /\s+/,$_;
	next if($tmp[5] eq "NA");
	$Block1{$tmp[5]}{$tmp[6]}=$tmp[7];
	$Block2{$tmp[5]}{$tmp[6]}=$tmp[1];
	$hash1{$tmp[1]}+=$tmp[7]-$tmp[6];
	$hash2{$tmp[5]}{$tmp[1]}+=$tmp[7]-$tmp[6];
	$hash3{$tmp[5]}+=$tmp[7]-$tmp[6];
}

my $CHR;
my $ALG;
my %TMP_ALG;
foreach my $chr(sort {$a cmp $b} keys %Block1){
	foreach my $start(sort {$a <=> $b} keys %{$Block1{$chr}}){
		my $end=$Block1{$chr}{$start};
		my $alg=$Block2{$chr}{$start};
		if($ALG eq ""){
			$CHR=$chr;
			$ALG=$alg;
			$TMP_ALG{$chr}{$ALG}{1}=$start;
			$TMP_ALG{$chr}{$ALG}{2}=$end;
		}
		else{
			if($CHR ne $chr){
				$CHR=$chr;
				$ALG=$alg;
				$TMP_ALG{$chr}{$ALG}{1}=$start;
				$TMP_ALG{$chr}{$ALG}{2}=$end;
			}
			else{
				if($ALG eq $alg){
					$TMP_ALG{$chr}{$ALG}{2}=$end;
				}
				else{
					$ALG=$alg;
					if(exists $TMP_ALG{$chr}{$ALG}){
						$TMP_ALG{$chr}{$ALG}{2}=$end;
					}
					else{
						$TMP_ALG{$chr}{$ALG}{1}=$start;
						$TMP_ALG{$chr}{$ALG}{2}=$end;
					}
				}
			}
		}
	}
}

my %TMP_hash;
foreach my $chr(sort {$a cmp $b} keys %TMP_ALG){
	foreach my $key(sort {$a cmp $b} keys %{$TMP_ALG{$chr}}){
		my $mid_pos=($TMP_ALG{$chr}{$key}{1}+$TMP_ALG{$chr}{$key}{2})/2;
		$TMP_hash{$chr}{$mid_pos}=$key;
	}
}

print OUT "chr\tALG:ALG_perc:chr_perc\n";
foreach my $chr1(sort {$a cmp $b} keys %hash2){
	next unless($chr1=~ /chr/);
	print OUT "$chr1";
	foreach my $pos(sort {$a <=> $b} keys %{$TMP_hash{$chr1}}){
		my $chr2=$TMP_hash{$chr1}{$pos};
		my $ratio1=sprintf "%.2f", $hash2{$chr1}{$chr2}/$hash1{$chr2} if($hash1{$chr2}>0);
		my $ratio2=sprintf "%.2f",$hash2{$chr1}{$chr2}/$hash3{$chr1} if($hash3{$chr1}>0);
		if($ratio1>=$cutoff || $ratio2>=$cutoff){
			print OUT "\tF_$chr2:$ratio1:$ratio2";
		}
		else{
			print OUT "\tT_$chr2:$ratio1:$ratio2";
		}
	}
	print OUT "\n";
}

