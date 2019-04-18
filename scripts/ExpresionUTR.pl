#!/usr/bin/perl 	
my %tab=();
my %tab2=();
my $valeur=0;
my $ligne_before="";


$first_name=$ARGV[0];
$first_name=~s/..\/analysis\/Olfr3UTR_quantif\///;

$filein ="< ../analysis/Olfr3UTR_quantif/$first_name";


$fileout =" > ../analysis/UTR_expression/expression_".$first_name;
open (FIC_OP2, $fileout);		
open (MET ,$filein );
	my @ligne=<MET>;
	for (my $i=0; $i<=$#ligne; $i++){
		chop$ligne[$i];
		if ( $ligne[$i] ne $ligne_before) {
		

			@j=split (/\t+/,$ligne[$i]);	
			
			
			@valeur=split (/\_+/,$j[3]);
			
			
			$key=$valeur[0];
			if ($valeur[1] > 0) {
								if (exists $tab{$key}) {
														$valeur2="$valeur[1]:$j[6]";
														$tab{$key}.=" ".$valeur2;
														}
								else {
									$valeur2="$valeur[1]:$j[6]";
									$tab{$key}=$valeur2;
									}
								}
							$ligne_before =$ligne[$i]};
		}

  close MET;
  
  	@liste_cles =  keys %tab;
	foreach $key ( @liste_cles)
			{$quantif=0;
			$exprTotl=0;
			$abond=0;
			$utr_before=0;

				my @j=split (/\s+/,$tab{$key});
				$lastindex=@j;
				$k=$lastindex-1;
				$quantif=0;
				my @tabutr="";
				while ($k > -1) {
					@q= split (/\:+/,$j[$k]);
					
					$key2=$q[0];
					$tabutr[$k]=$q[0];
					$tab2{$key2}=$q[1];
					$k--;
					 }
				@tabutr= sort { $a <=> $b } @tabutr;
				
				for ($i=0; $i< $lastindex; $i++){
				$quant=$tab2{$tabutr[$i]}-$quantif;
				$segment_utr=$tabutr[$i]-$utr_before;
				if ($segment_utr!=0){$exp[$i]=$quant/$segment_utr;}
				
				
				$utrprint[$i]="$key\t$tabutr[$i]\t$segment_utr\t$quant\t$exp[$i]\t";
				#$exp[$i]=$tab2{$tabutr[$i]}/$tabutr[$i];
				$quantif=$tab2{$tabutr[$i]};
				$utr_before=$tabutr[$i];
				}
				for ($i=$lastindex-1; $i> -1; $i--){

				$exp2[$i]=$exp[$i]-$abond;
				#$percent=$exp2[$i]/$exprTotl;
				#print "$utrprint[$i]$exp2[$i]\t$percent\n";
				$exprTotl =$exprTotl + $exp2[$i];
				$abond=$exp2[$i];
				}
				for ($i=0; $i< $lastindex; $i++){
				if ($exprTotl!=0){
					$percent=($exp2[$i]/$exprTotl)*100;
				print FIC_OP2 "$utrprint[$i]$exp2[$i]\t$percent\n";
				}
				
				
				}
				
			}
close FIC_OP2;
	
   
