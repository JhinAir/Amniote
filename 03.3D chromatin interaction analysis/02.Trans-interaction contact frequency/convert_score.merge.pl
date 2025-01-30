#!/bin/perl
#use strict;
use List::Util qw/max min/;
use Statistics::Descriptive;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT,">>$ARGV[1]") || die "Can't open OUT!\n";

my %Species;
while(<IN>){
	chomp;
	my @tmp=split /\s+/,$_;
	$Species{$tmp[0]}=$tmp[1];
}
print OUT "spe\tclade\tchr1\tchr2\tsize1\tsize2\tsize3\torigin1\torigin2\torigin3\traw_score\tscore\n";
my $dir="/data/home/zhou3lab/liujing/Amniote/Deschrambler/Amniote/SynBlock";
opendir(DIR,"$dir") || die "Can't open DIR!\n";
my $file;
while($file=readdir(DIR)){
	if($file=~ /(.*).convert.score.txt\z/){
		my $spe=$1;
		my $type=$Species{$spe};
		open(INPUT,"$dir/$file") || die "Can't open INPUT!\n";
		my @array;
		my %Lines;
		my $count;
		while(<INPUT>){
			chomp;
			next if(/score/);
			my @tmp=split /\s+/,$_;
			next unless($tmp[0]=~ /chr/ && $tmp[1]=~ /chr/);
			next if($tmp[2]<=5 || $tmp[3]<=5 || $#tmp<8);
			push(@array,$tmp[-1]);
			$count++;
			$Lines{$count}=$_;
			#print OUT "$spe\t$type\t$_\n";
		}
		my $stat = Statistics::Descriptive::Full->new();
		$stat->add_data(@array);
		my $mean = $stat->mean();
		my $sd = $stat->standard_deviation();
		foreach my $i(sort {$a <=> $b} keys %Lines){
			my @tmp=split /\s+/,$Lines{$i};
			my $score=sprintf "%.4f",($tmp[-1]-$mean)/$sd;
			print OUT "$spe\t$type\t$tmp[0]\t$tmp[1]\t$tmp[2]\t$tmp[3]\t$tmp[4]\t$tmp[5]\t$tmp[6]\t$tmp[7]\t$tmp[8]\t$score\n";
		}
	}
}
