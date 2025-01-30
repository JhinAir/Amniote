#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT,">$ARGV[1]") || die "Can't open OUT!\n";

my %Block;
my $block_count;
my ($tmp_chr,$tmp_pos1,$tmp_pos2,$tmp_strand,$tmp_r_chr,$tmp_r_pos1,$tmp_r_pos2);
my $count;
my %INPUT;
my %POS;
while(<IN>){
	chomp;
	next if(/^Block/);
	my @tmp=split /\s+/,$_;
	next if($tmp[5] eq "NA");
	my $pos=($tmp[6]+$tmp[7])/2;
	$POS{$tmp[5]}{$pos}=1;
	$count++;
	$INPUT{$count}=$_;
}

foreach my $key(sort {$a <=> $b} keys %INPUT){
	my @tmp=split /\s+/,$INPUT{$key};
	my ($chr,$pos1,$pos2,$strand,$r_chr,$r_pos1,$r_pos2);
	$r_chr=$tmp[1];
	$r_pos1=$tmp[2];
	$r_pos2=$tmp[3];
	$chr=$tmp[5];
	$pos1=$tmp[6];
	$pos2=$tmp[7];
	$strand=$tmp[-1];
	if($tmp_chr eq ""){
		$tmp_r_chr=$r_chr;
		$tmp_r_pos1=$r_pos1;
		$tmp_r_pos2=$r_pos2;
		$tmp_chr=$chr;
		$tmp_pos1=$pos1;
		$tmp_pos2=$pos2;
		$tmp_strand=$strand;
		$block_count++;
		$Block{$block_count}="$tmp_r_chr\t$tmp_r_pos1\t$tmp_r_pos2\t$tmp_chr\t$tmp_pos1\t$tmp_pos2\t$tmp_strand";
	}
	else{
		if($tmp_r_chr eq $r_chr && $tmp_chr eq $chr && $tmp_strand eq $strand){
			my $mid1=($pos1+$pos2)/2;
			my $mid2=($tmp_pos1+$tmp_pos2)/2;
			my $judge=0;
			foreach my $ttt(sort {$a <=> $b} keys %{$POS{$chr}}){
				if(($ttt>$mid1 && $ttt<$mid2) || ($ttt<$mid1 && $ttt>$mid2)){
					$judge=1;
				}
			}
			if((($strand eq "+" && $tmp_pos2<=$pos1+50000) || ($strand eq "-" && $tmp_pos1>=$pos2-50000)) && $judge!=1){
				my @arr=sort {$a <=> $b} ($tmp_pos1,$tmp_pos2,$pos1,$pos2);
				$tmp_pos1=$arr[0];
				$tmp_pos2=$arr[-1];
				$tmp_r_pos2=$r_pos2;
				delete $POS{$chr}{$mid1};
				delete $POS{$chr}{$mid2};
				my $mid3=($tmp_pos1+$tmp_pos2)/2;
				$POS{$chr}{$mid3}=1;
				$Block{$block_count}="$tmp_r_chr\t$tmp_r_pos1\t$tmp_r_pos2\t$tmp_chr\t$tmp_pos1\t$tmp_pos2\t$tmp_strand";
			}
			else{
				$tmp_chr=$chr;
				$tmp_r_pos1=$r_pos1;
				$tmp_r_pos2=$r_pos2;
				$tmp_pos1=$pos1;
				$tmp_pos2=$pos2;
				$tmp_strand=$strand;
				$block_count++;
				$Block{$block_count}="$tmp_r_chr\t$tmp_r_pos1\t$tmp_r_pos2\t$tmp_chr\t$tmp_pos1\t$tmp_pos2\t$tmp_strand";
			}
		}
		else{
			$tmp_r_chr=$r_chr;
			$tmp_r_pos1=$r_pos1;
			$tmp_r_pos2=$r_pos2;
			$tmp_chr=$chr;
			$tmp_pos1=$pos1;
			$tmp_pos2=$pos2;
			$tmp_strand=$strand;
			$block_count++;
			$Block{$block_count}="$tmp_r_chr\t$tmp_r_pos1\t$tmp_r_pos2\t$tmp_chr\t$tmp_pos1\t$tmp_pos2\t$tmp_strand";
		}
	}
}

foreach my $key(sort {$a <=> $b} keys %Block){
	print OUT "$Block{$key}\n";
}

