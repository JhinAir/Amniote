#!/usr/bin/perl
use strict;
use List::Util qw/max min sum/;
#use Statistics::Descriptive;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
open(OUT1,">$ARGV[2]") || die "Can't open OUT1!\n";
open(OUT2,">$ARGV[3]") || die "Can't open OUT2!\n";

my %ALG_type;
my %ALG_size;
while(<IN1>){
	chomp;
	s/A//g;
	my @tmp=split /\s+/,$_;
	$ALG_type{$tmp[0]}=$tmp[-1];
	$ALG_size{$tmp[0]}=$tmp[1];
}

my (%Clade1,%Clade2);
my (%Clade_count1,%Clade_count2);
my %Species;
while(<IN2>){
	chomp;
	my @tmp=split /\s+/,$_;
	$Clade1{$tmp[0]}=$tmp[1];
	$Clade2{$tmp[0]}=$tmp[-1];
	if(!exists $Species{$tmp[0]}){
		$Clade_count1{$tmp[1]}++;
		$Clade_count2{$tmp[-1]}++;
		$Species{$tmp[0]}=1;
	}
}

my $dir="/slurm/home/zju/zhanglab/liujing/Project/Amniote/Deschrambler/Amniote/Amniote_300Kb_r2/ALG_connection";
opendir(DIR,"$dir") || die "Can't open DIR!\n";
my $file;
my (%Fusion1,%Fusion2);
my (%Trans1,%Trans2);
while($file=readdir(DIR)){
	if($file=~ /(.*).fusion.out\z/){
		my $spe=$1;
		my $clade1=$Clade1{$spe};
		my $clade2=$Clade2{$spe};
		my %TMPCount;
		open(INPUT1,"$dir/$file") || die "Can't open INPUT1!\n";
		while(<INPUT1>){
			chomp;
			my @tmp=split /\s+/,$_;
			for(my $i=1;$i<=$#tmp;$i++){
				my ($alg1,$alg2)=split /\_/,$tmp[$i];
				if(!exists $TMPCount{$alg1}{$alg2}){
					$Fusion1{$alg1}{$alg2}{$clade1}++;
					$Fusion2{$alg1}{$alg2}{$clade2}++;
					$TMPCount{$alg1}{$alg2}=1;
				}
			}
		}
	}
	if($file=~ /(.*).trans.out\z/){
		my $spe=$1;
		my $clade1=$Clade1{$spe};
		my $clade2=$Clade2{$spe};
		open(INPUT1,"$dir/$file") || die "Can't open INPUT1!\n";
		while(<INPUT1>){
			chomp;
			my @tmp=split /\s+/,$_;
			for(my $i=1;$i<=$#tmp;$i++){
				my ($alg1,$alg2)=split /\_/,$tmp[$i];
				$Trans1{$alg1}{$alg2}{$clade1}++;
				$Trans2{$alg1}{$alg2}{$clade2}++;
			}
		}
	}
}

for(my $alg1=1;$alg1<=44;$alg1++){
	for(my $alg2=1;$alg2<=44;$alg2++){
		#my $type="$ALG_type{$alg1}\_$ALG_type{$alg2}";
		print OUT1 "A$alg1\tA$alg2\t$ALG_size{$alg1}\t$ALG_size{$alg2}\t$ALG_type{$alg1}\t$ALG_type{$alg2}";
		print OUT2 "A$alg1\tA$alg2\t$ALG_size{$alg1}\t$ALG_size{$alg2}\t$ALG_type{$alg1}\t$ALG_type{$alg2}";
		foreach my $clade(sort {$a cmp $b} keys %Clade_count1){
			my $num=$Clade_count1{$clade};
			next if($num<=0);
			my $F_count=0;
			my $F_ave=0;
			my $T_count=0;
			my $T_ave=0;
			if(exists $Fusion1{$alg1}{$alg2}{$clade}){
				$F_count=$Fusion1{$alg1}{$alg2}{$clade};
				$F_ave=$F_count/$num;
			}
			if(exists $Trans1{$alg1}{$alg2}{$clade}){
				$T_count=$Trans1{$alg1}{$alg2}{$clade};
				$T_ave=$T_count/$num;
			}
			print OUT1 "\t$clade\t$num\t$F_count\t$F_ave";
			print OUT2 "\t$clade\t$num\t$T_count\t$T_ave";
		}
		foreach my $clade(sort {$a cmp $b} keys %Clade_count2){
			my $num=$Clade_count2{$clade};
			next if($num<=0);
			my $F_count=0;
			my $F_ave=0;
			my $T_count=0;
			my $T_ave=0;
			if(exists $Fusion2{$alg1}{$alg2}{$clade}){
				$F_count=$Fusion2{$alg1}{$alg2}{$clade};
				$F_ave=$F_count/$num;
			}
			if(exists $Trans2{$alg1}{$alg2}{$clade}){
				$T_count=$Trans2{$alg1}{$alg2}{$clade};
				$T_ave=$T_count/$num;
			}
			print OUT1 "\t$clade\t$num\t$F_count\t$F_ave";
			print OUT2 "\t$clade\t$num\t$T_count\t$T_ave";
		}
		print OUT1 "\n";
		print OUT2 "\n";
	}
}

