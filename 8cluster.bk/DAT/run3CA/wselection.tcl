
set prot [lindex $argv 0]
set run [lindex $argv 1]
set micro [lindex $argv 2]

### GET SELECTION

set name "protein/trajectory_micro$micro.dcd"
set test [file exists $name]
if { $test == 0 } {

	mol new "protein/structure.psf" waitfor all
	mol off top
	mol addfile "protein/run$run\_micro$micro.dcd" waitfor all

	set sel [atomselect top "all"]
	$sel writepsf "protein/$prot\_run$run\_structure.psf"
	set nf [molinfo top get numframes]
	animate write dcd $name beg 0 end [expr $nf - 1] waitfor all sel $sel
}

exit

