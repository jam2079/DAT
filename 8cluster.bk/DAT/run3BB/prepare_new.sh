#!/bin/bash

prot=DAT
run=$1

mkdir -p $prot/run$run

cp * $prot/run$run
cp functions/* $prot/run$run
cd $prot/run$run
rm q* *~

ln -s ../../../proteins/$prot\_run$run\_selweistructure.psf .
ln -s ../../../proteins/$prot\_run$run\_fixed_long.dcd .

sh getIL2_new.sh $prot $run

#qsub -t 1-5 BOOTSTRAPPING_TMP.sh $prot
#qsub -t 1-50 BOOTSTRAPPING_TMP.sh selionized.psf fixed.dcd 200
#qsub -t 1-50 BOOTSTRAPPING_TMP.sh selionized.psf fixed.dcd 500
#qsub -t 1-50 BOOTSTRAPPING_TMP.sh selionized.psf fixed.dcd 1000
#qsub -t 1-50 BOOTSTRAPPING_TMP.sh selionized.psf fixed.dcd 2000

#qsub ANALYSIS.sh 50 1 fixed.dcd
#qsub ANALYSIS.sh 50 200 fixed.dcd
#qsub ANALYSIS.sh 50 500 fixed.dcd
#qsub ANALYSIS.sh 50 1000 fixed.dcd
#qsub ANALYSIS.sh 50 2000 fixed.dcd

