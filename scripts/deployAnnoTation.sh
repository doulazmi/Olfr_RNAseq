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
        	

        ./grabIsoScm.sh $gtffile $out $subset
 #       


        done
exit
