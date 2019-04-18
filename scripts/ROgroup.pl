  	my %tab=();
	
  	open (MET ,"< ../olfrnamesM14.txt");
	my @ligne=<MET>;
	for (my $i=0; $i<=$#ligne; $i++){
			my @j=split (/\t+/,$ligne[$i]);
			   
			   
	   		   	chomp$j[0];

			#print "$j[0]\n";
			  $tab{$j[0]}=$j[0];
		
			   					  }

	close MET;

  	
	
	
   	open (FIC_OP,"< ../gencode.vM14.chr_patch_hapl_scaff.annotation_CDSmax.gtf");
	
	my @ligne2=<FIC_OP>;
	
	open (FIC_OP2,"> ../ROCDSconsecutiveCluster_transcriptM14.txt");
	open (FIC_OP3,"> ../mask_subcluster.bed");
	open (FIC_OP4,"> ../ClusterFrontiereListe.M14.txt");
	my $gene_start=0;
	my $gene_stop=0;
	my $InROflag=0; 
	my $clusternb=1;
	$clusternbt=1;
	for (my $index=0; $index <=$#ligne2; $index++){	
	my @k=split (/\t+/,$ligne2[$index]);
	chomp $ligne2[$index];
	$sizeCDS=$k[2]-$k[1];
	$intervaleCDS=$k[1]-$gene_stop;
	chop $k[5];


	if ($InROflag2==1 ) {if ($clusterbefore == 103899241) {$clusterbefore=3567398;}
						print FIC_OP3 "$chr\t$clusterbefore\t$clusterend\tClusterOlfrOrient$clusternb\t$k[4]\t$sign_before\n"; 
						$clusternb++;    $InROflag2=0;

					}
	if ($InROflag==1 &  !(exists $tab{$k[3]}) )  {
									$clusternbt++; 
									if ($k[3]=~/^Gm/ or $k[3]=~/^AL/ or $k[3]=~/^AC/ or $k[3]=~/^CT/ or $k[3]=~/^OR/ or $k[3]=~/Rik$/) {print FIC_OP4 "$k[3]\n";}
									
							 		print FIC_OP2 "noRO-$k[3]\t $ligne2[$index]\t $sizeCDS\t $intervaleCDS\n"; 
							 		$InROflag= 0; $clusterbefore=$cluster; $cluster=$gene_stop; $clusterend=$k[1]; $sign_before=$signe;
									$InROflag2=1;
												}
	if (exists $tab{$k[3]})	{ 

							if ($InROflag==0 ) { 
											if ($olfr=~/^Gm/ or $olfr=~/^AL/ or $olfr=~/^AC/ or $olfr=~/^CT/ or $olfr=~/^OR/ or $olfr=~/Rik$/) {print FIC_OP4 "$olfr\n";}
												print FIC_OP2 $ligne_before; $chr=$k[0];$cluster= $gene_stop;  $signe =$k[5];
												}

							print FIC_OP2 "$tab{$k[3]}\t $ligne2[$index]\t$sizeCDS\t $intervaleCDS\n";
							$InROflag= 1;
						}

	if ( $InROflag==1 &  $signe ne $k[5]) { 
										if ($clusterbefore ne $cluster) {
											 $clusterbefore=$cluster; $cluster=$gene_stop; $clusterend=$k[1]; $sign_before=$signe;
											$InROflag2=1;						   }
										}
 	
	$ligne_before= "noRO-$k[3]\t $ligne2[$index]\t $sizeCDS\t $intervaleCDS\n";
	$gene_stop= $k[2];
	$gene_start=$k[1];
	$signe =$k[5];
	$chr=$k[0];
	$olfr=$k[3];

	}	
	close FIC_OP2;
	close FIC_OP3;	
	close FIC_OP4;
	close FIC_OP;
	

