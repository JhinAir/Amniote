#!/usr/bin/perl
use strict;
use List::Util qw/max min sum/;
#use Statistics::Descriptive;

my $spe1=$ARGV[0];
open(IN1,"$spe1.Genome_block_order") || die "Can't open IN1!\n";
my $spe2=$ARGV[1];
open(IN2,"$spe2.Genome_block_order") || die "Can't open IN2!\n";
open(OUT,">$spe1.$spe2.aligned_blocks.txt") || die "Can't open OUT!\n";
open(OUT2,">$spe1.$spe2.new_block_number") || die "Can't open OUT2!\n";

my ($count1,$count2);
my (%hash1,%hash2);
my (%Block1,%Block2);
my (%Chrom1,%Chrom2);
while(<IN1>){
	chomp;
	next if(/^\>/);
	if(/^#/){
		s/\# APCF //g;
		$count1++;
		$Chrom1{$count1}="# $_";
	}
	else{

		my @tmp=split /\s+/,$_;
		$hash1{$count1}=$_;
		foreach my $key(@tmp){
			next if($key eq "\$");
			$key=~ s/\-//g;
			$Block1{$key}=1;
		}
	}
}

while(<IN2>){
	chomp;
	next if(/^\>/);
	if(/^#/){
		s/\#//g;
		s/ APCF //g;
		s/chr//g;
		$count2++;
		$Chrom2{$count2}="# $_";
	}
	else{
		my @tmp=split /\s+/,$_;
		$hash2{$count2}=$_;
		foreach my $key(@tmp){
			next if($key eq "\$");
			$key=~ s/\-//g;
			if(exists $Block1{$key}){
				$Block2{$key}=1;
			}
		}
	}
}

my %Block3;
my $count;
print OUT2 "Raw\tNew\n";
foreach my $key(sort {$a <=> $b} keys %Block2){
	$count++;
	$Block3{$key}=$count;
	print OUT2 "$key\t$count\n";
}

print OUT ">$spe1\n";
foreach my $chr(sort {$a <=> $b} keys %hash1){
	print OUT "$Chrom1{$chr}\n";
	my @tmp=split /\s+/,$hash1{$chr};
	foreach my $key1(@tmp){
		my $key2=$key1;
		$key2=~ s/\-//g;
		if(exists $Block3{$key2}){
			$key1=~ s/$key2/$Block3{$key2}/;
			print OUT "$key1 ";
		}
	}
	print OUT "\$\n";
}
print OUT "\n";
print OUT ">$spe2\n";
foreach my $chr(sort {$a <=> $b} keys %hash2){
	print OUT "$Chrom2{$chr}\n";
	my @tmp=split /\s+/,$hash2{$chr};
	foreach my $key1(@tmp){
		my $key2=$key1;
		$key2=~ s/\-//g;
		if(exists $Block3{$key2}){
			$key1=~ s/$key2/$Block3{$key2}/;
			print OUT "$key1 ";
		}
	}
	print OUT "\$\n";
}
