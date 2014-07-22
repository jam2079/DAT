#!/bin/bash
#$ -N qplot1
#$ -cwd
#$ -j y
#$ -m as
#$ -M jam2079@med.cornell.edu
#$ -l h_vmem=1G
#$ -l os=rhel5.4

prot=DAT
run=$1
num=$SGE_TASK_ID

echo start$num
echo $prot
echo run$run
#echo tm$tm
echo mem1G

mkdir -p rigidity/evol/data rigidity/evol/plots
mkdir -p pairwise/evol/data pairwise/evol/plots
mkdir -p sweep/evol/data sweep/evol/plots

cp * $prot/run$run
cp functions/* $prot/run$run
cd $prot/run$run
rm q* *~

#/pbtech_mounts/hwlab_store011/mil2037/R-3.0.0/bin/Rscript ANALYSIS_evol_new.R $run $num

cd ../../pairwise/evol
/pbtech_mounts/hwlab_store011/mil2037/R-3.0.0/bin/Rscript heatmap_evol.R $run $num

cd ../../sweep/evol
/pbtech_mounts/hwlab_store011/mil2037/R-3.0.0/bin/Rscript sweep_heatmap_evol.R $run $num

