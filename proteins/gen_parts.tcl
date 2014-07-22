set run 4

mol delete all
mol load psf DAT_run$run\_selweistructure.psf dcd DAT_run$run\_fixed_long.dcd

set BB [atomselect top "not hydrogen and ((backbone and segname PROT) or segname INT LIG)"]
set SC [atomselect top "not hydrogen and ((sidechain and segname PROT) or segname INT LIG)"]
set CA [atomselect top "not hydrogen and ((name CA and segname PROT) or segname INT LIG)"]

$BB writepsf DAT_run$run\BB_selweistructure.psf
$SC writepsf DAT_run$run\SC_selweistructure.psf
$CA writepsf DAT_run$run\CA_selweistructure.psf

set nf [molinfo top get numframes]

animate write dcd DAT_run$run\BB_fixed_long.dcd beg 0 end [expr $nf - 1] waitfor all sel $BB
animate write dcd DAT_run$run\SC_fixed_long.dcd beg 0 end [expr $nf - 1] waitfor all sel $SC
animate write dcd DAT_run$run\CA_fixed_long.dcd beg 0 end [expr $nf - 1] waitfor all sel $CA

exit

