#!/bin/bash
#$ -N qSC
#$ -cwd
#$ -j y
#$ -m as
#$ -M jaime.medina.manresa@gmail.com
#$ -l h_vmem=30M
#$ -l os=rhel5.4

prot=DAT
run=$1

mkdir -p SC

netstat -anp | egrep '( PROT )|( LIG  )|( INT  )' ../proteins/$prot\_run$run\_selweistructure.psf > SC/$prot\_run$run\_SC_tmp1.dat
cut -c1-29 SC/$prot\_run$run\_SC\_tmp1.dat > SC/$prot\_run$run\_SC\_tmp2.dat
netstat -anp | egrep -v '(  C    )|(  N    )|(  O    )|(  CA   )|(  OT1  )|(  OT2  )' SC/$prot\_run$run\_SC_tmp2.dat > SC/$prot\_run$run\_SC_tmp3.dat
awk -F" " '{print $1}' SC/$prot\_run$run\_SC_tmp3.dat > SC/$prot\_run$run\_SC.dat
