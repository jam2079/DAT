#boot <- 1
atom <- read.table("atom.vector")[,1]
args <- commandArgs(TRUE)
ncovmat <- 1
prot <- args[1]
run <- args[2]
nmbr <- args[3]
nmbr <- as.numeric(nmbr)
print(nmbr)
#tmtmtm <- args[3]
dcdfile <- paste(prot,"_run",run,"_",nmbr,"_evol_fixed_long.dcd",sep="")

beg <- (nmbr - 1)*500+1
end <- (nmbr + 9)*500

if ((run=="1")||(run=="1BB")||(run=="1SC")||(run=="1CA")){from <- "1" }
if ((run=="2")||(run=="2BB")||(run=="2SC")||(run=="2CA")){from <- "2" }
if ((run=="3")||(run=="3BB")||(run=="3SC")||(run=="3CA")){from <- "3" }
if ((run=="4")||(run=="4BB")||(run=="4SC")||(run=="4CA")){from <- "4" }

file_name <- paste(dcdfile,".Rdata",sep="")
if (file.exists(file_name)) {
    load(file_name)
} else {
    for (i in 1:ncovmat) {
        name <- paste(beg,"_",end,".dcd.varcov.dat",sep="")
        if (i ==1) {
            C <- try(list(as.matrix(read.table(name))))
#            if ((run == "1BB") || (run == "2BB") || (run == "3BB") || (run == "4BB")){
#                take <- as.vector(as.matrix(read.table(paste("../../BB/",prot,"_run",from,"_BB.dat",sep=""))))
#		take <- sort(c(take*3-2,take*3-1,take*3))
#                C <- C[take,take]
#            }
#            if ((run == "1SC") || (run == "2SC") || (run == "3SC") || (run == "4SC")){
#                take <- as.vector(as.matrix(read.table(paste("../../SC/",prot,"_run",from,"_SC.dat",sep=""))))
#		take <- sort(c(take*3-2,take*3-1,take*3))
#                C <- C[take,take]
#            }
        } else {
            C[[i]] <- try(as.matrix(read.table(name)))
#            if ((run == "1BB") || (run == "2BB") || (run == "3BB") || (run == "4BB")){
#                take <- as.vector(as.matrix(read.table(paste("../../BB/",prot,"_run",from,"_BB.dat",sep=""))))
#		take <- sort(c(take*3-2,take*3-1,take*3))
#                C[[i]] <- C[[i]][take,take]
#            }
#            if ((run == "1SC") || (run == "2SC") || (run == "3SC") || (run == "4SC")){
#                take <- as.vector(as.matrix(read.table(paste("../../SC/",prot,"_run",from,"_SC.dat",sep=""))))
#		take <- sort(c(take*3-2,take*3-1,take*3))
#                C[[i]] <- C[[i]][take,take]
#            }
        }
        if (class(C[[i]]) == "try-error") {
            print(paste("Error in matrix ", i, ".", sep=""))
        }
    }
}

save.image(file=file_name)
#q(save="no")
rm(AVE_R_TCI)
rm(AVE_pairR_ALL)
source("itfunctions.R")

atom <- read.table("atom.vector")[,1]
args <- commandArgs(TRUE)
file_name <- paste(dcdfile,".Rdata",sep="")
tmtmtm <- args[4]

require(caTools)

# Here you need to define the segments you are looking at
nres <- 624

if ((run == "1")||(run == "1BB")||(run == "1SC")||(run=="1CA")) {
    TM1a<-c(66:77)
    TM1b<-c(80:93)
    TM2<- c(95:123)
    TM3<- c(136:172)
    TM4<- c(238:257)
    TM5<- c(260:284)
    TM6a<-c(308:322)
    TM6b<-c(328:335)
    TM7<- c(342:374)
    TM8<- c(403:438)
    TM9<- c(443:467)
    TM10<-c(482:498)
    TM11<-c(518:548)
    TM12<-c(556:582)
}
if ((run == "2")||(run == "2BB")||(run == "2SC")||(run=="2CA")) {
    TM1a<-c(66:77)
    TM1b<-c(80:93)
    TM2<- c(95:121)
    TM3<- c(136:172)
    TM4<- c(238:257)
    TM5<- c(259:285)
    TM6a<-c(308:322)
    TM6b<-c(328:335)
    TM7<- c(342:370)
    TM8<- c(403:438)
    TM9<- c(443:468)
    TM10<-c(482:498)
    TM11<-c(518:551)
    TM12<-c(555:582)
}
if ((run == "3")||(run == "3BB")||(run == "3SC")||(run=="3CA")) {
    TM1a<-c(66:77)
    TM1b<-c(80:93)
    TM2<- c(95:121)
    TM3<- c(136:172)
    TM4<- c(238:257)
    TM5<- c(259:284)
    TM6a<-c(308:322)
    TM6b<-c(328:335)
    TM7<- c(343:373)
    TM8<- c(403:438)
    TM9<- c(444:468)
    TM10<-c(482:498)
    TM11<-c(518:553)
    TM12<-c(556:581)
}
if ((run == "4")||(run == "4BB")||(run == "4SC")||(run=="4CA")) {
    TM1a<-c(66:77)
    TM1b<-c(80:93)
    TM2<- c(95:123)
    TM3<- c(136:172)
    TM4<- c(238:257)
    TM5<- c(259:285)
    TM6a<-c(308:322)
    TM6b<-c(328:335)
    TM7<- c(342:370)
    TM8<- c(403:438)
    TM9<- c(444:468)
    TM10<-c(482:497)
    TM11<-c(518:542)
    TM12<-c(555:581)
}
TM <- list(TM1a,TM2,TM3,TM4,TM5,TM6a,TM7,TM8,TM9,TM10,TM11,TM12,TM1b,TM6b)

rescodes<-c("M","S","K","S","K","C","S","V","G","L","M","S","S","V","V","A","P","A","K","E","P","N","A","V","G","P","K","E","V","E","L","I","L","V","K","E","Q","N","G","V","Q","L","T","S","S","T","L","T","N","P","R","Q","S","P","V","E","A","Q","D","R","E","T","W","G","K","K","I","D","F","L","L","S","V","I","G","F","A","V","D","L","A","N","V","W","R","F","P","Y","L","C","Y","K","N","G","G","G","A","F","L","V","P","Y","L","L","F","M","V","I","A","G","M","P","L","F","Y","M","E","L","A","L","G","Q","F","N","R","E","G","A","A","G","V","W","K","I","C","P","I","L","K","G","V","G","F","T","V","I","L","I","S","L","Y","V","G","F","F","Y","N","V","I","I","A","W","A","L","H","Y","L","F","S","S","F","T","T","E","L","P","W","I","H","C","N","N","S","W","N","S","P","N","C","S","D","A","H","P","G","D","S","S","G","D","S","S","G","L","N","D","T","F","G","T","T","P","A","A","E","Y","F","E","R","G","V","L","H","L","H","Q","S","H","G","I","D","D","L","G","P","P","R","W","Q","L","T","A","C","L","V","L","V","I","V","L","L","Y","F","S","L","W","K","G","V","K","T","S","G","K","V","V","W","I","T","A","T","M","P","Y","V","V","L","T","A","L","L","L","R","G","V","T","L","P","G","A","I","D","G","I","R","A","Y","L","S","V","D","F","Y","R","L","C","E","A","S","V","W","I","D","A","A","T","Q","V","C","F","S","L","G","V","G","F","G","V","L","I","A","F","S","S","Y","N","K","F","T","N","N","C","Y","R","D","A","I","V","T","T","S","I","N","S","L","T","S","F","S","S","G","F","V","V","F","S","F","L","G","Y","M","A","Q","K","H","S","V","P","I","G","D","V","A","K","D","G","P","G","L","I","F","I","I","Y","P","E","A","I","A","T","L","P","L","S","S","A","W","A","V","V","F","F","I","M","L","L","T","L","G","I","D","S","A","M","G","G","M","E","S","V","I","T","G","L","I","D","E","F","Q","L","L","H","R","H","R","E","L","F","T","L","F","I","V","L","A","T","F","L","L","S","L","F","C","V","T","N","G","G","I","Y","V","F","T","L","L","D","H","F","A","A","G","T","S","I","L","F","G","V","L","I","E","A","I","G","V","A","W","F","Y","G","V","G","Q","F","S","D","D","I","Q","Q","M","T","G","Q","R","P","S","L","Y","W","R","L","C","W","K","L","V","S","P","C","F","L","L","F","V","V","V","V","S","I","V","T","F","R","P","P","H","Y","G","A","Y","I","F","P","D","W","A","N","A","L","G","W","V","I","A","T","S","S","M","A","M","V","P","I","Y","A","A","Y","K","F","C","S","L","P","G","S","F","R","E","K","L","A","Y","A","I","A","P","E","K","D","R","E","L","V","D","R","G","E","V","R","Q","F","T","L","R","H","W","L","K","V","LIG","Na2","Na1","Cl")
gly <- which(rescodes=="G")

if ((run == "1SC") || (run == "2SC") || (run == "3SC") || (run == "4SC" )){
    for (i in 1:length(gly)) {
        for (j in 1:length(TM)) {
            if (length(intersect(gly[i],TM[[j]]))>0){ TM[[j]] <- TM[[j]][-which(TM[[j]]==gly[i])] }
        }
    }
}

#save.image(file=file_name)

#print("tmtmtm")
#print(tmtmtm)
#for (stp in 1:length(TM)){
#    if (tmtmtm == stp) {
#        select <- stp
#        print("select")
#        print(select)
#        outfile <- paste("../rigidity/data/",prot,"_",ncovmat,"_",boot,"_AVE_R_TCI_",select,".dat",sep="")
#        if (file.exists(outfile)) {q(save="no")}
#        TMn <- list(TM[[select]])
#        print("Start rigidity")
#        AVE_R_TCI <- lapply(TMn, calculate.average.n.body.inter.corr, C=C[1:ncovmat], atom=atom)
#        print("End rigidity")
#        save.image(file=file_name)
#        print("Saved")
#        write.table(AVE_R_TCI, file=outfile)
#        print("Written")
#        q(save="no")
#    }
#}


outfile <- paste("../../pairwise/evol/data/",dcdfile,"_pairR_ALL.dat",sep="")
if (!file.exists(outfile)) {
    print("Start AVE_pairR_ALL")
    print(TM[[1]])
    AVE_pairR_ALL <- calculate.all.frc.average.intercorrelation.coefficient(C=C[1:ncovmat],TM,atom)
    print("End AVE_pairR_ALL")
    save.image(file=file_name)
    print("Saved")
    write.table(AVE_pairR_ALL, file=outfile)
    print("Written")
}

nres <- 624
for (sz in c(1)) {
    outfile <- paste("../../sweep/evol/data/",dcdfile,"_sweep_window_",sz,"_lig.dat",sep="")
    if (file.exists(outfile)) { next }
    print(paste(sz,"started"))
    all <- list()
    count <- 1
    for (i in 1:(nres-sz+1)){
        put <- c(i:(i+sz-1))
        if (((run == "1SC") || (run == "2SC") || (run == "3SC") || (run == "4SC")) && (length(intersect(put,gly)) > 0)) {next}
        all[[count]]=put
        count <- count+1
    }
    print(all)
    sweep <- calculate.all.frc.average.intercorrelation.coefficient(C=C[1:ncovmat],all,atom)
    print("End sweep")
    save.image(file=file_name)
    write.table(sweep, file=outfile)
    print(paste(sz,"finished"))
}


q(save="no")
