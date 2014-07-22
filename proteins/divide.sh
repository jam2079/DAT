#!/bin/bash/

mkdir tmp$1
cd tmp$1
ln -s /zenodotus/dat01/hwlab_store/hwlab_store036/xfer/khelgeo_dat_modeling/dat_comprehensive/run$1/* .

for i in {0..9}
	do
	first=$(( $i * 1000 + 1 ))
	last=$(( $first + 999 ))

	coef=$(($2 - 1))

	echo $first
	echo $last
	
	/pbtech_mounts/hwlab_store011/mil2037_dat/Commands/catdcd -o run$1\_micro$coef$i\.dcd -first $first -last $last run$1\_micro$2.dcd 
	done
