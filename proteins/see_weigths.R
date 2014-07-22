#RUN 1

setwd("/Volumes/aristotle/DAT/proteins/")
a<-as.vector(as.matrix(read.table("weights_DAT_run1.txt")))

s11 <- 518
e11 <- 548
s12 <- 556
e12 <- 582
    
plot((1:620),a[1:620],"l",ylim=c(0,1),main="Weights alignment TM11-12 in DAT run1",xlab="Residue",ylab="Weight")
lines(s11:e11,a[s11:e11],col="red")
lines(s12:e12,a[s12:e12],col="blue")

png("weights_DAT_run1.png",width=1100,height=825,res=160)
plot((1:620),a[1:620],"l",ylim=c(0,1),main="Weights alignment TM11-12 in DAT run1",xlab="Residue",ylab="Weight")
lines(s11:e11,a[s11:e11],col="red")
lines(s12:e12,a[s12:e12],col="blue")
dev.off()

#RUN 2

setwd("/Volumes/aristotle/DAT/proteins/")
a<-as.vector(as.matrix(read.table("weights_DAT_run2.txt")))

s11 <- 518
e11 <- 551
s12 <- 555
e12 <- 582

plot((1:620),a[1:620],"l",ylim=c(0,1),main="Weights alignment TM11-12 in DAT run2",xlab="Residue",ylab="Weight")
lines(s11:e11,a[s11:e11],col="red")
lines(s12:e12,a[s12:e12],col="blue")

png("weights_DAT_run2.png",width=1100,height=825,res=160)
plot((1:620),a[1:620],"l",ylim=c(0,1),main="Weights alignment TM11-12 in DAT run2",xlab="Residue",ylab="Weight")
lines(s11:e11,a[s11:e11],col="red")
lines(s12:e12,a[s12:e12],col="blue")
dev.off()

#RUN 3

setwd("/Volumes/aristotle/DAT/proteins/")
a<-as.vector(as.matrix(read.table("weights_DAT_run3.txt")))

s11 <- 518
e11 <- 553
s12 <- 556
e12 <- 581

plot((1:620),a[1:620],"l",ylim=c(0,1),main="Weights alignment TM11-12 in DAT run3",xlab="Residue",ylab="Weight")
lines(s11:e11,a[s11:e11],col="red")
lines(s12:e12,a[s12:e12],col="blue")

png("weights_DAT_run3.png",width=1100,height=825,res=160)
plot((1:620),a[1:620],"l",ylim=c(0,1),main="Weights alignment TM11-12 in DAT run3",xlab="Residue",ylab="Weight")
lines(s11:e11,a[s11:e11],col="red")
lines(s12:e12,a[s12:e12],col="blue")
dev.off()

#RUN 4

setwd("/Volumes/aristotle/DAT/proteins/")
a<-as.vector(as.matrix(read.table("weights_DAT_run4.txt")))

s11 <- 518
e11 <- 542
s12 <- 555
e12 <- 581

plot((1:620),a[1:620],"l",ylim=c(0,1),main="Weights alignment TM11-12 in DAT run4",xlab="Residue",ylab="Weight")
lines(s11:e11,a[s11:e11],col="red")
lines(s12:e12,a[s12:e12],col="blue")

png("weights_DAT_run4.png",width=1100,height=825,res=160)
plot((1:620),a[1:620],"l",ylim=c(0,1),main="Weights alignment TM11-12 in DAT run4",xlab="Residue",ylab="Weight")
lines(s11:e11,a[s11:e11],col="red")
lines(s12:e12,a[s12:e12],col="blue")
dev.off()

