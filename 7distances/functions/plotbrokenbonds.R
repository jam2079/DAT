
rm(list=ls())

broken.bond <- function(r1,r2,run){
    a <- as.vector(as.matrix(read.table(paste("distances/data/distance_",r1,"_",r2,"_DAT_run",run,".dat",sep=""))))
    zeros <- rep(0,length(a))
    a1 <- zeros
    a1[a>4] <- 1
    a1
}

prot <- "DAT"
for (run in c(1:4,31:34)) {
runn <- run
if (as.numeric(run) < 10) {
    runn <- paste(0,run,sep="")
}
window <- 100
require(zoo)

a <- broken.bond(335,428,run)
b <- broken.bond(60,428,run)
c <- broken.bond(60,436,run)
num <- a+b+c

path <- "cluster/"
datfile<-paste(path,"data/numbrokenbonds_",prot,"_run",run,".dat",sep="")
write.table(num,file=datfile,col.names=FALSE,row.names=FALSE)

pngfile<-paste(path,"plots/numbrokenbonds_",prot,"_run",runn,".png",sep="")
if ( file.exists(datfile) ) {
    a <- rollmean(as.vector(as.matrix(read.table(datfile))),window)
    png(pngfile,width=1100,height=825,res=160)
    plot((1:length(a))-1,a,"l",main=paste(prot,"run",run,"long number of broken bonds"),xlab="Frame", ylab="Number",ylim=c(0,3))
    dev.off()
}
}
