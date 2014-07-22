args <- commandArgs(TRUE)
prot <- args[1]
run <- args[2]

window <- 9

require(zoo)
path <- paste("../../distances/")

set<-"S2"
res<-c(84,85,155,159,162,217,221,222,385,386,387,391,415,469,472,473,476)
for (r1 in res){
    for (r2 in res) {if (r1 < r2){
        pngfile<-paste(path,"plots/distance_",prot,"_run",run,"_",r1,"_",r2,".png",sep="")
        datfile<-paste(path,"data/distance_",prot,"_run",run,"_",r1,"_",r2,".dat",sep="")
#        if ( (!file.exists(pngfile)) && (file.exists(datfile)) ) {
        if ( file.exists(datfile) ) {
            a<-read.table(datfile)
            a<-as.vector(as.matrix(a))
            a <- rollmean(a,window)
            png(pngfile,width=1100,height=825,res=160)
            plot((1:length(a))-1,a,"l",main=paste(prot,"run",run,"distance",r1,r2,". Site:",set),xlab="Frame", ylab="Distance")
            dev.off()
        }
    }}
}

r1<-"Na1"
r2<-"Na2"
pngfile<-paste(path,"plots/distance_",prot,"_run",run,"_",r1,"_",r2,".png",sep="")
datfile<-paste(path,"data/distance_",prot,"_run",run,"_",r1,"_",r2,".dat",sep="")
#if ( (!file.exists(pngfile)) && (file.exists(datfile)) ) {
if ( file.exists(datfile) ) {
    a<-read.table(datfile)
    a<-as.vector(as.matrix(a))
    a <- rollmean(a,window)
    png(pngfile,width=1100,height=825,res=160)
    plot((1:length(a))-1,a,"l",main=paste(prot,"run",run,"distance",r1,r2),xlab="Frame", ylab="Distance")
    dev.off()
}

pngfile<-paste(path,"plots/distance_",prot,"_run",run,"_",r1,"_Na_nearest.png",sep="")
datfile<-paste(path,"data/distance_",prot,"_run",run,"_",r1,"_Na_nearest.dat",sep="")
#if ( (!file.exists(pngfile)) && (file.exists(datfile)) ) {
if ( file.exists(datfile) ) {
    a<-read.table(datfile)
    a<-as.vector(as.matrix(a))
    a <- rollmean(a,window)
    png(pngfile,width=1100,height=825,res=160)
    plot((1:length(a))-1,a,"l",main=paste(prot,"run",run,"distance",r1,"-nearest Na"),xlab="Frame", ylab="Distance")
    dev.off()
}
