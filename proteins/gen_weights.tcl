cd /Volumes/aristotle/DAT/proteins
set step 15
#set in [lindex $argv 0]
set in 2

set prot "DAT_run$in"

mol delete all
mol new "$prot\_selstructure.psf" waitfor all
set mol top

set datafile [open weights_$prot.txt w]

set fp [open "$prot\_ifitbyres_stride_$step.dat" r]
set filedata [read $fp]
close $fp
set data [split $filedata "\n"]

set selall [atomselect top "all"]
$selall set charge 0
set selca [atomselect top "name CA"]

set nres [llength [$selca get index]]
puts $nres
for {set i 0} {$i < $nres} {incr i} {
	set it [expr $i+$nres]

	set sel [atomselect top "resid $i"]
	puts $datafile [ lindex [lindex $data $it] 6 ]
}

close $datafile

cd /Volumes/aristotle/DAT/proteins
set step 15
#set in [lindex $argv 0]
set in 3

set prot "DAT_run$in"

mol delete all
mol new "$prot\_selstructure.psf" waitfor all
set mol top

set datafile [open weights_$prot.txt w]

set fp [open "$prot\_ifitbyres_stride_$step.dat" r]
set filedata [read $fp]
close $fp
set data [split $filedata "\n"]

set selall [atomselect top "all"]
$selall set charge 0
set selca [atomselect top "name CA"]

set nres [llength [$selca get index]]
puts $nres
for {set i 0} {$i < $nres} {incr i} {
	set it [expr $i+$nres]

	set sel [atomselect top "resid $i"]
	puts $datafile [ lindex [lindex $data $it] 6 ]
}

close $datafile

cd /Volumes/aristotle/DAT/proteins
set step 15
#set in [lindex $argv 0]
set in 4

set prot "DAT_run$in"

mol delete all
mol new "$prot\_selstructure.psf" waitfor all
set mol top

set datafile [open weights_$prot.txt w]

set fp [open "$prot\_ifitbyres_stride_$step.dat" r]
set filedata [read $fp]
close $fp
set data [split $filedata "\n"]

set selall [atomselect top "all"]
$selall set charge 0
set selca [atomselect top "name CA"]

set nres [llength [$selca get index]]
puts $nres
for {set i 0} {$i < $nres} {incr i} {
	set it [expr $i+$nres]

	set sel [atomselect top "resid $i"]
	puts $datafile [ lindex [lindex $data $it] 6 ]
}

close $datafile

