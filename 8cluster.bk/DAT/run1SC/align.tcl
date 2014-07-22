
set prot [lindex $argv 0]
set run [lindex $argv 1]

### CREATE NEW ALIGNED DCD FILE

set name "protein/$prot\_run$run\_selweialitrajectory.dcd"
set test [file exists $name]
if { $test == 0 } {

	mol delete all
	mol new "protein/$prot\_run$run\_selweistructure.psf" waitfor all
	mol off top
	mol addfile "protein/$prot\_run$run\_seltrajectory.dcd" waitfor all

	::rmsdtt::rmsdtt
	set ::rmsdtt::bb_only 0
	set ::rmsdtt::trace_only 1
	set ::rmsdtt::noh 0
	set ::rmsdtt::weighted_sw 1
	set ::rmsdtt::weighted_mol 0
	set ::rmsdtt::weighted_field "charge"
	::rmsdtt::doAlign

	menu rmsdtt off

	set selall [atomselect top "all"]
	set nf [molinfo top get numframes]
	animate write dcd $name beg 0 end [expr $nf - 1] waitfor all sel $selall
}

exit

