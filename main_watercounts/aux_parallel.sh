#!/bin/bash
#$ -N qwaterparallel
#$ -cwd
#$ -j y
#$ -l os=rhel5.4

rm q*
name=$1
size=$2
n=$3
site=$4
psf=$5
dcd=$6
vmd=$7

i=$SGE_TASK_ID
first=$(( ($i - 1) * $size ))
last=$(( $i  * $size - 1))

i=`printf "%05d" $i`
sitename=$site\_$name
sitenamepart=$sitename\_part$i

$vmd -dispdev text -eofexit < scripts/watercounts.tcl > logs/log_$sitenamepart.log -args $psf $dcd $sitenamepart $first $last $site

cd watercounts/data

nfiles=`find *${sitename}_part* -type f | wc -l`

if [ $nfiles == $n ]
	then
	sleep 1

	cat *${sitename}_part* > watercounts_${sitename}.dat.tmp
	data="$(xargs printf ' %s' < watercounts_${sitename}.dat.tmp | cut -b 2-)"
	for word in $data; do echo $word; done > watercounts_${sitename}.dat
	rm *${sitename}_part* watercounts_${sitename}.dat.tmp

	cd ../..
	cat logs/*${sitename}_part* > logs/log_${sitename}.log
	rm logs/*${sitename}_part*
fi


