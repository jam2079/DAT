args <- commandArgs(TRUE)
prot <- "DAT"
run <- args[1]
#micro <- args[4]
window <- as.numeric(args[2])

require(zoo)
mar=c(5,5,2,5)

path <- paste("./")
pngfile<-paste(path,"/plots/watercounts_EC_DAT_run",run,".png",sep="")
datfile<-paste(path,"/data/watercounts_EC_cav_DAT_run",run,".dat",sep="")
if ( file.exists(datfile) ) {
a <- read.table(datfile)
a <- as.vector(as.matrix(a))
a <- rollmean(a,window)
png(pngfile,width=1100,height=825,res=160)
par(mar=mar)
plot((1:length(a))-1,a,"l",ylim=c(0,100),xlab="Frame",ylab="EC cavity",main=paste("Water count EC DAT run",run,"smooth",window))
#plot((1:length(a))-1,a,"l",ylim=c(0,100),xlab="",ylab="")


par(new=TRUE)
datfile<-paste(path,"/data/watercounts_EC_cha_DAT_run",run,".dat",sep="")
a <- read.table(datfile)
a <- as.vector(as.matrix(a))
a <- rollmean(a,window)
#plot((1:length(a))-1,a,"l",ylim=c(0,20),xlab="Frame",ylab="EC cavity",main=paste("Water countDATrun",run,"smooth",window),col="blue")
plot((1:length(a))-1,a,"l",ylim=c(0,20),xlab="",ylab="",xaxt="n",yaxt="n",col="blue")
axis(4)
mtext("EC channel",side=4,,line=3,las=3)

dev.off()
}


mar=c(5,5,2,3)

pngfile<-paste(path,"/plots/watercounts_IC_DAT_run",run,".png",sep="")
datfile<-paste(path,"/data/watercounts_IC_cav_DAT_run",run,".dat",sep="")
if ( file.exists(datfile) ) {
a <- read.table(datfile)
a <- as.vector(as.matrix(a))
a <- rollmean(a,window)
png(pngfile,width=1100,height=825,res=160)
par(mar=mar)
plot((1:length(a))-1,a,"l",ylim=c(0,60),xlab="Frame",ylab="IC cavity and channel",main=paste("Water count IC DAT run",run,"smooth",window))
#plot((1:length(a))-1,a,"l",ylim=c(0,100),xlab="",ylab="")

par(new=TRUE)
datfile<-paste(path,"/data/watercounts_IC_cha_DAT_run",run,".dat",sep="")
a <- read.table(datfile)
a <- as.vector(as.matrix(a))
a <- rollmean(a,window)
#plot((1:length(a))-1,a,"l",ylim=c(0,20),xlab="Frame",ylab="EC cavity",main=paste("Water countDATrun",run,"smooth",window),col="blue")
#plot((1:length(a))-1,a,"l",ylim=c(0,60),xlab="",ylab="",xaxt="n",yaxt="n",col="blue")
lines((1:length(a))-1,a,col="blue")
#axis(4)
#mtext("IC channel",side=4,line=3)

dev.off()

}


pngfile<-paste(path,"/plots/watercounts_IV2_DAT_run",run,".png",sep="")
datfile<-paste(path,"/data/watercounts_IV2_DAT_run",run,".dat",sep="")
if ( file.exists(datfile) ) {
a <- read.table(datfile)
a <- as.vector(as.matrix(a))
a <- rollmean(a,window)
png(pngfile,width=1100,height=825,res=160)
par(mar=mar)
plot((1:length(a))-1,a,"l",ylim=c(0,15),xlab="Frame",ylab="IV2",main=paste("Water count IV2 DAT run",run,"smooth",window))
dev.off()
}

