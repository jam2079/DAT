#!/bin/bash
#$ -N qdistances
#$ -cwd
#$ -j y
#$ -m as
#$ -M jaime.medina.manresa@gmail.com
#$ -l h_vmem=48G
#$ -l os=rhel5.4

prot=DAT
run=$1
micro=$2

echo $prot
echo run$run
echo micro$micro

name=$prot\_run$run\_micro$micro

#mkdir -p $prot/run$run/protein
#cp functions/* $prot/run$run/
#cp * $prot/run$run
#cd $prot/run$run
#rm q*

#cd protein
#ln -s _* .
#cd ..

psf=/pbtech_mounts/hwlab_store/khelgeo/xfer/khelgeo_dat_modeling/dat_comprehensive/run$run/structure.psf
dcd=/pbtech_mounts/hwlab_store/khelgeo/xfer/khelgeo_dat_modeling/dat_comprehensive/run$run/run$run\_micro$micro.dcd

if [ $run == 5 ]
	then
	psf=/home/jam2079/DAT/proteins/structure.psf
	dcd=/home/jam2079/DAT/proteins/run5.dcd
	name=$prot\_run$run
fi
if [ $run == 11 ]
	then
	psf=/pbtech_mounts/hwlab_store/khelgeo/xfer/khelgeo_dat_modeling/dat_comprehensive/pipdel1/structure.psf
	dcd=/pbtech_mounts/hwlab_store/khelgeo/xfer/khelgeo_dat_modeling/analysis_new/trajectory_nopip1.dcd
	name=$prot\_run$run
fi
if [ $run == 12 ]
	then
	psf=/pbtech_mounts/hwlab_store/khelgeo/xfer/khelgeo_dat_modeling/dat_comprehensive/pipdel2/structure.psf
	dcd=/pbtech_mounts/hwlab_store/khelgeo/xfer/khelgeo_dat_modeling/analysis_new/trajectory_nopip2.dcd
	name=$prot\_run$run
fi
if [ $run == 13 ]
	then
	psf=/pbtech_mounts/hwlab_store/khelgeo/xfer/khelgeo_dat_modeling/dat_comprehensive/pot2/structure.psf
	dcd=/pbtech_mounts/hwlab_store/khelgeo/xfer/khelgeo_dat_modeling/analysis_new/trajectory2_pot.dcd
	name=$prot\_run$run
fi
if [ $run == 14 ]
	then
	psf=/pbtech_mounts/hwlab_store/khelgeo/xfer/khelgeo_dat_modeling/analysis_new/potassium_in_run2_b/common/ionized.psf
	dcd=/pbtech_mounts/hwlab_store/khelgeo/xfer/khelgeo_dat_modeling/analysis_new/potassium_in_run2_b/analysis/trajectory.dcd
	name=$prot\_run$run
fi
if [ $run == 15 ]
	then
	psf=/pbtech_mounts/hwlab_store/khelgeo/xfer/khelgeo_dat_modeling/analysis_new/potassium_in_run4/common/ionized.psf
	dcd=/pbtech_mounts/hwlab_store/khelgeo/xfer/khelgeo_dat_modeling/analysis_new/potassium_in_run4/analysis/trajectory.dcd
	name=$prot\_run$run
fi
if [ $run == 16 ]
	then
	psf=/pbtech_mounts/hwlab_store/khelgeo/xfer/khelgeo_dat_modeling/analysis_new/potassium_in_run4_b/common/ionized.psf
	dcd=/pbtech_mounts/hwlab_store/khelgeo/xfer/khelgeo_dat_modeling/analysis_new/potassium_in_run4_b/analysis/trajectory.dcd
	name=$prot\_run$run
fi
if [ $run == 17 ]
	then
	psf=/pbtech_mounts/hwlab_store/khelgeo/dat_simulations/dat_from_michelle_dDAT_hDAT/hDAT_hybrid-3TT1-dDAT/common/ionized.psf
	dcd=/pbtech_mounts/hwlab_store/khelgeo/dat_simulations/dat_from_michelle_dDAT_hDAT/hDAT_hybrid-3TT1-dDAT/analysis/trajectory.dcd
	name=$prot\_run$run
fi
if [ $run == 18 ]
	then
	psf=/pbtech_mounts/hwlab_store/khelgeo/dat_simulations/dat_from_michelle_dDAT_hDAT/hDAT_with_nterm/common/ionized.psf
	dcd=/pbtech_mounts/hwlab_store/khelgeo/dat_simulations/dat_from_michelle_dDAT_hDAT/hDAT_with_nterm/analysis/trajectory.dcd
	name=$prot\_run$run
fi

##############################################################################

echo "*****VMD started"
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./functions/distances.tcl -args $psf $dcd $name
echo "*****VMD finished"

echo "*****R started"
/pbtech_mounts/hwlab_store011/mil2037/R-3.0.0/bin/Rscript ./functions/plot.R $prot $run
echo "*****R finished"

#mv protein/$prot\_run$run\_* /zenodotus/hwlab/scratch/jam2079/DAT/proteins/
#rm -rf protein

cd ../..

