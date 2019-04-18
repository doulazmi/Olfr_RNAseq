#!/usr/bin/perl 	
my %tab=();
my %tab2=();
my $valeur=0;
my $ligne_avant="";
$first_name=$ARGV[0];
$first_name=~s/..\/analysis\/Olfr3UTR_quantif\///;
print $first_name;
$filein ="< ../analysis/Olfr3UTR_quantif/$first_name";


$fileout =" > ../analysis/UTR_expression/expression_".$first_name;
open (FIC_OP2, $fileout);		
open (MET ,$filein );
	my @ligne=<MET>;
	for (my $i=0; $i<=$#ligne; $i++){
		chop$ligne[$i];
		if ( $ligne[$i] ne $ligne_avant) {
		

			@j=split (/\t+/,$ligne[$i]);	
			
			
			@valeur=split (/\_+/,$j[3]);
			
			#if ($valeur[1] > 0) {print "$valeur[1]\n";}
			$cle=$valeur[0];
			if ($valeur[1] > 0) {
								if (exists $tab{$cle}) {
														$valeur2="$valeur[1]:$j[6]";
														$tab{$cle}.=" ".$valeur2;
														}
								else {
									$valeur2="$valeur[1]:$j[6]";
									$tab{$cle}=$valeur2;
									}
								}
							$ligne_avant =$ligne[$i]};
		}

  close MET;
  
  	@liste_cles =  keys %tab;
	foreach $cle ( @liste_cles)
			{$quantif=0;
			$exprTotl=0;
			$abond=0;
			$utr_avant=0;

				my @j=split (/\s+/,$tab{$cle});
				$lastindex=@j;
				$k=$lastindex-1;
				$quantif=0;
				my @tabutr="";
				while ($k > -1) {
					@q= split (/\:+/,$j[$k]);
					
					$cle2=$q[0];
					$tabutr[$k]=$q[0];
					$tab2{$cle2}=$q[1];
					$k--;
					 }
				@tabutr= sort { $a <=> $b } @tabutr;
				
				for ($i=0; $i< $lastindex; $i++){
				$quant=$tab2{$tabutr[$i]}-$quantif;
				$segment_utr=$tabutr[$i]-$utr_avant;
				if ($segment_utr!=0){$exp[$i]=$quant/$segment_utr;}
				
				
				$utrprint[$i]="$cle\t$tabutr[$i]\t$segment_utr\t$quant\t$exp[$i]\t";
				#$exp[$i]=$tab2{$tabutr[$i]}/$tabutr[$i];
				$quantif=$tab2{$tabutr[$i]};
				$utr_avant=$tabutr[$i];
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
	
   
