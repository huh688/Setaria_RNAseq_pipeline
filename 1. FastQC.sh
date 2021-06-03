#!/bin/bash
#SBATCH -p batch
#SBATCH -t 3-00:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32
#SBATCH --mail-type=ALL
#SBATCH --output=%x.%A.out

WorkDir=/scratch/haohu/Setaria/

cd $WorkDir 


## Step 1 FastQC raw data

mkdir $WorkDir/fastqc-pre

/home/haohu/bin/fastqc-0.11.9/fastqc *.fastq.gz -t 32 -o ./fastqc-pre