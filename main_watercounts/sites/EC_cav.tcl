set sel [atomselect top "name CB and resid 326"]
set zcoord [$sel get z]
set zmin [expr $zcoord+7]
set zmax [expr $zcoord+12.7]
set waterbasicsel [atomselect top "name OH2 and z>$zmin and (not within 5 of lipid) and (within 26 of (name CB and resid 326)) and (not within 7 of (backbone and resid 456 460)) and (not within 6 of (backbone and resid 240)) and (not within 9 of (backbone and resid 562)) and (not within 14 of (backbone and resid 277)) and not ((within 10 of resname DOP) and z<$zmax)" frame $f] 
