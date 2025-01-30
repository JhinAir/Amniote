#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
my $cutoff=$ARGV[2];
open(OUT,">$ARGV[3]") || die "Can't open OUT!\n";

my %Blocks;
while(<IN1>){
	chomp;
	next if(/^Block/);
	my @tmp=split /\s+/,$_;
	my $pos1=$tmp[6]-2;
	my $pos2=$tmp[7]+2;
	$Blocks{$tmp[5]}{$pos1}="$tmp[0]\tUP\t$tmp[1]";
	$Blocks{$tmp[5]}{$pos2}="$tmp[0]\tDOWN\t$tmp[1]";
}

my (%hash1,%hash2);
while(<IN2>){
	chomp;
	my @tmp=split /\s+/,$_;
	my $pos1=$tmp[4]-2;
	my $pos2=$tmp[5]+2;
	$hash1{$tmp[3]}{$pos1}=$Blocks{$tmp[3]}{$pos1};
	$hash1{$tmp[3]}{$pos2}=$Blocks{$tmp[3]}{$pos2};
	$hash2{$tmp[3]}{$tmp[4]}=$tmp[5];
}

my ($tmp_chr,$tmp_pos);
my @EBR_len;
my %EBRs;
foreach my $chr(sort {$a cmp $b} keys %hash2){
	foreach my $pos(sort {$a <=> $b} keys %{$hash2{$chr}}){
		if($tmp_chr eq ""){
			$tmp_chr=$chr;
			$tmp_pos=$hash2{$chr}{$pos};
		}
		else{
			if($tmp_chr ne $chr){
				$tmp_chr=$chr;
				$tmp_pos=$hash2{$chr}{$pos};
			}
			else{
				my $len=$pos-$tmp_pos;
				#print "$len\n";
				push(@EBR_len,$len);
				$EBRs{$chr}{$pos-2}=$len;
				$EBRs{$chr}{$tmp_pos+2}=$len;
				$tmp_pos=$hash2{$chr}{$pos};
			}
		}
	}
}
my @EBR_sort=sort {$a <=> $b} @EBR_len;
my $index=int(($#EBR_sort+1)*(1-$cutoff));
my $EBR_cutoff=$EBR_sort[$index];
print "$EBR_cutoff\n";

foreach my $chr(sort {$a cmp $b} keys %hash1){
	foreach my $pos(sort {$a <=> $b} keys %{$hash1{$chr}}){
		next unless(exists $EBRs{$chr}{$pos});
		next if($EBRs{$chr}{$pos}>$EBR_cutoff);
		print OUT "$chr\t$pos\t$EBRs{$chr}{$pos}\t$Blocks{$chr}{$pos}\n";
	}
}
