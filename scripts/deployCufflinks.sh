#!/bin/bash -ex
#
dir=${PWD}
diranalysis=${dir}/scripts/analysis
mkdir -p cufflinks_M14
for min_isoform in `seq 0.2 0.1 1`;
	do
		for bamFile in ${diranalysis}/align/*.bam
			do
			baseId=$(basename $bamFile .bam)
		     NameCuffFile=${dircuff}${baseId}_${min_isoform}
		        ./cufflinks -F $min_isoform $bamFile   -o $NameCuffFile
			done
	done
exit
