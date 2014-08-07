#!/bin/bash/

name=DAT_run1
psf=protein/structure.psf
dcd=protein/run1_micro1.dcd
sites=(EC_cha)

size=100
memory=1G

catdcd=/home/jam2079/programs/catdcd
vmd=/softlib/exe/x86_64/bin/vmd

##########################################################################################

mkdir -p watercounts/data watercounts/plots logs

totframes=`$catdcd -num $dcd | grep Total | cut -d" " -f3`
n=$((($totframes + $size -1)/$size))

for site in ${sites[@]}
do
echo $name $site
qsub -l h_vmem=$memory -t 1"-"$n aux_parallel.sh $name $size $n $site $psf $dcd $vmd
done

