set prot [lindex $argv 0]
set run [lindex $argv 1]

mol new "$prot\_run$run\_selweistructure.psf"
mol addfile "$prot\_run$run\_fixed_long.dcd" first 1 last 1 waitfor all 
set output [open "fit.index" w+]
set output2 [open "atom.vector" w+]


set sel [atomselect top "all"]
foreach i [$sel get index] {
	set j [expr $i]
	puts $output "$j"
}
$sel delete
set nres 620
for {set i 1} {$i<=$nres} {incr i} {
	puts $i
	set j [atomselect top "segname PROT and resid $i and (not hydrogen)"]
	puts $output2 "[$j num]"
	puts [$j num]
}
#set i 621
#puts $i
set j [atomselect top "segname LIG and (not hydrogen)"]
puts $output2 "[$j num]"
puts [$j num]

set i 509
puts $i
set j [atomselect top "segname INT and resid $i and (not hydrogen)"]
puts $output2 "[$j num]"
puts [$j num]

set i 510
puts $i
set j [atomselect top "segname INT and resid $i and (not hydrogen)"]
puts $output2 "[$j num]"
puts [$j num]

set i 511
puts $i
set j [atomselect top "segname INT and resid $i and (not hydrogen)"]
puts $output2 "[$j num]"
puts [$j num]

close $output
close $output2
