#!/bin/bash
#$ -N qkinks
#$ -cwd
#$ -j y
#$ -m as
#$ -M jaime.medina.manresa@gmail.com
#$ -l h_vmem=4G
#$ -l os=rhel5.4

installdir=/home/nij2003/openstructure
export PATH=$installdir/bin${PATH+:$PATH}
export LD_LIBRARY_PATH=$installdir/lib64:$installdir/lib${LD_LIBRARY_PATH+:$LD_LIBRARY_PATH}
alias ost_develop=$installdir/develop/stage/bin/ost
alias dng_develop=$installdir/develop/stage/bin/dng
alias ost_stable=$installdir/release-1.3.3/stage/bin/ost
alias dng_stable=$installdir/release-1.3.3/stage/bin/dng

prot=DAT
run=$1

echo $prot
echo run$run

mkdir -p $prot/run$run/protein
cp * $prot/run$run
cd $prot/run$run
rm q* *~

ln -s /zenodotus/hwlab/scratch/jam2079/proteins/$prot\_run$run\_selstructure.psf protein/structure.psf
ln -s /zenodotus/hwlab/scratch/jam2079/proteins/$prot\_run$run\_seltrajectory.dcd protein/prot.dcd

if [ ! -f protein/prot.pdb ]; then
	echo "*****VMD started"
	/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./writepdb.tcl > vmdwritepdb.log
	echo "*****VMD finished"
fi

echo "*****OpenStructure started"
ost_develop kink5_273.py
ost_develop kink5_264.py
ost_develop kink5_265.py
ost_develop kink8_425.py
ost_develop kink8_426.py
echo "*****OpenStructure finished"

for FILE in ben* ; do mv $FILE kink_$prot\_run$run\_$FILE ; done

mv kink_* ../../kinks/data

echo "*****R started"
../../../Rscript kinks.R $prot $run
echo "*****R finished"

rm protein/structure.psf protein/prot.dcd

cd ../..

