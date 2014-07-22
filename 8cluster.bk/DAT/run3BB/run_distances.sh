#!/bin/bash
#$ -N qcluster
#$ -cwd
#$ -j y
#$ -m as
#$ -M jaime.medina.manresa@gmail.com
#$ -l h_vmem=20G
#$ -l os=rhel5.4

prot=DAT
run=$1
step=15

echo $prot
echo run$run

mkdir -p distances/data distances/plots
mkdir -p $prot/run$run/protein
cp * $prot/run$run
cp functions/* $prot/run$run
cd $prot/run$run
rm q* all_run* *~

ln -s /zenodotus/hwlab/scratch/jam2079/DAT/proteins/$prot\_run$run\_selwei* .
#ln -s /zenodotus/dat01/hwlab_store/hwlab_store036/xfer/khelgeo_dat_modeling/dat_comprehensive/run$run/* .

#if [ ! -f $prot\_run$run\_seltrajectory.dcd ]; then
#	for micro in `seq 1 4`;
#		do
#			echo "*****VMD started selection micro $micro"
#			/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./selection.tcl > vmdselection_micro$micro.log -args $prot $run $micro
#			echo "*****VMD finished"
#		done
#
#	echo "*****CatDCD started"
#	/pbtech_mounts/hwlab_store011/mil2037_dat/Commands/catdcd -o $prot\_run$run\_seltrajectory.dcd seltrajectory_micro1.dcd seltrajectory_micro2.dcd seltrajectory_micro3.dcd seltrajectory_micro4.dcd
#	echo "*****CatDCD finished"
#	cd ..
#fi
#
#if [ ! -f $prot\_run$run\_selweialitrajectory.dcd ]; then
#	echo "*****VMD aligning started"
#	~/xvfb_wrapper.sh /softlib/exe/x86_64/bin/vmd -eofexit < ./weights.tcl > vmdweights.log -args $prot $run $step
#	~/xvfb_wrapper.sh /softlib/exe/x86_64/bin/vmd -eofexit < ./align.tcl > vmdalign.log -args $prot $run
#	echo "*****VMD finished"
#fi

#rm *micro* structure.psf
#mv * /zenodotus/hwlab/scratch/jam2079/proteins/

echo "*****VMD started"
#/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./distances.tcl > vmddistances.log -args $prot $run
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./distances.tcl -args $prot $run
echo "*****VMD finished"

echo "*****R started"
../../../Rscript distances.R $prot $run
echo "*****R finished"

#vmdrun distances.tcl
#Rscript distances.R

rm $prot\_run$run\_selwei*

cd ../..

