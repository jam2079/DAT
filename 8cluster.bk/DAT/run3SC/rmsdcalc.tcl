
source rmsd.tcl

set prot [lindex $argv 0]
set run [lindex $argv 1]

if { $run == "1" } {
	set tms "name CA and (resid 66 to 77 80 to 93 95 to 123 136 to 172 238 to 257 260 to 284 308 to 322 328 to 335 342 to 374 403 to 438 443 to 467 482 to 498 518 to 548 556 to 582)"
	set tm1a "name CA and resid 66 to 77" 
	set tm1b "name CA and resid 80 to 93"
	set tm2 "name CA and resid 95 to 123"
	set tm3 "name CA and resid 136 to 172"
	set tm4 "name CA and resid 238 to 257"
	set tm5 "name CA and resid 260 to 284"
	set tm6a "name CA and resid 308 to 322"
	set tm6b "name CA and resid 328 to 335"
	set tm7 "name CA and resid 342 to 374"
	set tm8 "name CA and resid 403 to 438"
	set tm9 "name CA and resid 443 to 467"
	set tm10 "name CA and resid 482 to 498"
	set tm11 "name CA and resid 518 to 548"
	set tm12 "name CA and resid 556 to 582"
}

if { $run == "2" } {
	set tms "name CA and (resid 66 to 77 80 to 93 95 to 121 136 to 172 238 to 257 259 to 285 308 to 322 328 to 335 342 to 372 403 to 438 443 to 468 482 to 498 518 to 551 555 to 582)"
	set tm1a "name CA and resid 66 to 77" 
	set tm1b "name CA and resid 80 to 93"
	set tm2 "name CA and resid 95 to 121"
	set tm3 "name CA and resid 136 to 172"
	set tm4 "name CA and resid 238 to 257"
	set tm5 "name CA and resid 259 to 285"
	set tm6a "name CA and resid 308 to 322"
	set tm6b "name CA and resid 328 to 335"
	set tm7 "name CA and resid 342 to 372"
	set tm8 "name CA and resid 403 to 438"
	set tm9 "name CA and resid 443 to 468"
	set tm10 "name CA and resid 482 to 498"
	set tm11 "name CA and resid 518 to 551"
	set tm12 "name CA and resid 555 to 582"
}

if { $run == "3" } {
	set tms "name CA and (resid 66 to 77 80 to 93 95 to 121 136 to 172 238 to 257 259 to 284 308 to 322 328 to 335 343 to 373 403 to 438 444 to 468 482 to 498 518 to 553 556 to 581)"
	set tm1a "name CA and resid 66 to 77" 
	set tm1b "name CA and resid 80 to 93"
	set tm2 "name CA and resid 95 to 121"
	set tm3 "name CA and resid 136 to 172"
	set tm4 "name CA and resid 238 to 257"
	set tm5 "name CA and resid 259 to 284"
	set tm6a "name CA and resid 308 to 322"
	set tm6b "name CA and resid 328 to 335"
	set tm7 "name CA and resid 343 to 373"
	set tm8 "name CA and resid 403 to 438"
	set tm9 "name CA and resid 444 to 468"
	set tm10 "name CA and resid 482 to 498"
	set tm11 "name CA and resid 518 to 553"
	set tm12 "name CA and resid 556 to 581"
}

if { $run == "4" } {
	set tms "name CA and (resid 66 to 77 80 to 93 95 to 123 136 to 172 238 to 257 259 to 285 308 to 322 328 to 335 342 to 370 403 to 438 444 to 468 482 to 497 518 to 542 555 to 581)"
	set tm1a "name CA and resid 66 to 77" 
	set tm1b "name CA and resid 80 to 93"
	set tm2 "name CA and resid 95 to 123"
	set tm3 "name CA and resid 136 to 172"
	set tm4 "name CA and resid 238 to 257"
	set tm5 "name CA and resid 259 to 285"
	set tm6a "name CA and resid 308 to 322"
	set tm6b "name CA and resid 328 to 335"
	set tm7 "name CA and resid 342 to 370"
	set tm8 "name CA and resid 403 to 438"
	set tm9 "name CA and resid 444 to 468"
	set tm10 "name CA and resid 482 to 497"
	set tm11 "name CA and resid 518 to 542"
	set tm12 "name CA and resid 555 to 581"
}

mol new "$prot\_run$run\_selweistructure.psf" waitfor all
mol off top
mol addfile "$prot\_run$run\_selweialitrajectory.dcd" waitfor all
set mol top

rmsd [atomselect top $tms frame 0] $prot $run

rmsdtm 1a [atomselect top $tm1a frame 0] $prot $run
rmsdtm 1b [atomselect top $tm1b frame 0] $prot $run
rmsdtm 2 [atomselect top $tm2 frame 0] $prot $run
rmsdtm 3 [atomselect top $tm3 frame 0] $prot $run
rmsdtm 4 [atomselect top $tm4 frame 0] $prot $run
rmsdtm 5 [atomselect top $tm5 frame 0] $prot $run
rmsdtm 6a [atomselect top $tm6a frame 0] $prot $run
rmsdtm 6b [atomselect top $tm6b frame 0] $prot $run
rmsdtm 7 [atomselect top $tm7 frame 0] $prot $run
rmsdtm 8 [atomselect top $tm8 frame 0] $prot $run
rmsdtm 9 [atomselect top $tm9 frame 0] $prot $run
rmsdtm 10 [atomselect top $tm10 frame 0] $prot $run
rmsdtm 11 [atomselect top $tm11 frame 0] $prot $run
rmsdtm 12 [atomselect top $tm12 frame 0] $prot $run



