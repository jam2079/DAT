
rm(list=ls())

load("cluster.Rdata")

n <- dim(mydata)[1]
sub <- mydata[seq(10,n,10),]
rm(mydata)

c3 <- as.vector(dist(sub))

save(c3,file="dist.Rdata")
