proc moveda {n x y z} {

	set sel [atomselect $n "resname DOP"]

	set axis x
	set increment $x

	 set coord [$sel get $axis]
	  for {set i 0} {$i < [llength $coord]} {incr i} {
	    set old [lindex $coord $i]
	    set new [expr $old + $increment]
	    lset coord $i $new
	  }
	$sel set $axis $coord

	set axis y
	set increment $y

	 set coord [$sel get $axis]
	  for {set i 0} {$i < [llength $coord]} {incr i} {
	    set old [lindex $coord $i]
	    set new [expr $old + $increment]
	    lset coord $i $new
	  }
	$sel set $axis $coord

	set axis z
	set increment $z

	 set coord [$sel get $axis]
	  for {set i 0} {$i < [llength $coord]} {incr i} {
	    set old [lindex $coord $i]
	    set new [expr $old + $increment]
	    lset coord $i $new
	  }
	$sel set $axis $coord

}

proc rotda {n a1 a2 ang} {

	set dop [atomselect $n "all"]
	set at1 [atomselect $n "name $a1"]
	set at2 [atomselect $n "name $a2"]
	set at1coord [lindex [$at1 get {x y z}] 0]
	set at2coord [lindex [$at2 get {x y z}] 0]
	
	$dop move [trans bond $at1coord $at2coord $ang deg]

}
