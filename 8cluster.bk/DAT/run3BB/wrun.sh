#!/bin/bash
#$ -N qcluster
#$ -cwd
#$ -j y
#$ -m as
#$ -M jaime.medina.manresa@gmail.com
#$ -l h_vmem=56G
#$ -l os=rhel5.4

prot=DAT
run=$1
step=15

echo $prot
echo run$run

mkdir -p $prot/run$run/protein
cp * $prot/run$run
cd $prot/run$run
rm q* all_run*

ln -s /zenodotus/hwlab/scratch/jam2079/proteins/$prot\_run$run\_* protein/
ln -s /zenodotus/dat01/hwlab_store/hwlab_store036/xfer/khelgeo_dat_modeling/dat_comprehensive/run$run/* protein/

if [ ! -f protein/$prot\_run$run\_trajectory.dcd ]; then
	cd protein
	echo "*****CatDCD started"
	/pbtech_mounts/hwlab_store011/mil2037_dat/Commands/catdcd -o /zenodotus/hwlab/scratch/jam2079/proteins/$prot\_run$run\_trajectory.dcd run$run\_micro1.dcd run$run\_micro2.dcd run$run\_micro3.dcd
	echo "*****CatDCD finished"
	cd ..
fi

ln -s /zenodotus/hwlab/scratch/jam2079/proteins/$prot\_run$run\_trajectory.dcd protein/

if [ ! -f protein/$prot\_run$run\_weialitrajectory.dcd ]; then
	echo "*****VMD aligning started"
#	~/xvfb_wrapper.sh /softlib/exe/x86_64/bin/vmd -eofexit < ./wweights.tcl > vmdwweights.log -args $prot $run $step
#	~/xvfb_wrapper.sh /softlib/exe/x86_64/bin/vmd -eofexit < ./walign.tcl > vmdwalign.log -args $prot $run
	echo "*****VMD finished"
fi

rm protein/*micro* protein/structure.psf
mv protein/* /zenodotus/hwlab/scratch/jam2079/proteins/
rm -rf protein

cd ../..

