#!/bin/bash
#$ -N qkinks
#$ -cwd
#$ -j y
#$ -m as
#$ -M jaime.medina.manresa@gmail.com
#$ -l h_vmem=4G
#$ -l os=rhel5.4

installdir=/home/nij2003/openstructure
export PATH=/home/nij2003/openstructure/bin${PATH+:$PATH}
export LD_LIBRARY_PATH=/home/nij2003/openstructure/lib64:/home/nij2003/openstructure/lib${LD_LIBRARY_PATH+:$LD_LIBRARY_PATH}
alias /home/nij2003/openstructure/develop/stage/bin/dng=/home/nij2003/openstructure/develop/stage/bin/ost
alias dng_develop=/home/nij2003/openstructure/develop/stage/bin/dng
alias ost_stable=/home/nij2003/openstructure/release-1.3.3/stage/bin/ost
alias dng_stable=/home/nij2003/openstructure/release-1.3.3/stage/bin/dng

prot=DAT
run=$1

echo $prot
echo run$run

#mkdir -p $prot/run$run/protein
#cp * $prot/run$run
#cd $prot/run$run
#rm q* *~

#cd protein
#ln -s ../../../../proteins/$prot\_run$run\_selstructure.psf structure.psf
#ln -s ../../../../proteins/$prot\_run$run\_seltrajectory.dcd prot.dcd
#cd ..

psf=/zenodotus/dat01/hwlab_store/hwlab_store036/xfer/khelgeo_dat_modeling/dat_comprehensive/run$run/structure.psf
dcd=/zenodotus/dat01/hwlab_store/hwlab_store036/xfer/khelgeo_dat_modeling/dat_comprehensive/run$run/run$run\_micro$micro.dcd

if [ $run == 5 ]
	then
	psf=/home/jam2079/DAT/proteins/structure.psf
	dcd=/home/jam2079/DAT/proteins/run5.dcd
fi
if [ $run == 11 ]
	then
	psf=/pbtech_mounts/hwlab_store036/xfer/khelgeo_dat_modeling/dat_comprehensive/pipdel1/structure.psf
	dcd=/pbtech_mounts/hwlab_store036/xfer/khelgeo_dat_modeling/analysis_new/trajectory_nopip1.dcd
fi
if [ $run == 12 ]
	then
	psf=/pbtech_mounts/hwlab_store036/xfer/khelgeo_dat_modeling/dat_comprehensive/pipdel2/structure.psf
	dcd=/pbtech_mounts/hwlab_store036/xfer/khelgeo_dat_modeling/analysis_new/trajectory_nopip2.dcd
fi
if [ $run == 13 ]
	then
	psf=/pbtech_mounts/hwlab_store036/xfer/khelgeo_dat_modeling/dat_comprehensive/pot2/structure.psf
	dcd=/pbtech_mounts/hwlab_store036/xfer/khelgeo_dat_modeling/analysis_new/trajectory2_pot.dcd
fi
if [ $run == 14 ]
	then
	psf=/pbtech_mounts/hwlab_store036/xfer/khelgeo_dat_modeling/analysis_new/potassium_in_run2_b/common/ionized.psf
	dcd=/pbtech_mounts/hwlab_store036/xfer/khelgeo_dat_modeling/analysis_new/potassium_in_run2_b/analysis/trajectory.dcd
fi
if [ $run == 15 ]
	then
	psf=/pbtech_mounts/hwlab_store036/xfer/khelgeo_dat_modeling/analysis_new/potassium_in_run4/common/ionized.psf
	dcd=/pbtech_mounts/hwlab_store036/xfer/khelgeo_dat_modeling/analysis_new/potassium_in_run4/analysis/trajectory.dcd
fi
if [ $run == 16 ]
	then
	psf=/pbtech_mounts/hwlab_store036/xfer/khelgeo_dat_modeling/analysis_new/potassium_in_run4_b/common/ionized.psf
	dcd=/pbtech_mounts/hwlab_store036/xfer/khelgeo_dat_modeling/analysis_new/potassium_in_run4_b/analysis/trajectory.dcd
fi
if [ $run == 17 ]
	then
	psf=/pbtech_mounts/hwlab_store/khelgeo/dat_simulations/dat_from_michelle_dDAT_hDAT/hDAT_hybrid-3TT1-dDAT/common/ionized.psf
	dcd=/pbtech_mounts/hwlab_store/khelgeo/dat_simulations/dat_from_michelle_dDAT_hDAT/hDAT_hybrid-3TT1-dDAT/analysis/trajectory.dcd
fi
if [ $run == 18 ]
	then
	psf=/pbtech_mounts/hwlab_store/khelgeo/dat_simulations/dat_from_michelle_dDAT_hDAT/hDAT_with_nterm/common/ionized.psf
	dcd=/pbtech_mounts/hwlab_store/khelgeo/dat_simulations/dat_from_michelle_dDAT_hDAT/hDAT_with_nterm/analysis/trajectory.dcd
fi

echo "*****VMD started"
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./functions/writepdb.tcl -args $psf $dcd $run 
echo "*****VMD finished"

echo "*****OpenStructure started"
#~/scripts/xvfb_wrapper.sh /home/nij2003/openstructure/develop/stage/bin/dng -s kink5_273.py 
~/scripts/xvfb_wrapper.sh /home/nij2003/openstructure/develop/stage/bin/dng -s kink5_264.py prot$run.pdb $dcd $run
~/scripts/xvfb_wrapper.sh /home/nij2003/openstructure/develop/stage/bin/dng -s kink5_265.py prot$run.pdb $dcd $run
#~/scripts/xvfb_wrapper.sh /home/nij2003/openstructure/develop/stage/bin/dng -s kink8_425.py
#~/scripts/xvfb_wrapper.sh /home/nij2003/openstructure/develop/stage/bin/dng -s kink8_426.py
echo "*****OpenStructure finished"

rm prot$run.pdb

#for FILE in ben* ; do mv $FILE kink_$prot\_run$run\_$FILE ; done

#mv kink_* ../../kinks/data

echo "*****R started"
#/pbtech_mounts/hwlab_store011/mil2037/R-3.0.0/bin/Rscript kinks.R $prot $run
echo "*****R finished"

#rm protein/structure.psf protein/prot.dcd

#cd ../..

