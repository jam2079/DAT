
set psf [lindex $argv 0]
set dcd [lindex $argv 1]
set run [lindex $argv 2]

### GET SELECTION

puts $psf
puts $dcd
puts $run

mol load psf $psf dcd $dcd
set nf [molinfo top get numframes]
set i 0
set name prot$run.pdb
[atomselect top all frame $i] writepdb $name

exit

