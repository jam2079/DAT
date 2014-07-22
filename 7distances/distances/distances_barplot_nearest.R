rm(list=ls())
require(fields)
require(gplots)
prot <- "DAT"
thrshld <-0
#for (lim in c(5000,7500,10000,12500,15000,20000,25000,30000)){
for (run in 2){
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
            i <- i+1
            #print(r1)
            #lim<-275
            lim<-length(a)
            a <- a[1:lim]
            if (i==1) {all=a} else {all <- cbind(all,a)}
            lab[i] <- paste(r1,r2,sep="-")
        }}
    }
    i <- i+1
    datfile <- paste("data/distance_",prot,"_run",run,"_Na1_Na_nearest.dat",sep="")
    a <- read.table(datfile)
    a <- as.vector(as.matrix(a))
    a <- a[1:lim]
    all <- cbind(all,a)
    
    htmp <- cor(all,method="pearson")^2
    htmp[htmp==1]=NA
    nrows <- dim(htmp)[1]
    nadata <- as.vector(htmp[nrows,])
    nadata <- nadata[-nrows]
    
    #choose <- nadata>thrshld
    #y <- nadata[choose]
    pos <- seq(0,nrows*1.168,1.167^2*nrows/(nrows-1))+0.65
    
    png(paste("barplot_distances_correlation_nearest_Na1_Na_run_",run,"_frames _1_to_",lim,".png",sep=""),width=1100,height=825,res=160)
    par(mar=c(4,3,3,3),las=2)
    barplot(nadata,main=paste("R^2 between Na1-nearest Na distance and S2 residues distances \n run",run,"frames 1 to",lim),ylim=c(0,0.6),names.arg=lab,cex.names=0.5)
    dev.off()
}
#}