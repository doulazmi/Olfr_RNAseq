#!/usr/bin/perl 	
my %tab=();
my $valeur=0;
$first_name=$ARGV[0];
$filein ="< ../../data/UTRall/UTRallM14_NoRO_".$first_name."u.txt";
$fileout =" > ../mergeallM14_NoRO_".$first_name.".txt";
open (FIC_OP2, $fileout);		
open (MET ,$filein );
	my @ligne=<MET>;
	for (my $i=0; $i<=$#ligne; $i++){
		chop$ligne[$i];
			#Male_female_PRJEB1365
			my @j=split (/\t+/,$ligne[$i]);	

			#$j[2]=~s/\/media\/ottis\/Data\/NewRNAseqAnalysis\/PRJEB5984_C57bl6_10w\/analysis\///g;
			#$j[2]=~s/\/media\/ottis\/Data\/NewRNAseqAnalysis\/Male_female_PRJEB1365\/analysis\///g;
			#$j[2]=~s/\/media\/ottis\/Data\/NewRNAseqAnalysis\/IS_2017\/analysis\///g;
			$j[2]=~s/\/media\/ottis\/Data\/NewRNAseqAnalysis\/IS_2014ref\/analysis\///g;
			$j[2]=~s/Olfr3UTR_AnnIso_M14\///g;
			$j[2]=~s/_iso_annotation.tmp//g;
			print "$j[2]\n";
			# $j[2]=~s/MOE\d/23/g;
			 #$j[2]=~s/.M14//g;
			# $j[2]=~s/ERR\d+//g;
			# $j[2]=~s/[mM]ale//g;
			# $j[2]=~s/[fF]e//g;
			# $j[2]=~s/[kK]anageswaran//g;
			# $j[2]=~s/__/_/g;
			# $j[2]=~s/a//g;
			my $cle=$j[0]."/".$j[2];
			
			$valeur=$j[1];
	if ($valeur > 0) {
	if ( exists $tab{$cle}) {
			$tab{$cle}.=" ".$valeur;}
	else {$tab{$cle}=$valeur;}
	}

		}

  close MET;
  
  	@liste_cles =  keys %tab;
	foreach $cle ( keys %tab)
			{print FIC_OP2 "$cle\t";

				my @j=split (/\s+/,$tab{$cle});
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
	
   