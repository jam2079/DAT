
set prot [lindex $argv 0]
set run [lindex $argv 1]

set name "../../strs/tmp/$prot\_run$run\_str_tmp.dat"
set test [file exists $name]
if { $test == 0 } {

	mol load psf "$prot\_run$run\_selweistructure.psf" dcd "$prot\_run$run\_fixed_long.dcd"

	set nf [molinfo top get numframes]
	set outfile [open $name a]; 
	set protCA [atomselect 0 "alpha"]

	for {set j 0} {$j < $nf } { incr j } {   

	    animate goto $j  
	    display update ui  
	    mol ssrecalc 0    
	    $protCA frame $j  
	    $protCA update  
	    set sscache_data($j) [$protCA get structure]  
	    puts $outfile $sscache_data($j)  
	}   
	mol delete all   
	close $outfile   
}

exit

