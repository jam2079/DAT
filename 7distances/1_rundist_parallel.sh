#!/bin/bash/

run=$1
micro=$2

size=100
memory=2G

title=distance
sites=(60_428)

source /home/jam2079/DAT/7distances/runs.txt

##########################################################################################

echo $name
mkdir -p distances/data distances/plots logs

totframes=`/home/jam2079/programs/catdcd -num $inputpath/$dcd | grep Total | cut -d" " -f3`
#totframes=10000
n=$((($totframes + $size -1)/$size))

for site in ${sites[@]}
do
qsub -N q$site$run$micro -l h_vmem=$memory -t 1"-"$n aux_dist_parallel.sh $title $name $site $psf $dcd $n $size
#qsub -l h_vmem=$memory -t 1 aux_parallel.sh $name $size $n $site $psf $dcd
#sh aux_dist_parallel.sh $title $name $site $psf $dcd $n $size &
done

