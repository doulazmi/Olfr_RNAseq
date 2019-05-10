#!/bin/bash -ex

# First arg is the merge_radius, second is fold_change
for bamFile in ../analysis/align/*.bam
do
	baseId=$(basename $bamFile .bam)
    coverageBed -abam $bamFile -b ../analysis/Olfr3UTR_Bed_M14/${baseId}_${1}_${2}_iso_annotationQuantif_3UTR.bed > ../analysis/Olfr3UTR_quantif/${baseId}_${1}_${2}.coverage.txt
  	coverageBed -hist -abam $bamFile -b ../analysis/Olfr3UTR_Bed_M14/${baseId}_${1}_${2}_iso_annotationQuantif_3UTR.bed > ../analysis/Olfr3UTR_quantif/${baseId}_${1}_${2}.histogram.txt
	coverageBed -counts -abam $bamFile -b ../analysis/Olfr3UTR_Bed_M14/${baseId}_${1}_${2}_iso_annotationQuantif_3UTR.bed > ../analysis/Olfr3UTR_quantif/${baseId}_${1}_${2}.count.txt


done
exit
