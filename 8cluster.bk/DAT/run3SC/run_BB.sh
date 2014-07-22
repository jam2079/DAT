#!/bin/bash
#$ -N qBB
#$ -cwd
#$ -j y
#$ -m as
#$ -M jaime.medina.manresa@gmail.com
#$ -l h_vmem=30M
#$ -l os=rhel5.4

prot=DAT
run=$1

mkdir -p BB

netstat -anp | egrep '( PROT )|( LIG  )|( INT  )' ../proteins/$prot\_run$run\_selweistructure.psf > BB/$prot\_run$run\_BB_tmp1.dat
cut -c1-29 BB/$prot\_run$run\_BB\_tmp1.dat > BB/$prot\_run$run\_BB\_tmp2.dat
netstat -anp | egrep '(  C    )|(  N    )|(  O    )|(  CA   )|(  OT1  )|(  OT2  )|( LIG  )|( INT  )' BB/$prot\_run$run\_BB_tmp2.dat > BB/$prot\_run$run\_BB_tmp3.dat
netstat -anp | egrep -v '(  H1)|(  H2)' BB/$prot\_run$run\_BB_tmp3.dat > BB/$prot\_run$run\_BB_tmp4.dat
awk -F" " '{print $1}' BB/$prot\_run$run\_BB_tmp4.dat > BB/$prot\_run$run\_BB.dat
