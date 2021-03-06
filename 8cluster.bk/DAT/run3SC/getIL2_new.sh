#!/bin/bash

prot=$1
run=$2

# This script finds the core detergent molecules in a protein micelle by selecting based on contact distance. It identifies the core size in findcore.tcl and plots in findcore.R.
/softlib/exe/x86_64/bin/vmd -dispdev text -eofexit < ./getIL2_new.tcl -args $prot $run
