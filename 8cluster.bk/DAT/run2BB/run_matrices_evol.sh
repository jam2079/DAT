#!/bin/bash
#$ -N qcreatemat
#$ -cwd
#$ -j y
#$ -m as
#$ -M jaime.medina.manresa@gmail.com
#$ -l h_vmem=4G
#$ -l os=rhel5.4

prot=DAT
run=$1

mkdir -p $prot/run$run
psf=$prot\_run$run\_selweistructure.psf
dcd=$prot\_run$run\_fixed_long.dcd
k=$2
m=$3
j=$(($SGE_TASK_ID - 1))

cd $prot/run$run
#rm $psf
#rm $dcd
#rm $prot\_run$run\_fixed_long.dcd

ln -s ../../../proteins/$psf .
ln -s ../../../proteins/$dcd .
#ln -s ../../proteins/$prot\_run$run\_fixed_long.dcd $prot\_run$run\_fixed_long.dcd

/pbtech_mounts/hwlab_store011/mil2037_dat/Commands/catdcd -o $((${j}*${m} + 1))_$((${j}*${m} + ${k})).dcd -first $((${j}*${m} + 1)) -last $((${j}*${m} + ${k})) $dcd

/home/mil2037/carma/bin/linux/carma -cov -write -atmid ALLID $((${j}*${m} + 1))_$((${j}*${m} + ${k})).dcd $psf

rm $((${j}*${m} + 1))_$((${j}*${m} + ${k})).dcd
rm $((${j}*${m} + 1))_$((${j}*${m} + ${k})).dcd.varcov.ps








