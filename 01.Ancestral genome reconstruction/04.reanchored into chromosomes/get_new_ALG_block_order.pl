#!/usr/bin/perl
use strict;
use List::Util qw/max min sum/;
#use Statistics::Descriptive;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
open(OUT,">$ARGV[2]") || die "Can't open OUT!\n";

my %hash;
while(<IN1>){
	chomp;
	next if(/Amniote/);
	my @tmp=split /\s+/,$_;
	$hash{$tmp[1]}=$tmp[0];
}

while(<IN2>){
	chomp;
	if(/^\>|^#/){
		print OUT "$_\n";
	}
	else{
		my @tmp=split /\s+/,$_;
		for(my $i=0;$i<=$#tmp-1;$i++){
			my $new_num;
			if($tmp[$i]=~ /\-/){
				$tmp[$i]=~ s/\-//g;
				if(exists $hash{$tmp[$i]}){
					$new_num="\-$hash{$tmp[$i]}";
				}
			}
			else{
				if(exists $hash{$tmp[$i]}){
					$new_num=$hash{$tmp[$i]};
				}
			}
			next if($new_num eq "");
			print OUT "$new_num ";
		}
		print OUT "\$\n";
	}
}
