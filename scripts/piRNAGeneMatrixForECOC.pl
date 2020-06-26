#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw(max);

my %stringDbGene;#string db genes
my %cLabel;#center label
my $cLabel="piRNA";
my $pseudoLine="";
my %neg;

&stringDbGeneLoad($ARGV[2]);
my ($pairRef,$idRef,$idRef2)=gProfilerLoad($ARGV[0]);
my %pair=%{$pairRef};
my %id=%{$idRef};
my %id2=%{$idRef2};

&cLabelLoad($ARGV[1]);
&negGeneLoad($ARGV[3]);
&generateTrMatrix($ARGV[4]);
&generatePseudoTeMatrix($ARGV[5]);



sub negGeneLoad{
	open FILE, "<$_[0]" or die "$_[0] $!\n";
	while(<FILE>){
		chomp;
		if($. == 1){next;}
		my @l=split(/\t/,$_);
		if(!defined $id2{$l[0]} && defined $stringDbGene{$l[0]}){
			$neg{$l[0]}=$_;
		}
	}
	close FILE;
}

sub cLabelLoad{
	open FILE, "<$_[0]" or die "$_[0] $!\n";
	while(<FILE>){
		chomp;
		my @line=split(/\t/,$_);
		if(defined $stringDbGene{$line[1]}){
			$cLabel{$line[1]}=0;
		}
	}
	close FILE;
}

sub stringDbGeneLoad{
	open FILE, "<$_[0]" or die "$_[0] $!\n";
	while(<FILE>){
		chomp;
		my @line=split(/\t/,$_);
		$stringDbGene{$line[1]}="";
	}
	close FILE;
}

sub gProfilerLoad{
	my (%pair,%id,%id2);
	open FILE, "<$_[0]" or die "$_[0] $!\n";
	while(<FILE>){
		chomp;
		if($. ==1){next;}
		my @line=split(/\t/,$_);
		my (undef,undef,$s1,undef,undef,$s2)=split(/\t/,$_);
		if(!defined $stringDbGene{$s2}){next;}
		$pair{"$s1;$s2"}=1;
		$pair{"$s2;$s1"}=1;
		$id{$s1}="";
		$id2{$s2}="";
	}
	close FILE;
	return (\%pair,\%id,\%id2);
}

sub generateTrMatrix{
        open OUT, ">$_[0]" or die "$_[0] $!\n";
		#head
		print OUT "Gene\t$cLabel";
		$pseudoLine=sprintf "$pseudoLine\t0";
        foreach my $id1(sort keys %id){
				print OUT "\t$id1";
				$pseudoLine=sprintf "$pseudoLine\t0";
		}
		print OUT "\n";
		#body
        foreach my $id2(sort keys %id2){
                print OUT "$id2";
				if(defined $cLabel{$id2}){
					print OUT "\t1";
					$cLabel{$id2}=1;
				}else{
					print OUT "\t0";
				}
        	foreach my $id1(sort keys %id){
				if(!defined $pair{"$id1;$id2"}){
						$pair{"$id1;$id2"}=0;
				}
				my $value=$pair{"$id1;$id2"};
                print OUT "\t$value";
                }
                print OUT "\n";
        }
		#not used cLabel genes
		foreach my $id2(sort keys %cLabel){
			if($cLabel{$id2} == 0){
					print OUT "$id2\t1";
        		foreach my $id1(sort keys %id){
                	print OUT "\t0";
				}
				print OUT "\n";
			}
		}
		#neg genes
		foreach my $gene(sort keys %neg){
			if(defined $cLabel{$gene} || defined $id2{$gene}){next;}
			print OUT "$gene";
			print OUT "$pseudoLine\n";
		}
        close OUT;
}

sub generatePseudoTeMatrix{
    open OUT, ">$_[0]" or die "$_[0] $!\n";
	#head
	print OUT "\t$cLabel";
    foreach my $id1(sort keys %id){
		print OUT "\t$id1";
	}
	print OUT "\n";
	#body
	foreach my $gene(sort keys %stringDbGene){
		if(!defined $cLabel{$gene}){
			if(defined $id2{$gene} || defined $neg{$gene}){
				print OUT "$gene";
				print OUT "$pseudoLine\n";
			}
		}
	}
    close OUT;
}
