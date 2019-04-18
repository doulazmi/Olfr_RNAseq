#!/bin/bash -ex
# First arg is the gtf file derived from isoscm, second is output dir, third is the mask to use
export LANG=en_US.utf8
baseName=`basename $1 .gtf`
entry=$1
isofolder=${entry/gtf_isoforms_u/gtf_isoforms}
bedtemp=${1##*/}
mkdir -p $2
rm -rf tmpDir
rm  -f $1.tmp $1.bed.tmp
mkdir tmpDir
./makeBedFromGtf.sh ${1} tmpDir/tmpBedFromGtfFile.bed
# Merge all the exons and splice junctions into large canonical transcript
bedtools merge  -d 100 -c 4,5,6 -o distinct,mean,distinct -i tmpDir/tmpBedFromGtfFile.bed > tmpDir/mergedBed.bed
# Count the number of OR genes overlapping each assembled transcript
bedtools intersect  -c   -a   tmpDir/tmpBedFromGtfFile.bed -b $3  > tmpDir/countOverlap.bed
#cp tmpDir/mergedBed.bed bedtmp/${bedtemp}mergedBed.bed
#cp tmpDir/countOverlap.bed bedtmp/${bedtemp}countOverlap.bed
# These reads are bad: too many transcripts
awk -F"\t" '$7 > 1 {print $0}' tmpDir/countOverlap.bed | cut -f-6 > tmpDir/badPos.bed
#cp tmpDir/badPos.bed bedtmp/${bedtemp}badPos.bed
bedtools intersect -s -u -a $3 -b tmpDir/badPos.bed | awk '{print $4}' > $2/${baseName}_fusedGenes.txt
# These reads are ok, only one olfr transcript is seen
awk -F"\t" '$7 == 1 {print $0}' tmpDir/countOverlap.bed | awk '{print $4}' > $2/${baseName}_goodLocus.txt
#awk -F"\t" '$7 > 1 {print $0}' tmpDir/countOverlap.bed | awk '{print $4}' >  tmpDir/badPos2.bed
awk -F"\t" '$7 > 1 {print $0}' tmpDir/countOverlap.bed | awk '{print $4}' >  $2/${baseName}_badLocus.txt
#sort -u tmpDir/badPos2.bed > $2/${baseName}_badLocus.txt
#grep -f $2/${baseName}_goodLocus.txt $1 | sort -k1,1 -k4,4 > $2/${baseName}_annotation.gtf 
grep -vf $2/${baseName}_badLocus.txt $1 | sort -k1,1 -k4,4 > $2/${baseName}_annotation.gtf
# Do the isoforms
echo "Base name is ${baseName}.isoforms.gtf"
grep -vf $2/${baseName}_badLocus.txt ${isofolder%.*}.isoforms.gtf | sort -k1,1 -k4,4 > $2/${baseName}_iso.gtf
exit

