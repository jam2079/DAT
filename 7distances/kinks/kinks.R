#args <- commandArgs(TRUE)
#prot <- args[1]
#run <- args[2]
prot <- "DAT"
run <- 5

require(zoo)
path <- paste("./")
window <- 100
lim <- 90

tm <- 5
res <- 273
pngfile<-paste(path,"plots/kink_",prot,"_run",run,"_tm",tm,"_",res,".png",sep="")
datfile<-paste(path,"data/kink_",prot,"_run",run,"_bend",tm,"_",res,".txt",sep="")
if (0) {
a<-read.table(datfile)
a<-as.vector(as.matrix(a))*180/3.141592
a <- rollmean(a,window)
png(pngfile,width=1100,height=825,res=160)
plot((1:length(a))-1,a,"l",main=paste(prot," run ",run," kink angle TM",tm," on residue ",res,sep=""),xlab="Frame", ylab="Degrees",ylim=c(0,lim))
dev.off()
}

pngfile<-paste(path,"plots/kink_",prot,"_run",run,"_tm",tm,"_264_265.png",sep="")
res <- 264
datfile<-paste(path,"data/kink_",prot,"_run",run,"_bend",tm,"_",res,".txt",sep="")
a1<-read.table(datfile)
a1<-as.vector(as.matrix(a1))*180/3.141592
res <- 265
datfile<-paste(path,"data/kink_",prot,"_run",run,"_bend",tm,"_",res,".txt",sep="")
a2<-read.table(datfile)
a2<-as.vector(as.matrix(a2))*180/3.141592
a <- (a1+a2)/2
a <- rollmean(a,window)
png(pngfile,width=1100,height=825,res=160)
plot((1:length(a))-1,a,"l",main=paste(prot," run ",run," kink angle TM",tm," on residues 264 265",sep=""),xlab="Frame", ylab="Degrees",ylim=c(0,lim))
dev.off()

if (0) {
tm <-8
pngfile<-paste(path,"plots/kink_",prot,"_run",run,"_tm",tm,"_425_426.png",sep="")
res <- 425
datfile<-paste(path,"data/kink_",prot,"_run",run,"_bend",tm,"_",res,".txt",sep="")
a1<-read.table(datfile)
a1<-as.vector(as.matrix(a1))*180/3.141592
res <- 426
datfile<-paste(path,"data/kink_",prot,"_run",run,"_bend",tm,"_",res,".txt",sep="")
a2<-read.table(datfile)
a2<-as.vector(as.matrix(a2))*180/3.141592
a <- (a1+a2)/2
a <- rollmean(a,window)
png(pngfile,width=1100,height=825,res=160)
plot((1:length(a))-1,a,"l",main=paste(prot," run ",run," kink angle TM",tm," on residues 425 426",sep=""),xlab="Frame", ylab="Degrees",ylim=c(0,lim))
dev.off()
}

