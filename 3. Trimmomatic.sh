#!/bin/bash
#SBATCH -p batch
#SBATCH -t 3-00:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32
#SBATCH --mail-type=ALL
#SBATCH --output=%x.%A.out

WorkDir=/scratch/haohu/Setaria/

cd $WorkDir 


## Step 3 Trim raw reads to remove low quality reads and adapters

mv $WorkDir/out/ME34*.rRNAfree.fastq $WorkDir

cd $WorkDir 

for TrimInputFile in `ls ME34*.rRNAfree.fastq`

do 

TrimOutputFile=`basename $TrimInputFile | sed -e "s/.fastq/.trimmed.fastq/"`

java -jar /home/haohu/bin/trimmomatic-0.39/trimmomatic-0.39.jar SE -threads 32 $TrimInputFile $TrimOutputFile ILLUMINACLIP:/home/haohu/bin/trimmomatic-0.39/adapters/MyTruSeqList.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:35

done

## FastQC cleaned data

mkdir $WorkDir/fastqc-post

/home/haohu/bin/fastqc-0.11.9/fastqc ME34*.trimmed.fastq -t 32 -o ./fastqc-post




