#!/bin/sh -ex
samtools view -b -L mask_subcluster.M14.bed $1 > ../analysis/align/$2
samtools index ../analysis/align/$2
echo 
echo "samtools view -b -L mask_subcluster.M14.bed $1 > ../analysis/align/$2"
echo "samtools index ../analysis/align/$2"
exit
