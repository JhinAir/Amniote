#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

#my $species=$ARGV[0];
open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
my $bin_size=$ARGV[2];
my $species=(split /\_/,$ARGV[1])[0];
#my $cutoff=$ARGV[4];
#system "mkdir $species";
my $hic=$ARGV[1];
#open(OUT,">$species.trans.oe.$bin_size\_$cutoff.matrix") || die "Can't open OUT!\n";

my %Chrom;
my $chr_count;
while(<IN1>){
	chomp;
	s/Chr//g;
	my @tmp=split /\s+/,$_;
	$chr_count++;
	$Chrom{$chr_count}=$tmp[0];
}

foreach my $i(sort {$a <=> $b} keys %Chrom){
	foreach my $j(sort {$a <=> $b} keys %Chrom){
		next if($j<=$i);
		my $chr1=$Chrom{$i};
		my $chr2=$Chrom{$j};
		system "java -jar /data/home/zhou3lab/zhangxinpei/share/project/03.jing/Software/juicer_tools_1.22.01.jar dump oe KR $hic $chr1 $chr2 BP $bin_size ./$species/$chr1\_$chr2\_$bin_size.oe.matrix";
=pod
		open(OE,"./$species/$chr1\_$chr2\_$bin_size.oe.matrix") || die "Can't open OE!\n";
		while(<OE>){
			chomp;
			my @tmp=split /\s+/,$_;
			if($tmp[-1]>=3){
				print OUT "$chr1\t$tmp[0]\t$chr2\t$tmp[1]\t$tmp[-1]\n";
			}
		}
		close OE;
=cut
	}
}
