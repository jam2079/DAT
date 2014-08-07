
#source functions/distance.tcl

set title [lindex $argv 0]
set site [lindex $argv 1]
set name [lindex $argv 2]
set part [lindex $argv 3]
set psf [lindex $argv 4]
set dcd [lindex $argv 5]
set first [lindex $argv 6]
set last [lindex $argv 7]

mol delete all
mol new $psf waitfor all
mol off top
mol addfile $dcd first $first last $last waitfor all
set num_steps [molinfo top get numframes]

if {0} {

#set all {84 85 155 159 162 217 221 222 385 386 387 391 415 469 472 473 476}
set all {51 60 436 445}
set cut 0

distanceall $all $cut $name

exit

set Na1 9715
set Na2 9714

if { $name == "DAT_run18"} {
	set Na1 9199
	set Na2 9198
}

set path "distances/data/distance_$name\_Na1_Na2.dat"
set test [file exists $path]
if { $test == 0 } {
	set outfile [open $path w]

	for {set f 0} {$f < $num_steps} {incr f} {
	        set sel_1 [atomselect top "index $Na1" frame $f]
	        set sel_2 [atomselect top "index $Na2" frame $f]
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

set path "distances/data/distance_$name\_Na1_Na_nearest.dat"
set test [file exists $path]
if { $test == 0 } {
	set outfile [open $path w]

	for {set f 0} {$f < $num_steps} {incr f} {
	        set sel_1 [atomselect top "index $Na1" frame $f]
	        set sel_2 [atomselect top "name SOD and (not index $Na1)" frame $f]
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
}


####################### FUNCTIONS

proc distresidues { r1 r2 path num_steps } {
	puts $path
	set data	{}
	for {set f 0} {$f < $num_steps} {incr f} {
	        set sel_1 [atomselect top "protein and noh and resid $r1" frame $f]
	        set sel_2 [atomselect top "protein and noh and resid $r2" frame $f]
		set md 1e6
	        foreach atom1 [$sel_1 list] {
	                foreach atom2 [$sel_2 list] {
				set m [measure bond [list $atom1 $atom2] frame $f]
				if {$m < $md} {set md $m}
	                }
	        }
	        lappend data $md
	}
	set outfile [open $path w]
	puts $outfile $data
	close $outfile
}

####################### SITE 51_436

set r1 51
set r2 436
if { $site == "$r1\_$r2" } {
	set path "distances/data/$title\_$site\_$name\_part$part.dat"
	distresidues $r1 $r2 $path $num_steps
}

####################### SITE 60_436

set r1 60
set r2 436
if { $site == "$r1\_$r2" } {
	set path "distances/data/$title\_$site\_$name\_part$part.dat"
	distresidues $r1 $r2 $path $num_steps
}

####################### SITE 335_428

set r1 335
set r2 428
if { $site == "$r1\_$r2" } {
	set path "distances/data/$title\_$site\_$name\_part$part.dat"
	distresidues $r1 $r2 $path $num_steps
}

####################### SITE 60_428

set r1 60
set r2 428
if { $site == "$r1\_$r2" } {
	set path "distances/data/$title\_$site\_$name\_part$part.dat"
	distresidues $r1 $r2 $path $num_steps
}

####################### SITE 436_445

set r1 436
set r2 445
if { $site == "$r1\_$r2" } {
	set path "distances/data/$title\_$site\_$name\_part$part.dat"
	distresidues $r1 $r2 $path $num_steps
}



exit

