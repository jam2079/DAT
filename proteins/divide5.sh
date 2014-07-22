#!/bin/bash/

mkdir tmp5
cd tmp5
ln -s ../run5.dcd .

for i in {0..21}
	do
	first=$(( $i * 1000 + 1 ))
	last=$(( $first + 999 ))

	i=`printf "%02d" $i`

	echo $first
	echo $last
	
	/pbtech_mounts/hwlab_store011/mil2037_dat/Commands/catdcd -o run5\_micro$i\.dcd -first $first -last $last run5.dcd 
	done
