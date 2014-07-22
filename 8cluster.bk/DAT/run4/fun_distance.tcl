proc distanceall {ALL cut prot run} {

	set mol top

	set num_steps [molinfo $mol get numframes]

	foreach r1 $ALL {
		foreach r2 $ALL {if { $r1 < $r2 } {
			set name "../../distances/data/distance_$prot\_run$run\_$r1\_$r2.dat"
			set test [file exists $name]
			if { $test == 0 } {
				set outfile [open $name w]

				set r1t [expr $r1-$cut]
				set r2t [expr $r2-$cut]

				for {set f 0} {$f < $num_steps} {incr f} {
				        set sel_1 [atomselect top "not hydrogen and protein and resid $r1t" frame $f]
				        set sel_2 [atomselect top "not hydrogen and protein and resid $r2t" frame $f]
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
		}}
	}
}


