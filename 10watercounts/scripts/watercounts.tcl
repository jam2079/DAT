
set psf [lindex $argv 0]
set dcd [lindex $argv 1]
set name [lindex $argv 2]
set first [lindex $argv 3]
set last [lindex $argv 4]
set site [lindex $argv 5]

mol load psf $psf 
mol addfile $dcd type dcd first $first last $last waitfor all
set totframes [molinfo top get numframes]
puts "numframes $totframes"

##########################SITE Ec_cav

if { $site == "EC_cav" } {

	puts $site
	set nm "watercounts/data/watercounts_$name.dat"
	set waterbasiccounts	{}
	for {set i 0} {$i<$totframes} {incr i} {
		set sel [atomselect top "name CB and resid 326" frame $i]
		set zcoord [$sel get z]
		set zmin [expr $zcoord+7]
		set zmax [expr $zcoord+12.7]
		set waterbasicsel	[atomselect top "name OH2 and z>$zmin and (not within 5 of lipid) and (within 26 of (name CB and resid 326)) and (not within 7 of (backbone and resid 456 460)) and (not within 6 of (backbone and resid 240)) and (not within 9 of (backbone and resid 562)) and (not within 14 of (backbone and resid 277)) and not ((within 10 of resname DOP) and z<$zmax)" frame $i]
		lappend waterbasiccounts [$waterbasicsel num]
	}
	set outfile [open $nm "w"]
	puts $outfile $waterbasiccounts 
	close $outfile

}


##########################SITE EC_cha

if { $site == "EC_cha" } {

	puts $site
	set nm "watercounts/data/watercounts_$name.dat"
	set waterbasiccounts	{}
	for {set i 0} {$i<$totframes} {incr i} {
		set sel [atomselect top "name CB and resid 326"]
		set zcoord [$sel get z]
		set zmin [expr $zcoord+7]
		set zmax [expr $zcoord+12.7]
		set waterbasicsel	[atomselect top "name OH2 and z>$zmin and (not within 5 of lipid) and (within 26 of (name CB and resid 326)) and (not within 7 of (backbone and resid 456 460)) and (not within 6 of (backbone and resid 240)) and (not within 9 of (backbone and resid 562)) and (not within 14 of (backbone and resid 277)) and (within 10 of resname DOP) and z<$zmax" frame $i]
		lappend waterbasiccounts [$waterbasicsel num]
	}
	set outfile [open $nm "w"]
	puts $outfile $waterbasiccounts 
	close $outfile
}

##########################SITE IC_cav

if { $site == "IC_cav" } {

	puts $site
	set nm "watercounts/data/watercounts_$name.dat"
	set waterbasiccounts	{}
	for {set i 0} {$i<$totframes} {incr i} {
		set sel [atomselect top "name CB and resid 436"]
		set zcoord [$sel get z]
		set zmax [expr $zcoord+15.5]
		set waterbasicsel	[atomselect top "name OH2 and (not within 5 of lipid) and z<$zmax  and (within 15 of (resname DOP)) and (not within 8 of (backbone and resid 570)) and (not within 13 of (backbone and resid 492)) and (not within 5 of (backbone and resid 324)) and (not within 13 of (backbone and resid 343 347)) and (not within 7 of (backbone and resid 150)) and (not within 7 of (backbone and resid 457)) and not (within 12 of (backbone and resid 269))" frame $i]
		lappend waterbasiccounts [$waterbasicsel num]
	}
	set outfile [open $nm "w"]
	puts $outfile $waterbasiccounts 
	close $outfile
}


##########################SITE IC_cha

if { $site == "IC_cha" } {

	puts $site
	set nm "watercounts/data/watercounts_$name.dat"
	set waterbasiccounts	{}
	for {set i 0} {$i<$totframes} {incr i} {
		set sel [atomselect top "name CB and resid 436"]
		set zcoord [$sel get z]
		set zmax [expr $zcoord+15.5]
		set waterbasicsel	[atomselect top "name OH2 and (not within 5 of lipid) and z<$zmax  and (within 15 of (resname DOP)) and (not within 8 of (backbone and resid 570)) and (not within 13 of (backbone and resid 492)) and (not within 5 of (backbone and resid 324)) and (not within 13 of (backbone and resid 343 347)) and (not within 7 of (backbone and resid 150)) and (not within 7 of (backbone and resid 457)) and (within 12 of (backbone and resid 269))" frame $i]
		lappend waterbasiccounts [$waterbasicsel num]
	}
	set outfile [open $nm "w"]
	puts $outfile $waterbasiccounts 
	close $outfile
}


##########################SITE IV2

if { $site == "IV2" } {

	puts $site
	set nm "watercounts/data/watercounts_$name.dat"
	set waterbasiccounts	{}
	for {set i 0} {$i<$totframes} {incr i} {
		set sel [atomselect top "name CB and resid 436"]
		set zcoord [$sel get z]
		set zmax [expr $zcoord+15.5]
		set waterbasicsel	[atomselect top "name OH2 and (not within 5 of lipid) and z<$zmax and (within 15 of (resname DOP)) and (not within 5 of (resname DOP)) and (within 13 of (backbone and resid 343 347)) and (not within 13 of (backbone and resid 99))" frame $i]
		lappend waterbasiccounts [$waterbasicsel num]
	}
	set outfile [open $nm "w"]
	puts $outfile $waterbasiccounts 
	close $outfile
}

exit

