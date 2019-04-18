#!/bin/bash -ex
# use MakeUTR.sh radius_M14 subsetOlfrM14gm.bed M14
# Generates the  3UTR isoforms
dir=${PWD}
diranalysis=${dir//scripts/analysis}
isoScmDir=${diranalysis}/gtf_isoforms_u    # radius_M14
subset=../../prod/subsetOlfr${1}UTR.bed               #
premSubset=../../prod/subsetOlfr${1}UTR.bed
out=${diranalysis}/OlfrAnno5UTR_$1

mkdir -p $out


for gtffile in ${isoScmDir}/*.gtf
        do
        	#baseName=`basename $gtffile .gtf`
#        	touch ${out}/allLocusDone_${baseName}.txt
#			touch ${out}/definitiveAnnotation_${baseName}.gtf
#			touch ${out}/definitiveIsoforms_${baseName}.gtf

        ./grabIsoScmpartiel.sh $gtffile $out $subset
 #       grep -f ${out}/${baseName}_fusedGenes.txt $subset > $out/$premSubset.${baseName}.bed
  #      subset=$out/$premSubset.${baseName}.bed
   #     cat $out/${baseName}_goodLocus.txt >> ${out}/allLocusDone_${baseName}.txt
        # Adding annotation, making loci unique
        #cat $out/${baseName}_annotation.gtf | sed -r 's/([^locus_id"]*")([^"]*)/\1'"${maxIntron}"'|\2/'  >> ${out}/definitiveAnnotation_${baseName}.gtf
        # Adding annotation, making loci and transcript unique
        #cat $out/${baseName}_iso.gtf | sed -r 's/(locus_id\s*[^"]*")([^"]*)/\1'"$maxIntron"'|\2/' | sed -r 's/(transcript_id\s*[^"]*")([^"]*)/\1'"$maxIntron"'|\2/'  >>  ${out}/definitiveIsoforms_${baseName}.gtf

		#sort -k1,1 -k4,4 ${out}/definitiveAnnotation_${baseName}.gtf > ${out}/definitiveAnnotation_${baseName}.sorted.gtf
		#sort -k1,1 -k4,4 ${out}/definitiveIsoforms_${baseName}.gtf > ${out}/definitiveIsoforms_${baseName}.sorted.gtf
		#cp ${out}/${baseName}_fusedGenes.txt ${out}/finalFusedGenes_${baseName}.txt

#		rm -rf tmpDir


        done
exit
