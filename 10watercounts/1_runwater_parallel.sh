#!/bin/bash/

run=$1
micro=$2

name=DAT_run$run\_micro$micro
psf=/zenodotus/dat01/hwlab_store/hwlab_store036/xfer/khelgeo_dat_modeling/dat_comprehensive/run$run/structure.psf
dcd=/zenodotus/dat01/hwlab_store/hwlab_store036/xfer/khelgeo_dat_modeling/dat_comprehensive/run$run/run$run\_micro$micro.dcd
setsize=100
memory=1G

sites=(EC_cav)
#sites=(IV2)

if [ $run == 5 ]
	then
	psf=/home/jam2079/DAT/proteins/structure.psf
	dcd=/home/jam2079/DAT/proteins/run5.dcd
fi
if [ $run == 11 ]
	then
	psf=/zenodotus/dat01/hwlab_store/hwlab_store036/xfer/khelgeo_dat_modeling/dat_comprehensive/pipdel1/structure.psf
	dcd=/zenodotus/dat01/hwlab_store/hwlab_store036/xfer/khelgeo_dat_modeling/analysis_new/trajectory_nopip1.dcd
fi
if [ $run == 12 ]
	then
	psf=/pbtech_mounts/hwlab_store036/xfer/khelgeo_dat_modeling/dat_comprehensive/pipdel2/structure.psf
	dcd=/pbtech_mounts/hwlab_store036/xfer/khelgeo_dat_modeling/analysis_new/trajectory_nopip2.dcd
fi
if [ $run == 13 ]
	then
	psf=/zenodotus/dat01/hwlab_store/hwlab_store036/xfer/khelgeo_dat_modeling/dat_comprehensive/pot2/structure.psf
	dcd=/zenodotus/dat01/hwlab_store/hwlab_store036/xfer/khelgeo_dat_modeling/analysis_new/trajectory2_pot.dcd
fi
if [ $run == 14 ]
	then
	psf=/pbtech_mounts/hwlab_store036/xfer/khelgeo_dat_modeling/analysis_new/potassium_in_run2_b/common/ionized.psf
	dcd=/pbtech_mounts/hwlab_store036/xfer/khelgeo_dat_modeling/analysis_new/potassium_in_run2_b/analysis/trajectory.dcd
fi
if [ $run == 15 ]
	then
	psf=/zenodotus/dat01/hwlab_store/hwlab_store036/xfer/khelgeo_dat_modeling/analysis_new/potassium_in_run4/common/ionized.psf
	dcd=/zenodotus/dat01/hwlab_store/hwlab_store036/xfer/khelgeo_dat_modeling/analysis_new/potassium_in_run4/analysis/trajectory.dcd
fi
if [ $run == 16 ]
	then
	psf=/zenodotus/dat01/hwlab_store/hwlab_store036/xfer/khelgeo_dat_modeling/analysis_new/potassium_in_run4_b/common/ionized.psf
	dcd=/zenodotus/dat01/hwlab_store/hwlab_store036/xfer/khelgeo_dat_modeling/analysis_new/potassium_in_run4_b/analysis/trajectory.dcd
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

name=DAT_run$run

##########################################################################################

echo $name
#echo "*****File preparation started"
mkdir -p watercounts logs
#ln -s $inputpsf structure_$name.psf
#ln -s $inputdcd trajectory_$name.dcd
#echo "*****File preparation finished"

totframes=`/pbtech_mounts/hwlab_store011/mil2037_dat/Commands/catdcd -num $inputpath/$dcd | grep Total | cut -d" " -f3`
n=$((($totframes + $setsize -1)/$setsize))

for site in ${sites[@]}
do
qsub -l h_vmem=$memory -t 1"-"$n aux_parallel.sh $name $setsize $n $site $psf $dcd
#qsub -l h_vmem=$memory -t 1 aux_parallel.sh $name $setsize $n $site
#sh aux_parallel.sh $name $setsize $n $site &
done

