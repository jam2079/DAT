#!/bin/bash
prot=$1
run=$2
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./measureALL_SYM_long.tcl -args $prot $run
/pbtech_mounts/hwlab_store011/mil2037/R-3.0.0/bin/R CMD BATCH ./find.all.states.2_long.R
#/pbtech_mounts/hwlab_store011/mil2037/R-3.0.0/bin/Rscript find.all.states.2.R
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./fixPHE_long.tcl -args $prot $run
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./fixGLU_long.tcl -args $prot $run
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./fixASP_long.tcl -args $prot $run
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./fixARG_long.tcl -args $prot $run
