rm(list=ls())
args <- commandArgs(TRUE)
prot <- args[1]
run <- args[2]
ncovmat <- 1
nmbr <- args[3]
nmbr <- as.numeric(nmbr)
print(nmbr)
dcdfile <- paste(prot,"_run",run,"_",nmbr,"_evol_fixed_long.dcd",sep="")

beg <- (nmbr - 1)*500+1
end <- (nmbr + 9)*500

print(beg)
print(end)

setwd(paste("../../DAT/run",run,sep=""))

file_name <- paste(dcdfile,".Rdata",sep="")
if (file.exists(file_name)) {
    load(file_name)
} else {
    for (i in 1:ncovmat) {
        if ((run == "1") || (run == "1BB") ||(run == "1SC")) {from <- "1"}
        if ((run == "2") || (run == "2BB") ||(run == "2SC")) {from <- "2"}
        if ((run == "3") || (run == "3BB") ||(run == "3SC")) {from <- "3"}
        if ((run == "4") || (run == "4BB") ||(run == "4SC")) {from <- "4"}
        name <- paste("../run",from,"/",beg,"_",end,".dcd.varcov.dat",sep="")
        if (i ==1) {
            C <- try(list(as.matrix(read.table(name))))
            if ((run == "1BB") || (run == "2BB") || (run == "3BB") || (run == "4BB")){
                take <- as.vector(as.matrix(read.table(paste("../../BB/",prot,"_BB.dat",sep=""))))
                take <- sort(c(take*3-2,take*3-1,take*3))
                C <- C[take,take]
            }
            if ((run == "1SC") || (run == "2SC") || (run == "3SC") || (run == "4SC")){
                take <- as.vector(as.matrix(read.table(paste("../../SC/",prot,"_SC.dat",sep=""))))
                take <- sort(c(take*3-2,take*3-1,take*3))
                C <- C[take,take]
            }
        } else {
            C[[i]] <- try(as.matrix(read.table(name)))
            if ((run == "1BB") || (run == "2BB") || (run == "3BB") || (run == "4BB")){
                take <- as.vector(as.matrix(read.table(paste("../../BB/",prot,"_BB.dat",sep=""))))
                take <- sort(c(take*3-2,take*3-1,take*3))
                C[[i]] <- C[[i]][take,take]
            }
            if ((run == "1SC") || (run == "2SC") || (run == "3SC") || (run == "4SC")){
                take <- as.vector(as.matrix(read.table(paste("../../SC/",prot,"_SC.dat",sep=""))))
                take <- sort(c(take*3-2,take*3-1,take*3))
                C[[i]] <- C[[i]][take,take]
            }
        }
        if (class(C[[i]]) == "try-error") {
            print(paste("Error in matrix ", i, ".", sep=""))
        }
    }
}

outfile <- paste("../../pairwise/evol/data/",dcdfile,"_pairR_ALL.dat",sep="")
write.table(AVE_pairR_ALL, file=outfile)

setwd("../../pairwise/evol")

save <- 1
require(fields)
require(gplots)

datfile <-paste("data/",prot,"_run",run,"_",num,"_evol_fixed_long.dcd_pairR_ALL.dat",sep="")
pngfile <-paste("plots/",prot,"_run",run,"_",num,"_evol_fixed_long.dcd_pairR_ALL.png",sep="")

#if (!(file.exists(datfile))) {q(save="no")}
print(prot)
d <- read.table(datfile)

TM <- c("TM1a","TM2","TM3","TM4","TM5","TM6a","TM7","TM8","TM9","TM10","TM11","TM12","TM1b","TM6b")
TMx <- c("1a","2","3","4","5","6a","7","8","9","10","11","12","1b","6b")
take <- c(1,13,6,14,2,7,3,4,8,9,5,10,11,12)
div <- dim(d)[1]
    
all <- as.matrix(d[1:div,1:div])
a <- as.matrix(all[take,take])
a[a==1]=NA
    
nrows <- dim(a)[1]
pos <- seq(0,1,1/(nrows-1))

if (save==1) {png(pngfile,width=1100,height=825,res=160)}
par(mar=c(3,4,3,5.5))
image(a,axes=FALSE,col=tim.colors(64),zlim=c(0,1),main=paste(prot,"run",run,"pairwise interactions num",num))
mtext(text=TM[take], side=2, line=0.3, at=pos, las=1, cex=1)
mtext(text=TMx[take], side=1, line=0.3, at=pos, las=1, cex=1)
image.plot(a,col=tim.colors(64),legend.only=TRUE,zlim=c(0,1))
abline(v=(-pos[2])/2)
abline(v=(pos[6]+pos[7])/2)
abline(v=(pos[10]+pos[11])/2)
abline(v=(pos[12]+pos[13])/2)
abline(v=(pos[14]+(pos[2]/2)))
abline(h=(-pos[2])/2)
abline(h=(pos[6]+pos[7])/2)
abline(h=(pos[10]+pos[11])/2)
abline(h=(pos[12]+pos[13])/2)
abline(h=(pos[14]+(pos[2]/2)))
if (save==1) {dev.off()}
print(prot)

