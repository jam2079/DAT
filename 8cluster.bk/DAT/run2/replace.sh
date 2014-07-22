#!/bin/bash/

TMPFILE=./tmp.$$
for filename in *long*; do
sed 's/"prot\\_/"$prot\\_/g' $filename > $TMPFILE
mv $TMPFILE $filename
done
