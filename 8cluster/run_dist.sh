#!/bin/bash
#$ -N qgendist
#$ -cwd
#$ -j y
#$ -m ae
#$ -M jaime.medina.manresa@gmail.com
#$ -l h_vmem=10G
#$ -l os=rhel5.4

echo "*****R started"
~/programs/Rscript ./gendist.R
echo "*****R finished"


