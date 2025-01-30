#!/usr/bin/perl
use strict;
use List::Util qw/max min sum/;
#use Statistics::Descriptive;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT1,">$ARGV[1]") || die "Can't open OUT1!\n";
open(OUT2,">$ARGV[2]") || die "Can't open OUT2!\n";

my %hash;
while(<IN>){
	chomp;
	next if(/ALG/);
	s/A//g;
	my @tmp=split /\s+/,$_;
	my ($tmp_alg,$tmp_type);
	my $fus_count;
	print OUT1 "$tmp[0]";
	for(my $i=1;$i<=$#tmp;$i++){
		my ($type,$alg)=split /\_/,(split /\:/,$tmp[$i])[0];
		if($type eq "F"){
			$fus_count++;
			$hash{$tmp[0]}{$fus_count}=$tmp[$i];
		}
		if($tmp_alg eq ""){
			$tmp_alg=$alg;
			$tmp_type=$type;
		}
		else{
			if($tmp_type eq "F" && $type eq "F"){
				$tmp_alg=$alg;
				$tmp_type=$type;
			}
			else{
				my @arr=sort {$a <=> $b} ($alg,$tmp_alg);
				print OUT1 "\t$arr[0]\_$arr[1]";
				$tmp_alg=$alg;
				$tmp_type=$type;
			}
		}
	}
	print OUT1 "\n";
}

foreach my $chr(sort {$a cmp $b} keys %hash){
	print OUT2 "$chr";
	my $tmp_alg;
	foreach my $count(sort {$a <=> $b} keys %{$hash{$chr}}){
		my ($type,$alg)=split /\_/,(split /\:/,$hash{$chr}{$count})[0];
		if($tmp_alg eq ""){
			$tmp_alg=$alg;
		}
		else{
			my @arr=sort {$a <=> $b} ($alg,$tmp_alg);
			print OUT2 "\t$arr[0]\_$arr[1]";
			$tmp_alg=$alg;
		}
	}
	print OUT2 "\n";
}
