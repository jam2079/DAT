#!/bin/bash
#$ -N qwholedat
#$ -cwd
#$ -j y
#$ -m as
#$ -M jaime.medina.manresa@gmail.com
#$ -l h_vmem=4G
#$ -l os=rhel5.4

prot=DAT
run=$1
step=10

echo $prot
echo run$run

mkdir -p $prot/run$run rmsd/data rmsd/plots strs/tmp

cp functions/* $prot/run$run
cp * $prot/run$run
cd $prot/run$run
rm q* *~

ln -s /zenodotus/dat01/hwlab_store/hwlab_store036/xfer/khelgeo_dat_modeling/dat_comprehensive/run$run/* .
ln -s ../../../proteins/$prot\_run$run\_* .
#exit
if [ ! -f $prot\_run$run\_seltrajectory.dcd ]; then
if [ ! -f $prot\_run$run\_selweialitrajectory.dcd ]; then
if [ ! -f $prot\_run$run\_selweialicattrajectory.dcd ]; then
if [ ! -f $prot\_run$run\_fixed_long.dcd ]; then
	for micro in `seq 1 4`;
		do
			echo "*****VMD started selection micro $micro"
			/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./selection.tcl -args $prot $run $micro
			echo "*****VMD finished"
		done

	echo "*****CatDCD started"
	/pbtech_mounts/hwlab_store011/mil2037_dat/Commands/catdcd -o $prot\_run$run\_seltrajectory.dcd seltrajectory_micro1.dcd seltrajectory_micro2.dcd seltrajectory_micro3.dcd seltrajectory_micro4.dcd
	echo "*****CatDCD finished"
	cd ..
fi
fi
fi
fi

if [ ! -f $prot\_run$run\_selweialitrajectory.dcd ]; then
if [ ! -f $prot\_run$run\_selweialicattrajectory.dcd ]; then
if [ ! -f $prot\_run$run\_fixed.dcd ]; then
	echo "*****VMD aligning started"
	~/xvfb_wrapper.sh /softlib/exe/x86_64/bin/vmd -eofexit < ./weights.tcl -args $prot $run $step
	~/xvfb_wrapper.sh /softlib/exe/x86_64/bin/vmd -eofexit < ./align.tcl -args $prot $run
	sleep 3
	echo "*****VMD finished"
fi
fi
fi

if [ ! -f $prot\_run$run\_fixed_long.dcd ]; then
	echo "*****Fixing started"
	sh fix_symmetry_long.sh $prot $run
	echo "*****Fixing finished"
	sleep 3
fi

echo "*****VMD RMSD started"
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./rmsdcalc.tcl -args $prot $run
echo "*****VMD finished"

if [ ! -f ../../strs/$prot\_run$run\_str.dat ]; then
	echo "*****VMD str started"
	/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./ss.tcl -args $prot $run
	echo "*****VMD finished"
	echo "*****R str started"
	/pbtech_mounts/hwlab_store011/mil2037/R-3.0.0/bin/Rscript define_tms.R $prot $run
	echo "*****R finished"
fi

echo "*****R RMSD started"
/pbtech_mounts/hwlab_store011/mil2037/R-3.0.0/bin/Rscript plotgen.R $prot $run
echo "*****R finished"

rm *micro* structure.psf
#mv $prot\_run$run\_* ../../../proteins
find $prot\_run$run\_* -maxdepth 1 -mindepth 1 -not -name *.Rdata -print0 | xargs -0 mv -t ../../../proteins
#rm $prot\_run$run\_*

cd ../..

