
set psf [lindex $argv 0]
set dcd [lindex $argv 1]
set sitenamepart [lindex $argv 2]
set first [lindex $argv 3]
set last [lindex $argv 4]
set site [lindex $argv 5]

mol load psf $psf 
mol addfile $dcd type dcd first $first last $last waitfor all
set totframes [molinfo top get numframes]
puts "numframes $totframes"

##########################SITE Ec_cav

puts $site
set nm "watercounts/data/watercounts_$sitenamepart.dat"
set waterbasiccounts	{}
for {set f 0} {$f<$totframes} {incr f} {
	source sites/$site.tcl
	set waterbasicsel [$waterbasicsel frame $f]
	lappend waterbasiccounts [$waterbasicsel num]
}
set outfile [open $nm "w"]
puts $outfile $waterbasiccounts 
close $outfile

exit

