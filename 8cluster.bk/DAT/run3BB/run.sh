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

mkdir -p $prot/run$run/protein
cp * $prot/run$run
cd $prot/run$run
rm q* all_run* *~

ln -s /zenodotus/hwlab/scratch/jam2079/proteins/$prot\_run$run\_* protein/
ln -s /zenodotus/dat01/hwlab_store/hwlab_store036/xfer/khelgeo_dat_modeling/dat_comprehensive/run$run/* protein/

if [ ! -f protein/$prot\_run$run\_seltrajectory.dcd ]; then
	for micro in `seq 1 3`;
		do
			echo "*****VMD started selection micro $micro"
			/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./selection.tcl > vmdselection_micro$micro.log -args $prot $run $micro
			echo "*****VMD finished"
		done

	cd protein
	echo "*****CatDCD started"
	/pbtech_mounts/hwlab_store011/mil2037_dat/Commands/catdcd -o $prot\_run$run\_seltrajectory.dcd seltrajectory_micro1.dcd seltrajectory_micro2.dcd seltrajectory_micro3.dcd
	echo "*****CatDCD finished"
	cd ..
fi

if [ ! -f protein/$prot\_run$run\_selweialitrajectory.dcd ]; then
	echo "*****VMD aligning started"
	~/xvfb_wrapper.sh /softlib/exe/x86_64/bin/vmd -eofexit < ./weights.tcl > vmdweights.log -args $prot $run $step
	~/xvfb_wrapper.sh /softlib/exe/x86_64/bin/vmd -eofexit < ./align.tcl > vmdalign.log -args $prot $run
	echo "*****VMD finished"
fi

rm protein/*micro* protein/structure.psf
mv protein/* /zenodotus/hwlab/scratch/jam2079/proteins/
rm -rf protein

cd ../..

