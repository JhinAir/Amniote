#!/usr/bin/perl
use strict;
use List::Util qw/max min sum/;
#use Statistics::Descriptive;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT,">$ARGV[1]") || die "Can't open OUT!\n";

my $dir="/slurm/home/zju/zhanglab/liujing/Project/Amniote/Deschrambler/Amniote/Amniote_300Kb_r2/ALG_connection";
opendir(DIR,"$dir") || die "Can't open DIR!\n";
my $file;
my (%hash1,%hash2);
while($file=readdir(DIR)){
	if($file=~ /Amniote.(.*).blocks.txt\z/){
		my $spe=$1;
		open(INPUT,"$dir/$file") || die "Can't open INPUT!\n";
		while(<INPUT>){
			chomp;
			next if(/^Block/);
			my @tmp=split /\s+/,$_;
			$tmp[1]=~ s/A//g;
			next if($tmp[5] eq "NA");
			$hash1{$spe}{$tmp[1]}+=$tmp[3]-$tmp[2];
			$hash2{$spe}{$tmp[5]}{$tmp[1]}+=$tmp[3]-$tmp[2];
		}
	}
}
my %Chrom;
while(<IN>){
	chomp;
	my @tmp=split /\s+/,$_;
	$Chrom{$tmp[4]}{$tmp[0]}{$tmp[2]}=int($tmp[-1]/0.02)+1;
}

my (%out1,%out2);
foreach my $clade(sort {$a cmp $b} keys %Chrom){
	foreach my $spe(sort {$a cmp $b} keys %{$Chrom{$clade}}){
		foreach my $chr(sort {$a cmp $b} keys %{$Chrom{$clade}{$spe}}){
			my $index=$Chrom{$clade}{$spe}{$chr};
			for(my $a=1;$a<=44;$a++){
				my $ratio=0;
				if($hash1{$spe}{$a}>0){
					$out1{$clade}{$index}{$a}++;
					if(exists $hash2{$spe}{$chr}{$a}){
						$ratio=$hash2{$spe}{$chr}{$a}/$hash1{$spe}{$a} if($hash1{$spe}{$a}>0);
						$out2{$clade}{$index}{$a}+=$ratio;
					}
				}
			}
		}
	}
}

foreach my $clade(sort {$a cmp $b} keys %out1){
	for(my $ind=1;$ind<=51;$ind++){
	#foreach my $ind(sort {$a <=> $b} keys %{$out1{$clade}}){
		for(my $i=1;$i<=44;$i++){
			my $ave=0;
			if(exists $out1{$clade}{$ind}{$i}>0){
				$ave=sprintf "%.4f", $out2{$clade}{$ind}{$i}/$out1{$clade}{$ind}{$i};
			}
			print OUT "$clade\t$ind\t$i\t$ave\n";
		}
	}
}
