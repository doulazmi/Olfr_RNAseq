#!/bin/bash -ex

radius=$1	#
outPref=$2
minfold=$3
mkdir -p ../analysis/${outPref}
dir=${PWD}
diranalysis=${dir}/scripts/analysis
for bamFile in ${diranalysis}/align/*.bam
do
	baseId=$(basename $bamFile .bam)_${pIntron}_${minfold}
	echo "#################   Doing ${baseID}, jnct_alpha set at $radius   ################"
	echo "------ Root is ${outPref}_${pIntron}/${baseId}"
	echo "------ Bam file is $bamFile"
	java -Xmx6g -jar IsoSCM-2.0.9.jar assemble -bam $bamFile -base $baseId -s reverse_forward -dir ${diranalysis}/IsoSCM -merge_radius $radius -jnct_alpha 0.05 -min_fold $minfold 
	java -Xmx6g -jar IsoSCM-2.0.9.jar enumerate -max_isoforms 20 -x  ${diranalysis}/IsoSCM/${baseId}.assembly_parameters.xml
	echo "java -Xmx6g -jar IsoSCM-2.0.9.jar assemble -bam $bamFile -base $baseId -s unstranded -dir ${outPref} -merge_radius $radius -jnct_alpha 0.05 -min_fold $minfold"
	echo "java -Xmx6g -jar IsoSCM-2.0.9.jar enumerate -max_isoforms 20 -x ${outPref}/${baseId}.assembly_parameters.xml"
done
exit
