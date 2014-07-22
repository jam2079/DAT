#!/bin/bash
#$ -N qdatsolver
#$ -cwd
#$ -j y
#$ -m as
#$ -M jaime.medina.manresa@gmail.com
#$ -l h_vmem=100M
#$ -l os=rhel5.4

#num=$SGE_TASK_ID
num=$2

/pbtech_mounts/hwlab_store011/mil2037/R-3.0.0/bin/Rscript solver2.R DAT $1 $num
