#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

my %Species;
open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"gzip -dc $ARGV[1] |") || die "Can't open IN2!\n";
open(IN3,"$ARGV[2]") || die "Can't open IN3!\n";
open(OUT,">$ARGV[3]") || die "Can't open OUT!\n";

while(<IN1>){
	chomp;
	$Species{$_}=1;
}

my %hash;
while(<IN2>){
	chomp;
	#next unless(/^Chr/);
	#s/Chr//g;
	my @tmp=split /\s+/,$_;
	my $chr=$tmp[0];
	$hash{$chr}{$tmp[1]}=1;
}

my $line;
my %Sites;
my $sumLen;
my %Fasta;
my $chr;
my %Ns;
my $judge;
my %Species_count;
while(<IN3>){
	chomp;
	next unless(/^s|^a/);
	$line++;
	if(/^a/){
		$line=1;
		if(%Sites){
			foreach my $spe(sort {$a cmp $b} keys %Species){
				next if(exists $Species_count{$spe});
				foreach my $key(sort {$a <=> $b} keys %Sites){
					$Fasta{$spe}.="-";
				}
			}
		}
		%Species_count=();
		%Sites=();
	}
	else{
		my @tmp=split /\s+/,$_;
		my $spe=(split /\./,$tmp[1])[0];
		$Species_count{$spe}=1;
		if($line==2){
			if($_=~ /Human/){
				$judge=1;
			}
			else{
				$judge=0;
			}
			next if($judge==0);
			$chr=(split /\./,$tmp[1])[1];
                        my $start=$tmp[2];
			my $end=$tmp[2]+$tmp[3]-1;
			%Ns=();
			my @seq=split //,$tmp[-1];
			for(my $i=0;$i<=$#seq;$i++){
				if($seq[$i] eq "-"){
					$Ns{$i}=1;
				}
			}
			foreach my $pos(sort {$a <=> $b} keys %{$hash{$chr}}){
				if($pos>=$start && $pos<=$end){
					my $index=$pos-$start;
					$Sites{$index}=1;
					#$sumLen++;
				}
			}
		}
		next if($judge==0);
		my @arr=split //,$tmp[-1];
		my $j=0;
		for(my $i=0;$i<=$#arr;$i++){
			if(exists $Ns{$i}){
				$j++;
			}
			my $k=$i-$j;
			if(exists $Sites{$k}){
				$Fasta{$spe}.=$arr[$i];
			}
		}
	}
}
foreach my $spe(sort {$a cmp $b} keys %Species){
	next if(exists $Species_count{$spe});
	foreach my $key(sort {$a <=> $b} keys %Sites){
		$Fasta{$spe}.="-";
	}
}
$sumLen=length($Fasta{"Human"});

print OUT " 37 $sumLen\n";
foreach my $spe(sort {$a cmp $b} keys %Fasta){
	#print OUT "$spe\t$Fasta{$spe}\n";
	my $spe_len=length($spe);
	my $new_name;
	if($spe_len<10){
		my $n_num=10-$spe_len;
		my $Ns=" " x $n_num;
		$new_name="$spe"."$Ns";
	}
	else{
		$new_name=substr($spe,0,10);
	}
	print OUT "$new_name\t$Fasta{$spe}\n";
}

