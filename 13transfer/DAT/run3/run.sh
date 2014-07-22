#!/bin/bash
#$ -N qtransfer4
#$ -cwd
#$ -j y
#$ -m as
#$ -M jam2079@med.cornell.edu
#$ -l h_vmem=4G
#$ -l os=rhel5.4

prot=DAT
run=$1

echo $prot
echo run$run
echo mem4G

mkdir -p $prot/run$run/pdbs

cp * $prot/run$run
cp functions/* $prot/run$run
cd $prot/run$run
rm q* *~

ln -s  ../../../proteins/$prot\_run$run\_selweistructure.psf .
ln -s  ../../../proteins/$prot\_run$run\_fixed_long.dcd .

for n in {0..400};
	do /softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./createpdb.tcl -args $run $n
	cat dcd* > file_all$n\.pdb
	rm dcd*
	nn=`printf "%04d" $n`
	/pbtech_mounts/hwlab_store011/mil2037_dat/Commands/catdcd -o file_all$nn\.dcd -pdb file_all$n\.pdb
	rm file_all*.pdb
done

/pbtech_mounts/hwlab_store011/mil2037_dat/Commands/catdcd -o DAT_run$run\_transfer.dcd file*

mv DAT_run$run\_* ../../../proteins
rm file_all*
