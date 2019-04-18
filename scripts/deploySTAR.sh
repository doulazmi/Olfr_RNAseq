#!/bin/sh -ex
diranalysis=$1
echo "$diranalysis"
rnaSeq() {
	cd
	echo
	echo "_________________ $1 RNA Seq / data origin $2 ____________________"
	echo "Started STAR alignment procedure at date: `date`"
	OUT=${diranalysis}analysis/${1}_Results
	IN=${diranalysis}data/seqs
	mkdir -p $OUT
	timeout 2h bash -c "/media/ottis/Data/NewRNAseqAnalysis/Software/STAR/bin/Linux_x86_64/STAR --runThreadN 7 --genomeDir /media/ottis/Data/NewRNAseqAnalysis/indexSTARmice --readFilesIn ${IN}/${1}_1.fastq.gz ${IN}/${1}_2.fastq.gz \
					--readFilesCommand zcat --outFileNamePrefix ${OUT}/job --outSAMtype BAM Unsorted --genomeLoad LoadAndKeep \
					--outSAMstrandField intronMotif --outFilterIntronMotifs RemoveNoncanonical --alignIntronMax 23000"
	echo "/media/ottis/Data/NewRNAseqAnalysis/Software/STAR/bin/Linux_x86_64/STAR --runThreadN 7 --genomeDir /media/ottis/Data/NewRNAseqAnalysis/indexSTARmice --readFilesIn ${IN}/${1}_1.fastq.gz ${IN}/${1}_2.fastq.gz \
                                        --readFilesCommand zcat --outFileNamePrefix ${OUT}/job --outSAMtype BAM Unsorted --genomeLoad LoadAndKeep \
                                        --outSAMstrandField intronMotif --outFilterIntronMotifs RemoveNoncanonical --alignIntronMax 23000"
	echo "Finished STAR alignment procedure at date: `date`"
	samtools sort -@ 6 -m 4G ${OUT}/jobAligned.out.bam -o  ${diranalysis}analysis/aligUnmask/${1}.bam
	echo "samtools sort -@ 6 -m 4G ${OUT}/jobAligned.out.bam -o ${diranalysis}analysis/aligUnmask/${1}.bam"
	echo "Finished Samtools indexing procedure at date: `date`"
	echo
}


#rnaSeq "male10wMerged" "merged_m14_23"
rnaSeq "female10wMerged" "merged_m14_23"
