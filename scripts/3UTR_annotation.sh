#!/bin/bash -ex
# First arg is the gtf file derived from isoscm, second is output dir, third is the mask to use
export LANG=en_US.utf8
baseName=`basename $1 .gtf`
entry=$1
filestop=$4
mkdir -p $2
rm -rf tmpDir
mkdir tmpDir
./makeBedFromGtfalllines.sh ${1} tmpDir/tmpBedFromGtfFile.bed
bedtools intersect  -a  ${1}.bed -b $3 -wa -wb > $2/${baseName}_annotation.txt
awk 'BEGIN { FS="\t"; OFS="\t" } { print  $1, $2, $3, $14, $10,  $5, $6, $7, $8 , $9, $4; }' $2/${baseName}_annotation.txt > $2/${baseName}_annotation2.tmp
sed 's/Olfr619/Olfr620/g' $2/${baseName}_annotation2.tmp > $2/${baseName}_annotation.tmp
perl checkStopIsoscm.pl $2/${baseName}_annotation.tmp $filestop


