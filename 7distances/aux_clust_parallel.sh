#!/bin/bash
#$ -N qclustdist
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

i=$SGE_TASK_ID
#i=1
first=$(( ($i - 1) * $size ))
last=$(( $i  * $size - 1))

i=`printf "%05d" $i`
sitename=$site\_$name
sitenamepart=$sitename\_part$i

echo $sitenamepart
echo $first
echo $last
echo $site

echo "*****VMD started"
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < functions/clusterdistances.tcl > logs/log_$sitenamepart.log -args $psf $dcd $sitenamepart $first $last $site
echo "*****VMD finished"

cd cluster/data

nfiles=`find *${sitename}_part* -type f | wc -l`

if [ $nfiles == $n ]
	then
	sleep 1

	cat *${sitename}_part* > ${sitename}.dat.tmp
	data="$(xargs printf ' %s' < ${sitename}.dat.tmp | cut -b 2-)"
	for word in $data; do echo $word; done > ${sitename}.dat
	rm *${sitename}_part* ${sitename}.dat.tmp

	cd ../..
	cat logs/*${sitename}_part* > logs/log_${sitename}.log
	rm logs/*${sitename}_part*
fi


