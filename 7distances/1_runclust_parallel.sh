#!/bin/bash/

run=$1
micro=$2

size=100
memory=2G

sites=(tm16distance mediatedcontacts cadistance_66_443 cadistance_333_443)

source /home/jam2079/DAT/7distances/runs.txt

##########################################################################################

echo $name
mkdir -p cluster/data cluster/plots logs

totframes=`/home/jam2079/programs/catdcd -num $inputpath/$dcd | grep Total | cut -d" " -f3`
n=$((($totframes + $size -1)/$size))

for site in ${sites[@]}
do
qsub -l h_vmem=$memory -t 1"-"$n aux_clust_parallel.sh $name $size $n $site $psf $dcd
#qsub -l h_vmem=$memory -t 80 aux_clust_parallel.sh $name $size $n $site $psf $dcd
#sh aux_parallel.sh $name $size $n $site $psf $dcd &
done

