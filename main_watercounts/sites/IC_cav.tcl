set sel [atomselect top "name CB and resid 436"]
set zcoord [$sel get z]
set zmax [expr $zcoord+15.5]
set waterbasicsel [atomselect top "name OH2 and (not within 5 of lipid) and z<$zmax  and (within 15 of (resname DOP)) and (not within 8 of (backbone and resid 570)) and (not within 13 of (backbone and resid 492)) and (not within 5 of (backbone and resid 324)) and (not within 13 of (backbone and resid 343 347)) and (not within 7 of (backbone and resid 150)) and (not within 7 of (backbone and resid 457)) and not (within 12 of (backbone and resid 269))" frame $f]

