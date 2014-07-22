
source functions/distance.tcl

set prot [lindex $argv 0]
set run	[lindex $argv 1]

mol load psf "protein/$prot\_run$run\_selweistructure.psf"
animate read dcd "protein/$prot\_run$run\_selweialitrajectory.dcd" waitfor all
set molID(traj) [molinfo top]
set totframes [molinfo top get numframes]
puts "numframes $totframes"



######################## DISTANCES

set S2 {84 85 155 159 162 217 221 222 385 386 387 391 415 469 472 473 476}
set shift 0
distanceall $S2 $shift $prot $run

set name "../../distances/data/distance_$prot\_run$run\_Na_Na.dat"
set test [file exists $name]
if { $test == 0 } {
	set outfile [open $name w]

	for {set f 0} {$f < $totframes} {incr f} {
	        set sel_1 [atomselect top "serial 4867" frame $f]
	        set sel_2 [atomselect top "serial 4866" frame $f]
		set md 1e6
	        foreach atom1 [$sel_1 list] {
	                foreach atom2 [$sel_2 list] {
				set m [measure bond [list $atom1 $atom2] frame $f]
				if {$m < $md} {set md $m}
	                }
	        }
		puts $outfile $md
	        $sel_1 delete
	        $sel_2 delete
	}
	close $outfile
}

set name "../../distances/data/distance_$prot\_run$run\_Na_Na_nearest.dat"
set test [file exists $name]
if { $test == 0 } {
	set outfile [open $name w]

	for {set f 0} {$f < $totframes} {incr f} {
	        set sel_1 [atomselect top "serial 4867" frame $f]
	        set sel_2 [atomselect top "name SOD and (within 25 of serial 4867) and not serial 4867" frame $f]
		set md 1e6
	        foreach atom1 [$sel_1 list] {
	                foreach atom2 [$sel_2 list] {
				set m [measure bond [list $atom1 $atom2] frame $f]
				if {$m < $md} {set md $m}
	                }
	        }
		puts $outfile $md
	        $sel_1 delete
	        $sel_2 delete
	}
	close $outfile
}

set name "../../distances/data/distance_$prot\_run$run\_Na_Na_tri.dat"
set test [file exists $name]
if { $test == 0 } {
	set outfile1 [open $name w]
	set outfile2 [open "../../distances/data/distance_$prot\_run$run\_Na_Na_tri_ang.dat" w]

	for {set f 0} {$f < $totframes} {incr f} {
		set cla [atomselect top "segname INT and name CLA" frame $f]
	        set na1 [atomselect top "serial 4867" frame $f]
	        set na2 [atomselect top "serial 4866" frame $f]
		
		set ccla [measure center $cla]
		set cna1 [measure center $na1]
		set cna2 [measure center $na2]

		set vec1 [vecsub $cna2 $ccla]
		set vec2 [vecsub $cna2 $cna1]

		set lvec1 [veclength $vec1]
		set lvec2 [veclength $vec2]
		set prod [vecdot $vec1 $vec2]

		set md [expr ($lvec1+$lvec2)/2]
		puts $outfile1 $md
		set ang [expr acos($prod/($lvec1*$lvec2))*(180/3.141592)]
		puts $outfile2 $ang
	        $cla delete
	        $na1 delete
	        $na2 delete
	}
	close $outfile1
	close $outfile2
}








exit

