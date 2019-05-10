########################################################################
#
# Copyright (C) 2019  Institut de Biologie Paris-Seine
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#####################################################################	
my %tab=();#hach table for Olfr stop position
$first_name=$ARGV[0];
open (MET ,"< ../OlfrSTOPM14.txt");#file for Olfr stop coordinate
my @line=<MET>;
for (my $i=0; $i<=$#line; $i++){
	my @j=split (/\s+/,$ligne[$i]);	   		   			   
	if ($j[3] eq "-") {
		$tab{$j[0]}=$j[2];
		}
	else {
		$tab{$j[0]}=$j[1];
	}		  
		
  }
close MET;


open (FIC_OP,"< $first_name");
my @line=<FIC_OP>;
$fileUTR=$first_name;
$fileUTR=~s/.tmp//;
$fileUTR.="Iso3UTR.bed";
open (FIC_OP3,">> ../analysis/UTRallM14_NoRO.txt");
open (FIC_OP2,"> $fileUTR"); 
	
for (my $index=0; $index <=$#line; $index++){
	chomp ($line[$index]);		
	$UTR=0;
	my @k=split (/\t+/,$line[$index]);
    @nameseq= split (/;/,$k[4]);
	$nameseq[3]=~s/"type //g;
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

  	
	
	
   
