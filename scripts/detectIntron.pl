%tabolfr='';
%nblines='';
%cuff2olfr='';
$fileout =" > ../../results/female23.M14_0.1intron.bed";

open (FIC_OP2, $fileout);
open (MET ," < ../female23.M14_0.1_.bed");

my @ligne=<MET>;
for (my $i=0; $i<=$#ligne; $i++){
	chomp $ligne[$i];
	my @k=split (/\t+/,$ligne[$i]);
	$cuff2olfr{$k[3]}=$k[11];
	$cuff2chr{$k[3]}=$k[0];
	$cuff2sign{$k[3]}="$k[4]\t$k[5]\t$k[6]\t";
	#
	
	}

close MET;

open (MET ," < ../OlfrSTOPM14.txt");
my @ligne=<MET>;
for (my $i=0; $i<=$#ligne; $i++){
	chomp $ligne[$i];

	my @k=split (/\t+/,$ligne[$i]);
	
	$cuff2stop{$k[0]}=$k[2];
	$stopsign{$k[0]}=$k[3];
	
}

close MET;	
open (MET ," < ../female23.M14_0.1.gtf");
my @ligne=<MET>;
for (my $i=0; $i<=$#ligne; $i++){
	chomp $ligne[$i];
	my @k=split (/\t+/,$ligne[$i]);
	@nameseq= split (/;/,$k[8]);
		$nameseq[1]=~s/transcript_id "//;
		$nameseq[1]=~s/"//;
		$nameseq[1]=~s/\s//;  
		
	if ($k[2] eq "transcript"){$nb=0;
		$avant=$nameseq[1];
		

		}
	else {}
	if ($nameseq[1]==$avant) {
		$nb++;
		$tabolfr{$nameseq[1]}.="$k[3]_$k[4]_";
		$nblines{$nameseq[1]}=$nb;
		#print "$k[11]\n";
	}
}

close MET;
@liste_cles =  keys %tabolfr;
	foreach $cle ( @liste_cles){$tailleexon=0;
		#print "$cle $tabolfr{$cle} $nblines{$cle}\n";
		my @k=split (/_+/,$tabolfr{$cle});
		
		$nbline=2*$nblines{$cle}-1;
		$tailletransript=$k[1]-$k[0];
		for ($i=2; $i<$nbline; $i=$i+2){
			$j=$i+1;
			$tailleexon+=$k[$j]-$k[$i];
		
			}

		for ($i=3; $i<$nbline; $i=$i+2){
			$j=$i+1;
			$tailleeintron=$k[$j]-$k[$i];
			if ($stopsign{$cuff2olfr{$cle}} eq '-'){$diff=$k[$j]- $cuff2stop{$cuff2olfr{$cle}};}
			if ($stopsign{$cuff2olfr{$cle}} eq '+'){$diff=$k[$i]- $cuff2stop{$cuff2olfr{$cle}};}
			if(($diff < 0 & $stopsign{$cuff2olfr{$cle}} eq '-') or ($diff > 0 & $stopsign{$cuff2olfr{$cle}} eq '+')){$utr='3UTR_intron';}
			else {$utr='5UTR_intron';}
			if (exists $cuff2olfr{$cle} ){
				print FIC_OP2 "$cuff2chr{$cle}\t$k[$i]\t$k[$j]\t$cle\t$cuff2sign{$cle}\t$cuff2olfr{$cle}\t$cuff2stop{$cuff2olfr{$cle}}\t$utr\t$tailleintron\n";
				}
			}

			
			if (! exists ($cuff2olfr{$cle})){$cuff2olfr{$cle}=$cle;}
		
		print "$cuff2olfr{$cle} $cle $nblines{$cle} $tailletransript  $tailleexon\n";
	}
									
close FIC_OP2; 