
rm(list=ls())

source("unpack2.R")

load("dist.Rdata")

mat <- unpack2(c3)
rm(c3)

write.table(mat, file="distmat.dat", row.names=FALSE, col.names=FALSE)
