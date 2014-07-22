#!/bin/bash/

name=$1
out="watercounts_$name.dat"
rm $out

cat *$name* > $out

window=$2

/pbtech_mounts/hwlab_store011/mil2037/R-3.0.0/bin/Rscript plot.R $name $window
