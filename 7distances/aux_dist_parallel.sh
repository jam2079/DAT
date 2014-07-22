#!/bin/bash
#$ -cwd
#$ -j y
#$ -l os=rhel5.4

rm q*
title=$1
name=$2
site=$3
psf=$4
dcd=$5
n=$6
size=$7

part=$SGE_TASK_ID
#part=1
first=$(( ($part - 1) * $size ))
last=$(( $part * $size - 1))
part=`printf "%05d" $part`

echo "***********"
echo $title
echo $site
echo $name
echo $part

echo "*****VMD started"
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < functions/distances.tcl > logs/log_$title\_$site\_$name\_part$part.log -args $title $site $name $part $psf $dcd $first $last
echo "*****VMD finished"

cd distances/data

nfiles=`find $title\_$site\_$name\_part* -type f | wc -l`

if [ $nfiles == $n ]
	then
	sleep 1

	cat $title\_$site\_$name\_part* > $title\_$site\_$name.dat.tmp
	data="$(xargs printf ' %s' < $title\_$site\_$name.dat.tmp | cut -b 2-)"
	for word in $data; do echo $word; done > $title\_$site\_$name.dat
	rm $title\_$site\_$name\_part* $title\_$site\_$name.dat.tmp

	cd ../..
	cat logs/log_$title\_$site\_$name\_part* > logs/log_$title\_$site\_$name.log
	rm logs/log_$title\_$site\_$name\_part*
fi


