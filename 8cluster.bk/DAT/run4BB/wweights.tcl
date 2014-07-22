
set prot [lindex $argv 0]
set run [lindex $argv 1]
set step [lindex $argv 2]

### ALIGN USING WEIGHTING ALGORITHM

### GENERATE WEIGHTS FILE

mol new "protein/$prot\_run$run\_structure.psf" waitfor all
mol off top
mol addfile "protein/$prot\_run$run\_trajectory.dcd" type dcd first 0 last -1 step $step waitfor all
set mol top
set name "protein/$prot\_run$run\_ifitbyres_stride_$step.dat"
set test [file exists $name]
if { $test == 0 } {
	::rmsdtt::rmsdtt

	set ::rmsdtt::bb_only 0
	set ::rmsdtt::trace_only 1
	set ::rmsdtt::noh 0

	set ::rmsdtt::ifit_file $name
	::rmsdtt::iterativeFit
	sleep 3

	menu rmsdtt off
}

### CREATE NEW PSF FILE WITH WEIGHTS

set name "protein/$prot\_run$run\_weistructure.psf"
set test [file exists $name]
if { $test == 0 } {


	set fp [open "protein/$prot\_run$run\_ifitbyres_stride_$step.dat" r]
	set filedata [read $fp]
	close $fp
	set data [split $filedata "\n"]

	set selall [atomselect top "all"]
	$selall set charge 0
	set selca [atomselect top "protein and (name CA)"]

	set nres [llength [$selca get index]]
	puts $nres
	for {set i 0} {$i < $nres} {incr i} {
		set it [expr $i+2*$nres]

		set sel [atomselect top "protein and resid $i"]
		$sel set charge [ lindex [lindex $data $it] 6 ]
	}

	$selall writepsf $name
}

exit

