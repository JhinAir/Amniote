#!/usr/bin/perl
use strict;
use List::Util qw/max min sum/;
#use Statistics::Descriptive;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
my $spe=(split /\./,$ARGV[1])[1];
open(OUT,">Amniote.$spe.ALG_ALG_percentage.txt") || die "Can't open OUT!\n";

my (%ALG_size,%ALG_type,%ALG_len);
while(<IN1>){
	chomp;
	my @tmp=split /\s+/,$_;
	$ALG_size{$tmp[0]}=$tmp[1];
	$ALG_type{$tmp[0]}=$tmp[2];
	$ALG_len{$tmp[2]}+=$tmp[1];
}

my %hash;
while(<IN2>){
	chomp;
	next if(/ALG/);
	my @tmp=split /\s+/,$_;
	my ($core,$perc,$index);
	for(my $i=1;$i<=$#tmp;$i++){
		my ($alg,$p1,$p2)=split /\:/,(split /\_/,$tmp[$i])[1];
		if($p2>$perc){
			$perc=$p2;
			$core=$alg;
			$index=$i;
		}
	}
	my %TMP_hash;
	for(my $i=1;$i<=$#tmp-1;$i++){
		my ($alg_1,$p1_1,$p2_1)=split /\:/,(split /\_/,$tmp[$i])[1];
		my $type1=$ALG_type{$alg_1};
		my ($alg_2,$p1_2,$p2_2)=split /\:/,(split /\_/,$tmp[$i+1])[1];
		my $type2=$ALG_type{$alg_2};
		if($alg_1 eq $core){
			$hash{$type2}{$type1}+=$p1_2*$ALG_size{$alg_2};
		}
		elsif($alg_2 eq $core){
			$hash{$type1}{$type2}+=$p1_1*$ALG_size{$alg_1};
		}
		else{
			if($i<$index){
				$hash{$type1}{$type2}+=$p1_1*$ALG_size{$alg_1};
			}
			else{
				$hash{$type2}{$type1}+=$p1_2*$ALG_size{$alg_2};
			}
		}
	}
}
foreach my $type1(sort {$a cmp $b} keys %hash){
	my $len=$ALG_len{$type1};
	foreach my $type2(sort {$a cmp $b} keys %{$hash{$type1}}){
		my $ratio=0;
		if(exists $hash{$type1}{$type2}){
			$ratio=$hash{$type1}{$type2}/$len if($len>0);
		}
		print OUT "$type1\t$type2\t$ratio\n";
	}
}

