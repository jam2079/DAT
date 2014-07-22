rm(list=ls())
require(fields)
require(gplots)
prot <- "DAT"
#for (lim in c(5000,7500,10000,12500,15000,20000,25000,30000)){
for (run in c(2)){
#res1<-c(84)
res2<-c(84,85,155,159,162,217,221,222,385,386,387,391,415,469,472,473,476)
res1<-res2
lab <- NULL
i <- 0
for (r1 in res1){
    for (r2 in res2) {if (r1 < r2){
        datfile <- paste("data/distance_",prot,"_run",run,"_",r1,"_",r2,".dat",sep="")
        a <- read.table(datfile)
        a <- as.vector(as.matrix(a))
        if (min(a)>4) {next}
        #lim<-10000
        lim<-length(a)
        a <- a[1:lim]
        i <- i+1
        lab[i] <- paste(r1,r2,sep="-")
        if (i==1) {all=a} else {all <- cbind(all,a)}
    }}
}
#i <- i+1
#datfile <- paste("data/distance_",prot,"_run",run,"_Na_Na.dat",sep="")
#a <- read.table(datfile)
#a <- as.vector(as.matrix(a))
#a <- a[1:lim]
#all <- cbind(all,a)
#lab[i] <- paste("Na-Na")

htmp <- cor(all,method="pearson")^2
htmp[htmp==1]=NA
nrows <- dim(htmp)[1]
#rownames(htmp) <- rep("la",16)
pos <- seq(0,1,1/(nrows-1))

par(mar=c(3,3,4.5,7))
image(htmp,axes=FALSE,col=tim.colors(64),zlim=c(0,1),main=paste("R^2 between pairs of distances run",run,"frames 1 to",lim,"\n   "))
mtext(text=lab, side=2, line=0.3, at=pos, las=1, cex=0.5)
mtext(text=lab, side=1, line=0.3, at=pos, las=2, cex=0.5)
mtext(text=lab, side=4, line=0.3, at=pos, las=1, cex=0.5)
mtext(text=lab, side=3, line=0.3, at=pos, las=2, cex=0.5)
image.plot(htmp,col=tim.colors(64),legend.only=TRUE,zlim=c(0,1))

png(paste("distances_correlation_run_",run,"_frames _1_to_",lim,".png",sep=""),width=1100,height=825,res=160)
par(mar=c(3,3,4.5,7))
image(htmp,axes=FALSE,col=tim.colors(64),zlim=c(0,1),main=paste("R^2 between pairs of distances run",run,"frames 1 to",lim,"\n   "))
mtext(text=lab, side=2, line=0.3, at=pos, las=1, cex=0.5)
mtext(text=lab, side=1, line=0.3, at=pos, las=2, cex=0.5)
mtext(text=lab, side=4, line=0.3, at=pos, las=1, cex=0.5)
mtext(text=lab, side=3, line=0.3, at=pos, las=2, cex=0.5)
image.plot(htmp,col=tim.colors(64),legend.only=TRUE,zlim=c(0,1))
dev.off()

}
#}