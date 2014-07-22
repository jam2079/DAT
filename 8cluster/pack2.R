pack2 <- function(C) {
	if (is.vector(C)) {
		C
	} else {
		d <- unlist(C[lower.tri(C)])
		d
	}
}
