#!/bin/bash/

name=DAT_run1
psf=/zenodotus/dat01/hwlab_store/hwlab_store036/xfer/khelgeo_dat_modeling/dat_comprehensive/run1/structure.psf
dcd=/zenodotus/dat01/hwlab_store/hwlab_store036/xfer/khelgeo_dat_modeling/dat_comprehensive/run1/run1_micro1.dcd
sites=(IC_cav IC_cha)

setsize=100
memory=1G

catdcd=/pbtech_mounts/hwlab_store011/mil2037_dat/Commands/catdcd
vmd=/softlib/exe/x86_64/bin/vmd

##########################################################################################

echo $name
mkdir -p watercounts/data watercounts/plots logs

totframes=`$catdcd -num $dcd | grep Total | cut -d" " -f3`
n=$((($totframes + $setsize -1)/$setsize))

for site in ${sites[@]}
do
qsub -l h_vmem=$memory -t 1"-"$n aux_parallel.sh $name $setsize $n $site $psf $dcd $vmd
done

