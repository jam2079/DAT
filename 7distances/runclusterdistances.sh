#!/bin/bash
#$ -N qclustdist
#$ -cwd
#$ -j y
#$ -l h_vmem=16G
#$ -l os=rhel5.4

prot=DAT
run=$1
micro=$2

echo $prot
echo run$run
echo micro$micro

mkdir -p cluster/data
#cp functions/* $prot/run$run/
#cp * $prot/run$run
#cd $prot/run$run
#rm q*

source /home/jam2079/DAT/7distances/runs.txt

################################################################################

echo "*****VMD started"
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./functions/clusterdistances.tcl -args $psf $dcd $name
echo "*****VMD finished"

echo "*****R started"
#~/programs/Rscript ./functions/plot.R $prot $run
echo "*****R finished"

#mv protein/$prot\_run$run\_* /zenodotus/hwlab/scratch/jam2079/DAT/proteins/
#rm -rf protein

#cd ../..

