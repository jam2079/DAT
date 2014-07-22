#!/bin/bash/

run=$1
micro=$2

size=100
memory=1G

sites=(contacts)
#sites=(IV2)

source /home/jam2079/DAT/7distances/runs.txt

##########################################################################################

echo $name
mkdir -p cluster/data cluster/plots logs

totframes=`/pbtech_mounts/hwlab_store011/mil2037_dat/Commands/catdcd -num $inputpath/$dcd | grep Total | cut -d" " -f3`
n=$((($totframes + $size -1)/$size))

for site in ${sites[@]}
do
qsub -l h_vmem=$memory -t 1"-"$n aux_clust_parallel.sh $name $size $n $site $psf $dcd
#qsub -l h_vmem=$memory -t 1 aux_parallel.sh $name $size $n $site $psf $dcd
#sh aux_parallel.sh $name $size $n $site $psf $dcd &
done

