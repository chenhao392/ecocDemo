#!/usr/bin/perl

use strict;
use warnings;

my $singleCellExpFile=$ARGV[0];
my $ppiFile=$ARGV[1];
my $cutOff=$ARGV[2];
my $index=$ARGV[3]?$ARGV[3]:"7";
$index--;
my %id;
open FILE, "<$singleCellExpFile" or die "$!\n";
while(<FILE>){
	if($. == 1){
		next;
	}
	chomp;
	my ($id,@l)=split(/\t/,$_);
	if($l[$index] >$cutOff){
		$id{$id}="";
	}
}
close FILE;


open FILE, "<$ppiFile" or die "$!\n";
while(<FILE>){
	my ($a,$b,$v)=split;
	if(defined $id{$a} && defined $id{$b}){
			print "$a\t$b\t$v\n";
	}
}
close FILE;
