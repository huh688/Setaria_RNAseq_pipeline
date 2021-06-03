#!/bin/bash
#SBATCH -p batch
#SBATCH -t 3-00:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32
#SBATCH --mail-type=ALL
#SBATCH --output=%x.%A.out

WorkDir=/scratch/haohu/Setaria/

cd $WorkDir 



## Step 2 Remove rRNA from raw data

for InputFile in `ls *.fastq.gz`

do 

rRNAOutputFile=`basename $InputFile | sed -e "s/.fastq.gz/.rRNA/"`

CleanedOutputFile=`basename $InputFile | sed -e "s/.fastq.gz/.rRNAfree/"`

/home/haohu/bin/sortmerna-4.2.0/bin/sortmerna -ref /home/haohu/bin/sortmerna-4.2.0/db/rfam-5.8s-database-id98.fasta -ref /home/haohu/bin/sortmerna-4.2.0/db/rfam-5s-database-id98.fasta -ref /home/haohu/bin/sortmerna-4.2.0/db/silva-arc-16s-id95.fasta -ref /home/haohu/bin/sortmerna-4.2.0/db/silva-arc-23s-id98.fasta -ref /home/haohu/bin/sortmerna-4.2.0/db/silva-bac-16s-id90.fasta -ref /home/haohu/bin/sortmerna-4.2.0/db/silva-bac-23s-id98.fasta -ref /home/haohu/bin/sortmerna-4.2.0/db/silva-euk-18s-id95.fasta -ref /home/haohu/bin/sortmerna-4.2.0/db/silva-euk-28s-id98.fasta -fastx -num_alignments 1 -workdir $WorkDir -reads $InputFile -aligned ./out/$rRNAOutputFile -other ./out/$CleanedOutputFile -v

rm -rf $WorkDir/kvdb/

done