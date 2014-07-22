#!/bin/bash
#$ -N qdistancesalign
#$ -cwd
#$ -j y
#$ -m as
#$ -M jaime.medina.manresa@gmail.com
#$ -l h_vmem=4G
#$ -l os=rhel5.4

prot=DAT
run=$1
step=15

echo $prot
echo run$run

mkdir -r $prot/run$run/protein
cp * $prot/run$run
cd $prot/run$run
rm q*

ln -s /zenodotus/hwlab/scratch/jam2079/proteins/$prot\_run$run\_* protein/

echo "*****VMD started"
~/xvfb_wrapper.sh /softlib/exe/x86_64/bin/vmd -eofexit < ./weights.tcl > vmdweights.log -args $prot $run $step
~/xvfb_wrapper.sh /softlib/exe/x86_64/bin/vmd -eofexit < ./align.tcl > vmdalign.log -args $prot $run
echo "*****VMD finished"

mv protein/$prot\_run$run\_* /zenodotus/hwlab/scratch/jam2079/proteins/
#rm -rf protein

cd ../..

