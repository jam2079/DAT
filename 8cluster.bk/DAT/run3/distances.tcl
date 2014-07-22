
source fun_distance.tcl

set prot [lindex $argv 0]
set run [lindex $argv 1]

### CLACULATE DISTANCES

mol delete all
mol new "$prot\_run$run\_selweistructure.psf" waitfor all
mol off top
mol addfile "$prot\_run$run\_selweialitrajectory.dcd" waitfor all
set num_steps [molinfo top get numframes]

set all {3 5 27 51 56 59 60 61 66 75 76 77 78 79  85 149 152 153 155 156 159 162 217 221 222 257 260 264 269 320 321 322 323 326 328 335 345 385 386 387 391 415 418 421 422 423 425 426 428 436 437 438 439 440 441 442 443 444 469 472 473 476}
set cut 0

distanceall $all $cut $prot $run

set name "../../distances/data/distance_$prot\_run$run\_Na1_Na2.dat"
set test [file exists $name]
if { $test == 0 } {
	set outfile [open $name w]

	for {set f 0} {$f < $num_steps} {incr f} {
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

set name "../../distances/data/distance_$prot\_run$run\_Na1_Na_nearest.dat"
set test [file exists $name]
if { $test == 0 } {
	set outfile [open $name w]

	for {set f 0} {$f < $num_steps} {incr f} {
	        set sel_1 [atomselect top "serial 4867" frame $f]
	        set sel_2 [atomselect top "name SOD and (not serial 4867)" frame $f]
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

exit

