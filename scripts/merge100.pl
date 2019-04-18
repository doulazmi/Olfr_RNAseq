#!/usr/bin/perl 	
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
	
   