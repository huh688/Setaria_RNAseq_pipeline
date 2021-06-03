#!/bin/bash
#SBATCH -p batch
#SBATCH -t 3-00:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32
#SBATCH --mail-type=ALL
#SBATCH --output=%x.%A.out

### Process ME34 data ONLY

WorkDir=/scratch/haohu/Setaria/

cd $WorkDir 

# Mapping to Sviridis with STAR

module load star-rna/2.7.3a

ulimit -n 10000

for StarInputFile in `ls *.rRNAfree.trimmed.fastq`

do

StarOutputPrefix=`basename $StarInputFile | sed -e "s/.rRNAfree.trimmed.fastq/.rRNAfree.trimmed.STAR./"`

STAR --runMode alignReads --runThreadN 32 --genomeDir /scratch/haohu/index/star_2.7.3a/Sviridis_500_v2.1_star_2.7.3a_index --readFilesIn $StarInputFile --quantMode TranscriptomeSAM GeneCounts --outSAMtype BAM Unsorted SortedByCoordinate --outFilterType BySJout --alignIntronMin 20 --alignIntronMax 5000 --outSAMstrandField intronMotif --outFilterIntronMotifs RemoveNoncanonical --outFileNamePrefix $StarOutputPrefix

done