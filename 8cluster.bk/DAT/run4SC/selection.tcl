
set prot [lindex $argv 0]
set run [lindex $argv 1]
set micro [lindex $argv 2]

### GET SELECTION

set name "protein/seltrajectory_micro$micro.dcd"
set test [file exists $name]
if { $test == 0 } {

	mol new "protein/structure.psf" waitfor all
	mol off top
	mol addfile "protein/run$run\_micro$micro.dcd" waitfor all

	set sel [atomselect top "(protein and noh) or name SOD CLA or resname DOP"]
	$sel writepsf "protein/$prot\_run$run\_selstructure.psf"
	set nf [molinfo top get numframes]
	animate write dcd $name beg 0 end [expr $nf - 1] waitfor all sel $sel
}

exit

