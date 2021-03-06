
rm(list=ls())
mode <- 3     #0 to see all residues, 1 to see all TMs, 2 to see only the TMs defined in aaa and bbb, 3 to see selected residues in ccc
save <- 1     #1 to save output
aaa <- c(420:450)      #TM1, in the left and right in mode 2
bbb <- c(4)      #TM2, in the top and bottom in mode 2
#aaa <- c(201:300)     #residues to see in the left and right in mode 3
#bbb <- c(201:310)     #residues to see in the top and bottom in mode 3
same <- 1
name <- "TM8-IL4"          #name of the set of the residues in ccc

aaa0 <- aaa
bbb0 <- bbb

#for (run in c("1","1CA","1BB","1SC","2","2CA","2BB","2SC","3","3CA","3BB","3SC","4","4CA","4BB","4SC")) {
for (run in c("1")) {
prot <- paste("run",run,sep="")
for (num in 1) {
for (sz in 1) {
require(fields)
require(gplots)
aaa <- aaa0
bbb <- bbb0

if (same==1) {bbb <- aaa}
datfile <-paste("data/DAT_",prot,"_",num,"_evol_fixed_long.dcd_sweep_window_",sz,"_lig.dat",sep="")
if (mode==2){
ttl1 <- NULL
for (i in aaa){
ttl1 <- paste(ttl1,i)
}
ttl2 <- NULL
for (i in bbb){
ttl2 <- paste(ttl2,i)
}
aaa <- c(aaa,13)
bbb <- c(bbb,13)
}
if (mode==0){pngfile <-paste("plots/sweep_all_DAT",prot,"num",num,"_window",sz,".png",sep="_")}
if (mode==1){pngfile <-paste("plots/sweep_DAT",prot,"num",num,"_window",sz,".png",sep="_")}
if (mode==2){pngfile <-paste("plots/sweep_tms_DAT",ttl1,ttl2,prot,"num",num,"_window",sz,".png",sep="_")}
if (mode==3){pngfile <-paste("plots/sweep_sel_DAT",name,prot,"num",num,"_window",sz,".png",sep="_")}

rescodes<-c("M","S","K","S","K","C","S","V","G","L","M","S","S","V","V","A","P","A","K","E","P","N","A","V","G","P","K","E","V","E","L","I","L","V","K","E","Q","N","G","V","Q","L","T","S","S","T","L","T","N","P","R","Q","S","P","V","E","A","Q","D","R","E","T","W","G","K","K","I","D","F","L","L","S","V","I","G","F","A","V","D","L","A","N","V","W","R","F","P","Y","L","C","Y","K","N","G","G","G","A","F","L","V","P","Y","L","L","F","M","V","I","A","G","M","P","L","F","Y","M","E","L","A","L","G","Q","F","N","R","E","G","A","A","G","V","W","K","I","C","P","I","L","K","G","V","G","F","T","V","I","L","I","S","L","Y","V","G","F","F","Y","N","V","I","I","A","W","A","L","H","Y","L","F","S","S","F","T","T","E","L","P","W","I","H","C","N","N","S","W","N","S","P","N","C","S","D","A","H","P","G","D","S","S","G","D","S","S","G","L","N","D","T","F","G","T","T","P","A","A","E","Y","F","E","R","G","V","L","H","L","H","Q","S","H","G","I","D","D","L","G","P","P","R","W","Q","L","T","A","C","L","V","L","V","I","V","L","L","Y","F","S","L","W","K","G","V","K","T","S","G","K","V","V","W","I","T","A","T","M","P","Y","V","V","L","T","A","L","L","L","R","G","V","T","L","P","G","A","I","D","G","I","R","A","Y","L","S","V","D","F","Y","R","L","C","E","A","S","V","W","I","D","A","A","T","Q","V","C","F","S","L","G","V","G","F","G","V","L","I","A","F","S","S","Y","N","K","F","T","N","N","C","Y","R","D","A","I","V","T","T","S","I","N","S","L","T","S","F","S","S","G","F","V","V","F","S","F","L","G","Y","M","A","Q","K","H","S","V","P","I","G","D","V","A","K","D","G","P","G","L","I","F","I","I","Y","P","E","A","I","A","T","L","P","L","S","S","A","W","A","V","V","F","F","I","M","L","L","T","L","G","I","D","S","A","M","G","G","M","E","S","V","I","T","G","L","I","D","E","F","Q","L","L","H","R","H","R","E","L","F","T","L","F","I","V","L","A","T","F","L","L","S","L","F","C","V","T","N","G","G","I","Y","V","F","T","L","L","D","H","F","A","A","G","T","S","I","L","F","G","V","L","I","E","A","I","G","V","A","W","F","Y","G","V","G","Q","F","S","D","D","I","Q","Q","M","T","G","Q","R","P","S","L","Y","W","R","L","C","W","K","L","V","S","P","C","F","L","L","F","V","V","V","V","S","I","V","T","F","R","P","P","H","Y","G","A","Y","I","F","P","D","W","A","N","A","L","G","W","V","I","A","T","S","S","M","A","M","V","P","I","Y","A","A","Y","K","F","C","S","L","P","G","S","F","R","E","K","L","A","Y","A","I","A","P","E","K","D","R","E","L","V","D","R","G","E","V","R","Q","F","T","L","R","H","W","L","K","V","LIG","Na2","Na1","Cl")
gly <- which(rescodes=="G")

if (!file.exists(datfile)) {next}
if (file.exists(pngfile)) {next}
print(prot)
print(num)

nresp <- 620
nres <- 624
if ((prot == "run1") || (prot == "run1BB") || (prot == "run1SC") ||(run=="run1CA")) {
TM1<-c(66:93)
TM2<- c(95:123)
TM3<- c(136:172)
TM4<- c(238:257)
TM5<- c(260:284)
TM6<-c(308:335)
TM7<- c(342:374)
TM8<- c(403:438)
TM9<- c(443:467)
TM10<-c(482:498)
TM11<-c(518:548)
TM12<-c(556:582)
pos <- c(0.04,0.12,0.22,0.30,0.37,0.45,0.54,0.63,0.72,0.78,0.86,0.95,0.995)
}
if ((prot == "run2") || (prot == "run2BB") || (prot == "run2SC") ||(run=="run2CA")) {
TM1<-c(66:93)
TM2<- c(95:121)
TM3<- c(136:172)
TM4<- c(238:257)
TM5<- c(259:285)
TM6<-c(308:335)
TM7<- c(342:370)
TM8<- c(403:438)
TM9<- c(443:468)
TM10<-c(482:498)
TM11<-c(518:551)
TM12<-c(555:582)
pos <- c(0.04,0.12,0.22,0.30,0.37,0.45,0.54,0.63,0.72,0.78,0.86,0.95,0.995)
}
if ((prot == "run3") || (prot == "run3BB") || (prot == "run3SC") ||(run=="run3CA")) {
TM1<-c(66:93)
TM2<- c(95:121)
TM3<- c(136:172)
TM4<- c(238:257)
TM5<- c(259:284)
TM6<-c(308:335)
TM7<- c(343:373)
TM8<- c(403:438)
TM9<- c(444:468)
TM10<-c(482:498)
TM11<-c(518:553)
TM12<-c(556:581)
pos <- c(0.04,0.12,0.22,0.30,0.37,0.45,0.54,0.63,0.72,0.78,0.86,0.95,0.995)
}
if ((prot == "run4") || (prot == "run4BB") || (prot == "run4SC") ||(run=="run4CA")) {
TM1<-c(66:93)
TM2<- c(95:123)
TM3<- c(136:172)
TM4<- c(238:257)
TM5<- c(259:285)
TM6<-c(308:335)
TM7<- c(342:370)
TM8<- c(403:438)
TM9<- c(444:468)
TM10<-c(482:497)
TM11<-c(518:542)
TM12<-c(555:581)
pos <- c(0.04,0.12,0.22,0.31,0.38,0.46,0.55,0.64,0.74,0.80,0.87,0.95,0.995)
}
lig <- c(621:624)
TM <- list(TM1,TM2,TM3,TM4,TM5,TM6,TM7,TM8,TM9,TM10,TM11,TM12,lig)

a <- read.table(datfile)
a <- as.matrix(a[(1:nres),(1:nres)])

if ((prot == "run1SC") || (prot == "run2SC") || (prot == "run3SC") || (prot == "run4SC")) {
a <- a[(1:(dim(a)[1]-length(gly))),(1:(dim(a)[1]-length(gly)))]
ncol <-dim(a)[2]
for (i in 1:length(gly)) {
b <- gly[i]
nrow <- dim(a)[1]
if (gly[i] != nres) {a <- rbind(a[(1:(b-1)),],rep(0,ncol),a[(b:nrow),])}
if (gly[i] == nres) {a <- rbind(a[(1:(b-1)),],rep(0,ncol))}
}
nrow <-dim(a)[1]
for (i in 1:length(gly)) {
b <- gly[i]
ncol <- dim(a)[2]
if (gly[i] != nres) {a <- cbind(a[,(1:(b-1))],rep(0,nrow),a[,(b:ncol)])}
if (gly[i] == nres) {a <- cbind(a[,(1:(b-1))],rep(0,nrow))}
}
}
a0 <- a

if (mode==0) {
sel1 <- 1:dim(a)[1]
sel2 <- sel1
}
if (mode==1) {
sel1 <- unlist(TM)
sel2 <- sel1
}
if (mode==2) {
sel1 <- unlist(TM[aaa])
sel2 <- unlist(TM[bbb])
}
if (mode==3) {
aaa <- c(aaa,unlist(TM[[13]]))
bbb <- c(bbb,unlist(TM[[13]]))
sel1 <- aaa
sel2 <- bbb
}

if ((prot == "run1SC") || (prot == "run2SC") || (prot == "run3SC") || (prot == "run4SC")) {
sel1 <- sel1[!(sel1 %in% gly)]
sel2 <- sel2[!(sel2 %in% gly)]
}

a <- a[sel1,sel2]
a[a==1]=NA

if (mode==1){
ncol <-dim(a)[2]
count <- 0
for (i in 1:(length(TM)-1)) {
b <- which(sel1==max(TM[[i]]))
if (length(b) < 1) {next}
nrow <- dim(a)[1]
count <- count+1
a <- rbind(a[(1:(b+count-1)),],rep(NA,ncol),a[((b+count):nrow),])
}
nrow <-dim(a)[1]
count <- 0
for (i in 1:(length(TM)-1)) {
b <- which(sel2==max(TM[[i]]))
if (length(b) < 1) {next}
ncol <- dim(a)[2]
count <- count+1
a <- cbind(a[,(1:(b+count-1))],rep(NA,nrow),a[,((b+count):ncol)])
}
}
if (mode==2){
ncol <-dim(a)[2]
count <- 0
for (i in 1:(length(aaa)-1)) {
if (length(aaa)<2) {next}
b <- which(sel1==max(TM[[aaa[i]]]))
if (length(b) < 1) {next}
nrow <- dim(a)[1]
count <- count+1
a <- rbind(a[(1:(b+count-1)),],rep(NA,ncol),a[((b+count):nrow),])
}
nrow <-dim(a)[1]
count <- 0
for (i in 1:(length(bbb)-1)) {
if (length(bbb)<2) {next}
b <- which(sel2==max(TM[[bbb[i]]]))
if (length(b) < 1) {next}
ncol <- dim(a)[2]
count <- count+1
a <- cbind(a[,(1:(b+count-1))],rep(NA,nrow),a[,((b+count):ncol)])
}
}

a <- t(a)
nrows <- dim(a)[1]
ncols <- dim(a)[2]
pos1 <- seq(0,1,1/(nrows-1))
ncols <- dim(a)[2]
pos2 <- seq(0,1,1/(ncols-1))
num <- as.numeric(num)
beg <- 50*(num-1)
end <- 50*(num-1)+500

#if (save==1) {png(pngfile,width=1100,height=825,res=160)}
#if (save==0) {
par(mar=c(3,3,4,7))
if (mode==0) {image(a,axes=FALSE,col=tim.colors(64),zlim=c(0,1),main=paste("DAT",prot,"all pairwise interactions",beg,"-",end,"ns \n  "))}
if (mode==1) {image(a,axes=FALSE,col=tim.colors(64),zlim=c(0,1),main=paste("DAT",prot,"pairwise interactions",beg,"-",end,"ns \n  "))}
if (mode==2) {image(a,axes=FALSE,col=tim.colors(64),zlim=c(0,1),main=paste("DAT",prot,"pairwise interactions TM",ttl1,"TM",ttl2,beg,"-",end,"ns \n  "))}
if (mode==3) {image(a,axes=FALSE,col=tim.colors(64),zlim=c(0,1),main=paste("DAT",prot,"pairwise interactions",name,"time",beg,"-",end,"ns \n  "))}
lab <- c("1","2","3","4","5","6","7","8","9","10","11","12","LIG")
if (mode==1){
mtext(text=lab, side=2, line=0.3, at=pos, las=1, cex=0.9)
mtext(text=lab, side=1, line=0.3, at=pos, las=1, cex=0.9)
}
if (mode==2){
labaaa <- unlist(TM[aaa])
labbbb <- unlist(TM[bbb])
if ((prot == "run1SC") || (prot == "run2SC") || (prot == "run3SC") || (prot == "run4SC")) {
labaaa <- labaaa[! labaaa %in% gly]
labbbb <- labbbb[! labbbb %in% gly]
}
laba <- paste(rescodes[labaaa],labaaa,sep="")
labb <- paste(rescodes[labbbb],labbbb,sep="")
laba[which(laba=="LIG621")]="LIG"
laba[which(laba=="Na2622")]="Na2"
laba[which(laba=="Na1623")]="Na1"
laba[which(laba=="Cl624")]="Cl"
labb[which(labb=="LIG621")]="LIG"
labb[which(labb=="Na2622")]="Na2"
labb[which(labb=="Na1623")]="Na1"
labb[which(labb=="Cl624")]="Cl"
for (i in 1:length(TM)) {
TM[[i]] <- TM[[i]][! TM[[i]] %in% gly]
}
for (i in aaa[-1]) {
if (length(aaa)<2) {next}
tmp <- pos2[-which(labaaa==TM[[i]][1])]
if (length(tmp)<1) {next}
pos2 <- tmp
}
for (i in bbb[-1]) {
if (length(bbb)<2) {next}
tmp <- pos1[-which(labbbb==TM[[i]][1])]
if (length(tmp)<1) {next}
pos1 <- tmp
}
mtext(text=labb, side=1, line=0.3, at=pos1, las=2, cex=0.8)
mtext(text=laba, side=2, line=0.3, at=pos2, las=1, cex=0.8)
mtext(text=labb, side=3, line=0.3, at=pos1, las=2, cex=0.8)
mtext(text=laba, side=4, line=0.3, at=pos2, las=1, cex=0.8)
}
if (mode==3){
labaaa <- aaa
labbbb <- bbb
if ((prot == "run1SC") || (prot == "run2SC") || (prot == "run3SC") || (prot == "run4SC")) {
labaaa <- labaaa[! labaaa %in% gly]
labbbb <- labbbb[! labbbb %in% gly]
}
laba <- paste(rescodes[labaaa],labaaa,sep="")
labb <- paste(rescodes[labbbb],labbbb,sep="")
laba[which(laba=="LIG621")]="LIG"
laba[which(laba=="Na2622")]="Na2"
laba[which(laba=="Na1623")]="Na1"
laba[which(laba=="Cl624")]="Cl"
labb[which(labb=="LIG621")]="LIG"
labb[which(labb=="Na2622")]="Na2"
labb[which(labb=="Na1623")]="Na1"
labb[which(labb=="Cl624")]="Cl"
mtext(text=labb, side=1, line=0.3, at=pos1, las=2, cex=0.8)
mtext(text=laba, side=2, line=0.3, at=pos2, las=1, cex=0.8)
mtext(text=labb, side=3, line=0.3, at=pos1, las=2, cex=0.8)
mtext(text=laba, side=4, line=0.3, at=pos2, las=1, cex=0.8)
}
image.plot(a,col=tim.colors(64),legend.only=TRUE,zlim=c(0,1))
#}
#if (save==1) {dev.off()}



#a <- t(a)
if (save==1) {png(pngfile,width=1100,height=825,res=160)
par(mar=c(3,3,4,6.5))
if (mode==0) {image(a,axes=FALSE,col=tim.colors(64),zlim=c(0,1),main=paste("DAT",prot,"all pairwise interactions",beg,"-",end,"ns \n  "))}
if (mode==1) {image(a,axes=FALSE,col=tim.colors(64),zlim=c(0,1),main=paste("DAT",prot,"pairwise interactions",beg,"-",end,"ns \n  "))}
if (mode==2) {image(a,axes=FALSE,col=tim.colors(64),zlim=c(0,1),main=paste("DAT",prot,"pairwise interactions TM",ttl1,"TM",ttl2,beg,"-",end,"ns \n  "))}
if (mode==3) {image(a,axes=FALSE,col=tim.colors(64),zlim=c(0,1),main=paste("DAT",prot,"pairwise interactions",name,"time",beg,"-",end,"ns \n  "))}
lab <- c("1","2","3","4","5","6","7","8","9","10","11","12","LIG")
if (mode==1){
mtext(text=lab, side=2, line=0.3, at=pos, las=1, cex=0.9)
mtext(text=lab, side=1, line=0.3, at=pos, las=1, cex=0.9)
}
if (mode==2){
mtext(text=labb, side=1, line=0.3, at=pos1, las=2, cex=0.8)
mtext(text=laba, side=2, line=0.3, at=pos2, las=1, cex=0.8)
mtext(text=labb, side=3, line=0.3, at=pos1, las=2, cex=0.8)
mtext(text=laba, side=4, line=0.3, at=pos2, las=1, cex=0.8)
}
if (mode==3){
mtext(text=labb, side=1, line=0.3, at=pos1, las=2, cex=0.6)
mtext(text=laba, side=2, line=0.3, at=pos2, las=1, cex=0.6)
mtext(text=labb, side=3, line=0.3, at=pos1, las=2, cex=0.6)
mtext(text=laba, side=4, line=0.3, at=pos2, las=1, cex=0.6)
}
image.plot(a,col=tim.colors(64),legend.only=TRUE,zlim=c(0,1))
dev.off()}
}
}
}