#######################################################################
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
my %tab=();
my $valeur=0;
$first_name=$ARGV[0];
$filein ="< ../all3UTR_M14".$first_name."u.txt";
$fileout =" > ../merge_all3UTR_M14".$first_name.".txt";
open (FIC_OP2, $fileout);		
open (MET ,$filein );
	my @ligne=<MET>;
	for (my $i=0; $i<=$#ligne; $i++){
		chop$ligne[$i];
			#
			my @j=split (/\t+/,$ligne[$i]);	

			
			my $key=$j[0]."/".$j[2];
			
			$valeur=$j[1];
	if ($valeur > 0) {
	if ( exists $tab{$key}) {
			$tab{$key}.=" ".$valeur;}
	else {$tab{$key}=$valeur;}
	}

		}

 close MET;
  
  	@list_keys =  keys %tab;
	foreach $key ( keys %tab)
			{print FIC_OP2 "$key\t";

				my @j=split (/\s+/,$tab{$key});
				$number=1;

				@sortedj=@j;
				
				for (my $k=0; $k<=$#sortedj; $k++){$diff=0;
					#print "$sortedj[$k] ";
					
					if ($k<$#sortedj ){$diff=$sortedj[$k+1]-$sortedj[$k];}
					#print "--$diff\t";
					if (($diff < 100) & ($diff > 0)){
						
									print FIC_OP2 "$sortedj[$k]--$sortedj[$k+1]\t";
									$number=$number-1;
													}
					else {
						print FIC_OP2 "$sortedj[$k]\t";
						}
						$total=$k+$number;
						$p=$k+1
					}
				
				while ($p< 17) {
					print FIC_OP2 "--\t"; $p++;
				}
				$k=0;
				print FIC_OP2 "$total\n";
			}
close FIC_OP2;
	
   