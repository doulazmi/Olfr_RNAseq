#!/usr/bin/perl 	
my %tab=();
$first_name=$ARGV[0];
open (MET ,"< ../OlfrSTOPM14.txt");
my @ligne=<MET>;
for (my $i=0; $i<=$#ligne; $i++){
	my @j=split (/\s+/,$ligne[$i]);	   		   			   
	$key=$j[0];
	$key=~s/\t+//g;
	$j[3]=~s/\s+//g;
			    
	if ($j[3] eq "-") {
		$tab{$key}=$j[2];
		}
			
	else {
		$tab{$key}=$j[1];
	}		  
		
  }
close MET;


open (FIC_OP,"< $first_name");
my @line=<FIC_OP>;
$fileUTR=$first_name;
$fileUTR=~s/.tmp//;
$fileUTR=$fileUTR."Iso3UTR.bed";
open (FIC_OP3,">> ../analysis/UTRallM14_NoRO.txt");
open (FIC_OP2,"> $fileUTR");
	
for (my $index=0; $index <=$#line; $index++){
	chomp ($line[$index]);		
	$UTR=0;
	my @k=split (/\t+/,$line[$index]);
    @nameseq= split (/;/,$k[4]);
	$nameseq[3]=~s/type //;
	$nameseq[3]=~s/"//g;
	#print "$k[3] $nameseq[3]\n";
	if ($nameseq[3] eq '3p_exon'){
		print FIC_OP2 "$k[0]\t";
		if ($k[6] eq "-") { 
			print FIC_OP2 "$k[1]\t"; 
			$UTR=$k[2] -($k[2]- $tab{$k[3]}); 
			print FIC_OP2 "$UTR\t"; $size = $UTR -$k[1]+1;
			}
			
		if ($k[6] eq "+") {
			$UTR=$k[1] -($k[1]- $tab{$k[3]});
			print  FIC_OP2 "$k[2]\t$UTR\t";
			$size = $k[2] -$UTR +1;
			}
		
	print FIC_OP2 "$k[3]\t$k[4]\t$k[5]\t$k[6]\t$k[7]\t$k[8]\t$k[9]\t$k[10]\t$size\n";
	print FIC_OP3 "$k[3]\t$size\t$first_name\n";

		}
	}	
close FIC_OP2;
close FIC_OP;

  	
	
	
   
