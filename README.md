# Olfr_RNAseq


# Prerequisites
-------
1-STAR RNASeq aligner: (https://github.com/alexdobin/STAR)

2-Bedtools - genomic interval manipulation (merge,sort,intersect ....):(https://bedtools.readthedocs.io/en/latest/)

3-samtools -post-processing alignments  files: (http://www.htslib.org/download/)

4-IsoSCM RNASeq de novo assembler: (https://github.com/shenkers/isoscm)

5-Cufflinks RNASeq assembler: (http://cole-trapnell-lab.github.io/cufflinks/)

6-IGV - viewer for the reads and annotation:(http://software.broadinstitute.org/software/igv/)


# Data files to download
--------
Needed third party files:

1- mm10.gtf: mm10 annotation, using for example the UCSC table browser, with the Ensembl gene IDs track selected:(http://genome.ucsc.edu/cgi-bin/hgTables)

2- PRJEB1365: the olfactory epithelium RNASeq data:(https://www.ebi.ac.uk/ena/data/view/PRJEB1365)

3- GENCODE (Release M14; GRCm38.p5) comprehensive gene annotation for mm10 : (https://www.gencodegenes.org/mouse/)

#

# Alignment with STAR and different parameters
--------
STAR command line
STAR is run with this command line:
timeout 2h bash -c "~/STAR/bin/Linux_x86_64/STAR --runThreadN 7 --genomeDir ~/indexSTARmice --readFilesIn rnaSeqData_1.fastq.gz rnaSeqData_2.fastq.gz --readFilesCommand zcat --outFileNamePrefix rnaSeqData/job --outSAMtype BAM Unsorted --genomeLoad LoadAndKeep --outSAMstrandField intronMotif --outFilterIntronMotifs RemoveNoncanonical --alignIntronMax 23000"


To ensure compatibility with cufflinks, the parameters --outSAMstrandField intronMotif --outFilterIntronMotifs RemoveNoncanonical are set. 

Sorting reads

The sorting process is done afterwards, using samtools (which is the same as STAR...):
samtools sort -@ 7 -m 3G jobAligned.out.bam jobAligned.sorted
samtools index jobAligned.sorted.bam


# Masking the alignments files (applyMaskTobam.sh)
-------
samtools view -b -L  mask_file > MskedFile.bam
samtools index MskedFile.bam

# Assembly with IsoSCM
-------
Generating the annotation and isoforms with IsoSCM
The script used here is deployIsoscm.sh and assumes every file file.bam in analysis/align has been masked using applyMaskTobam.sh file.bam masked_file.bam

deployAnnoTation.sh (grabIsoScm.sh) filters a requested subset of the assembled gene models, checks if fused genes are present, and creates 4 different files: the clean annotation and isoforms, the unfused IsoSCM locus (*_goodLocus.txt) and the Ensembl IDs of fused genes (*_fusedGenes.txt)


# Assembly with Cufflinks


