
set psf [lindex $argv 0]
set dcd [lindex $argv 1]
set name [lindex $argv 2]
set first [lindex $argv 3]
set last [lindex $argv 4]
set site [lindex $argv 5]

### CALCULATE DISTANCES

mol new $psf waitfor all
mol off top
mol addfile $dcd type dcd first $first last $last waitfor all
set num_steps [molinfo top get numframes]

if {0} {

set test [file exists $path]
if { $test == 0 } {
	set outfile [open $path w]
	set sel1 [atomselect top "name CA and resid 66 67 68"]
	set sel2 [atomselect top "name CA and resid 333 334 335"]

	for {set f 0} {$f < $num_steps} {incr f} {
	        $sel1 frame $f
	        $sel2 frame $f
		
		set com1 [measure center $sel1 weight mass] 
		set com2 [measure center $sel2 weight mass] 
		set dist [veclength [vecsub $com1 $com2]]
		puts $outfile $dist
	        #$sel1 delete
	        #$sel2 delete
	}
	close $outfile
}

set path "cluster/data/bulkions_$name.dat"
set test [file exists $path]
if { $test == 0 } {
	set outfile [open $path w]

	for {set f 0} {$f < $num_steps} {incr f} {
		set sel_1 [atomselect top "name SOD POT and not serial 4866 4867" frame $f]
		set sel_2 [atomselect top "protein and resid 428" frame $f]
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

set path "cluster/data/$name.dat"
set test [file exists $path]
if { $test == 0 } {
	set data	{}
	for {set f 0} {$f < $num_steps} {incr f} {
	        set sel_1 [atomselect top "name CA and resid 442 443 444" frame $f]
	        set sel_2 [atomselect top "name CA and resid 3 5 27 51" frame $f]
		set md 10
		set count 0
	        foreach atom1 [$sel_1 list] {
	                foreach atom2 [$sel_2 list] {
				set m [measure bond [list $atom1 $atom2] frame $f]
				if {$m < $md} {set count [expr $count + 1]}
	                }
	        }
		lappend data $count
	}
	set outfile [open $path w]
	puts $outfile $data
	close $outfile
}

if {0} {
set path "cluster/data/cadistance_$name\_84_387.dat"
set test [file exists $path]
if { $test == 0 } {
        set outfile [open $path w]
        set sel1 [atomselect top "name CA and resid 84"]
        set sel2 [atomselect top "name CA and resid 387"]

        for {set f 0} {$f < $num_steps} {incr f} {
                $sel1 frame $f
                $sel2 frame $f

                set com1 [measure center $sel1 weight mass]
                set com2 [measure center $sel2 weight mass]
                set dist [veclength [vecsub $com1 $com2]]
                puts $outfile $dist
                #$sel1 delete
                #$sel2 delete
        }
        close $outfile
}

set path "cluster/data/cadistance_$name\_84_391.dat"
set test [file exists $path]
if { $test == 0 } {
        set outfile [open $path w]
        set sel1 [atomselect top "name CA and resid 84"]
        set sel2 [atomselect top "name CA and resid 391"]

        for {set f 0} {$f < $num_steps} {incr f} {
                $sel1 frame $f
                $sel2 frame $f

                set com1 [measure center $sel1 weight mass]
                set com2 [measure center $sel2 weight mass]
                set dist [veclength [vecsub $com1 $com2]]
                puts $outfile $dist
                #$sel1 delete
                #$sel2 delete
        }
        close $outfile
}

set path "cluster/data/cadistance_$name\_84_394.dat"
set test [file exists $path]
if { $test == 0 } {
        set outfile [open $path w]
        set sel1 [atomselect top "name CA and resid 84"]
        set sel2 [atomselect top "name CA and resid 394"]

        for {set f 0} {$f < $num_steps} {incr f} {
                $sel1 frame $f
                $sel2 frame $f

                set com1 [measure center $sel1 weight mass]
                set com2 [measure center $sel2 weight mass]
                set dist [veclength [vecsub $com1 $com2]]
                puts $outfile $dist
                #$sel1 delete
                #$sel2 delete
        }
        close $outfile
}
}

######################## SITE pip2icl4distance

if { $site == "pip2icl4distance" } {

	set all "$name"
	set path "cluster/data/$all.dat"
	set data	{}
	puts  $all
	for {set f 0} {$f < $num_steps} {incr f} {
	        set sel_1 [atomselect top "protein and resid 442 443 444" frame $f]
	        set sel_2 [atomselect top "segname PIP2" frame $f]
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


exit

