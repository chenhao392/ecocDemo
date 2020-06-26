#!/usr/bin/perl

use strict;
use warnings;

my $dataFile=$ARGV[0];
my $stringIdMapFile=$ARGV[1];
my $ncbiIdMapFile=$ARGV[2]?$ARGV[2]:"";
my $ncbiIdMapIdx=$ARGV[3]?$ARGV[3]:"18,14";

my %gene;
my %map;

open FILE, "<$stringIdMapFile" or die "$!\n";
while(<FILE>){
	chomp;
	my @line=split(/\t/,$_);
	$gene{$line[1]}=$line[1];
}
close FILE;

if($ncbiIdMapFile){
	my ($from,$to)=split(/,/,$ncbiIdMapIdx);
	open FILE, "<$ncbiIdMapFile" or die "$!\n";
	while(<FILE>){
		if($. ==1){next;}
		chomp;
		my @l=split(/\t/,$_);
		if(defined $l[$from+1]){
			my @id=split(/,/,$l[$from+1]);
			foreach my $id(@id){
				$map{$id}=$l[$to];
			}
			$map{$l[$from+1]}=$l[$to];
		}
		if(defined $l[$from+2]){
			my @id=split(/,/,$l[$from+2]);
			foreach my $id(@id){
				$map{$id}=$l[$to];
			}
			$map{$l[$from+2]}=$l[$to];
		}
		$map{$l[$from]}=$l[$to];
		#die "$l[$from]\t$l[$to]\n";
	}
close FILE;
}

open FILE, "<$dataFile" or die "$!\n";
while(<FILE>){
	chomp;
	if($. == 1){print "$_\n";next;}
	my @l=split(/\t/,$_);
	my $id=$l[0];
	$id=~s/.*?\_//;
	#die "$id\t$l[0]\n";
	if(defined $gene{$id}){
		print "$id";
		for my $i(1..9){
			print "\t$l[$i]";
		}
		print "\n";
	}elsif(defined $map{$id} && defined $gene{$map{$id}}){
		print "$gene{$map{$id}}";
		for my $i(1..9){
			print "\t$l[$i]";
		}
		print "\n";
	}
	else{
		warn "$id not in $stringIdMapFile and $ncbiIdMapFile\n";
	}
}
close FILE;
