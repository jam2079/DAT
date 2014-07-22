unpack <- function(d) {
	if (is.matrix(d)) {
		d
	} else {
		n <- (-1 + sqrt(1 + 8*length(d)))/2
		C <- matrix(0,n,n)

		C[lower.tri(C,diag=TRUE)] <- d
		C[upper.tri(C)] <- t(C)[upper.tri(C)]
		C
	}
}
