#!/usr/bin/perl

use strict;
use warnings;

my @gene;
my %pair;
loadIndex($ARGV[0]);
loadPair($ARGV[0]);

foreach my $pair(sort keys %pair){
	print "$pair\t$pair{$pair}\n" if $pair{$pair} >$ARGV[1];
}



sub loadPair{
	open FILE, "<$_[0]" or die "$!\n";
	while(<FILE>){
		chomp;
		my ($gene,@l)=split(/\t/,$_);
		my $j=$. -1;
		for (my $i=0;$i<scalar(@l);$i++){
			if($i >$j){
				$pair{"$gene[$j]\t$gene[$i]"}=$l[$i];
			}
		}
	}
	close FILE;
}



sub loadIndex{
	open FILE, "<$_[0]" or die "$!\n";
	while(<FILE>){
		chomp;
		my ($gene)=split(/\t/,$_);
		push @gene,$gene;
	}
	close FILE;
}


