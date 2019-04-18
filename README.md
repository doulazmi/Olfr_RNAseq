# Olfr_RNAseq


# Prerequisites
-------
1-STAR RNASeq aligner: (https://github.com/alexdobin/STAR)

2-Bedtools - genomic interval manipulation (merge,sort,intersect ....):(https://bedtools.readthedocs.io/en/latest/)

3-samtools -post-processing alignments in the files: (http://www.htslib.org/download/)

4-IsoSCM RNASeq de novo assembler: (https://github.com/shenkers/isoscm)

5-Cufflinks RNASeq assembler: (http://cole-trapnell-lab.github.io/cufflinks/)

6-IGV - viewer for the reads and annotation:(http://software.broadinstitute.org/software/igv/)


# Data files to download
--------
Needed third party files:

1- mm10.gtf: mm10 annotation, using for example the UCSC table browser, with the Ensembl gene IDs track selected:(http://genome.ucsc.edu/cgi-bin/hgTables)

2- PRJEB1365: the olfactory epithelium RNASeq data:(https://www.ebi.ac.uk/ena/data/view/PRJEB1365)

3- GENCODE (Release M14; GRCm38.p5) comprehensive gene annotation for mm10 : (https://www.gencodegenes.org/mouse/)

# Alignment with STAR and different parameters
--------

STAR is run with this command line:
timeout 2h bash -c "~/STAR/bin/Linux_x86_64/STAR --runThreadN 7 --genomeDir ~/indexSTARmice --readFilesIn rnaSeqData_1.fastq.gz rnaSeqData_2.fastq.gz --readFilesCommand zcat --outFileNamePrefix rnaSeqData/job --outSAMtype BAM Unsorted --genomeLoad LoadAndKeep --outSAMstrandField intronMotif --outFilterIntronMotifs RemoveNoncanonical --alignIntronMax 23000"


To ensure compatibility with cufflinks, the parameters --outSAMstrandField intronMotif --outFilterIntronMotifs RemoveNoncanonical are set. 




