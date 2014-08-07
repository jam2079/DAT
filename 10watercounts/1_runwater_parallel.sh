#!/bin/bash/

run=$1
micro=$2

size=100
memory=1G

sites=(EC_cav EC_cha IC_cav IC_cha IV2)

source runs.txt

##########################################################################################

echo $name
mkdir -p watercounts logs

totframes=`/home/jam2079/programs/catdcd -num $dcd | grep Total | cut -d" " -f3`
n=$((($totframes + $size -1)/$size))

for site in ${sites[@]}
do
qsub -l h_vmem=$memory -t 1"-"$n aux_parallel.sh $name $size $n $site $psf $dcd
#qsub -l h_vmem=$memory -t 1 aux_parallel.sh $name $size $n $site
#sh aux_parallel.sh $name $size $n $site &
done

