
rm(list=ls())
require(zoo)
require(xlsx)
window <- 100

nn <- c(37107,40414,40000,24418,18561,0,0,0,0,0,513,460,460,432,486,296,430,893,0,0,2500,2500,2500,0,0,0,0,0,0,0,282,793,752,618)

list <- structure(NA,class="result")
"[<-.result" <- function(x,...,value) {
    args <- as.list(match.call())
    args <- args[-c(1:2,length(args))]
    length(value) <- length(args)
    for(i in seq(along=args)) {
        a <- args[[i]]
        if(!missing(a)) eval.parent(substitute(a <- v,list(a=a,v=value[[i]])))
    }
    x
}
readall <- function(run,window,n){
    Contacts.IL4_Nter <- paste("../7distances/cluster/data/mediatedcontacts_DAT_run",run,".dat",sep="")
    Contacts.IL4_Nter <- as.vector(rollmean(read.table(Contacts.IL4_Nter,nrows=n),align="center",window))
    W.IC_cav <- paste("../10watercounts/watercounts/data/watercounts_IC_cav_DAT_run",run,".dat",sep="")
    W.IC_cav <- as.vector(rollmean(read.table(W.IC_cav,nrows=n),align="center",window))
    Dist.TM1a_6b <- paste("../7distances/cluster/data/tm16distance_DAT_run",run,".dat",sep="")
    Dist.TM1a_6b <- as.vector(rollmean(read.table(Dist.TM1a_6b,nrows=n),align="center",window))
    Dist.TM1a_IL4 <- paste("../7distances/cluster/data/cadistance_66_443_DAT_run",run,".dat",sep="")
    Dist.TM1a_IL4 <- as.vector(rollmean(read.table(Dist.TM1a_IL4,nrows=n),align="center",window))
    Dist.TM6b_IL4 <- paste("../7distances/cluster/data/cadistance_333_443_DAT_run",run,".dat",sep="")
    Dist.TM6b_IL4 <- as.vector(rollmean(read.table(Dist.TM6b_IL4,nrows=n),align="center",window))
    BrokenCont.IC_gate <- paste("../7distances/cluster/data/numbrokenbonds_DAT_run",run,".dat",sep="")
    BrokenCont.IC_gate <- as.vector(rollmean(read.table(BrokenCont.IC_gate,nrows=n),align="center",window))
    return(list(Contacts.IL4_Nter,W.IC_cav,Dist.TM1a_6b,Dist.TM1a_IL4,Dist.TM6b_IL4,BrokenCont.IC_gate))
}
readall.long <- function(run,window,n){
    Contacts.IL4_Nter <- paste("../7distances/cluster/data/mediatedcontacts_DAT_run",run,"_long.dat",sep="")
    Contacts.IL4_Nter <- as.vector(rollmean(read.table(Contacts.IL4_Nter,nrows=n),align="center",window))
    W.IC_cav <- paste("../10watercounts/watercounts/data/watercounts_IC_cav_DAT_run",run,"_long.dat",sep="")
    W.IC_cav <- as.vector(rollmean(read.table(W.IC_cav,nrows=n),align="center",window))
    Dist.TM1a_6b <- paste("../7distances/cluster/data/tm16distance_DAT_run",run,"_long.dat",sep="")
    Dist.TM1a_6b <- as.vector(rollmean(read.table(Dist.TM1a_6b,nrows=n),align="center",window))
    Dist.TM1a_IL4 <- paste("../7distances/cluster/data/cadistance_66_443_DAT_run",run,"_long.dat",sep="")
    Dist.TM1a_IL4 <- as.vector(rollmean(read.table(Dist.TM1a_IL4,nrows=n),align="center",window))
    Dist.TM6b_IL4 <- paste("../7distances/cluster/data/cadistance_333_443_DAT_run",run,"_long.dat",sep="")
    Dist.TM6b_IL4 <- as.vector(rollmean(read.table(Dist.TM6b_IL4,nrows=n),align="center",window))
    BrokenCont.IC_gate <- paste("../7distances/cluster/data/numbrokenbonds_DAT_run",run,"_long.dat",sep="")
    BrokenCont.IC_gate <- as.vector(rollmean(read.table(BrokenCont.IC_gate,nrows=n),align="center",window))
    return(list(Contacts.IL4_Nter,W.IC_cav,Dist.TM1a_6b,Dist.TM1a_IL4,Dist.TM6b_IL4,BrokenCont.IC_gate))
}

run <- 1
n <- nn[run]

list[Contacts.IL4_Nter,W.IC_cav,Dist.TM1a_6b,Dist.TM1a_IL4,Dist.TM6b_IL4,BrokenCont.IC_gate] <- readall(run,window,n)
mydata <- as.data.frame(cbind(Contacts.IL4_Nter,W.IC_cav,Dist.TM1a_6b,Dist.TM1a_IL4,Dist.TM6b_IL4,BrokenCont.IC_gate))
print(dim(mydata))
rm(Contacts.IL4_Nter,W.IC_cav,Dist.TM1a_6b,Dist.TM1a_IL4,Dist.TM6b_IL4,BrokenCont.IC_gate)
cor.mat <- cor(mydata)
#write.xlsx(as.data.frame(cor.mat),file=paste("../8cluster/corr_run",run,".xlsx",sep=""))

for (run in c(2:5,31:34)) {
    n <- nn[run]
    list[Contacts.IL4_Nter,W.IC_cav,Dist.TM1a_6b,Dist.TM1a_IL4,Dist.TM6b_IL4,BrokenCont.IC_gate] <- readall(run,window,n)
    mydata <- rbind(mydata,as.data.frame(cbind(Contacts.IL4_Nter,W.IC_cav,Dist.TM1a_6b,Dist.TM1a_IL4,Dist.TM6b_IL4,BrokenCont.IC_gate)))
    print(dim(mydata))
    rm(Contacts.IL4_Nter,W.IC_cav,Dist.TM1a_6b,Dist.TM1a_IL4,Dist.TM6b_IL4,BrokenCont.IC_gate)
}
write.xlsx(as.data.frame(cor.mat),file=paste("../8cluster/corr_all_runs_long.xlsx",sep=""))




nn <- c(37391,41209,40754,25038)
for (run in 1:4){
n <- nn[run]

list[Contacts.IL4_Nter,W.IC_cav,Dist.TM1a_6b,Dist.TM1a_IL4,Dist.TM6b_IL4,BrokenCont.IC_gate] <- readall.long(run,window,n)
mydata <- as.data.frame(cbind(Contacts.IL4_Nter,W.IC_cav,Dist.TM1a_6b,Dist.TM1a_IL4,Dist.TM6b_IL4,BrokenCont.IC_gate))
print(dim(mydata))
rm(Contacts.IL4_Nter,W.IC_cav,Dist.TM1a_6b,Dist.TM1a_IL4,Dist.TM6b_IL4,BrokenCont.IC_gate)
cor.mat <- cor(mydata)
write.xlsx(as.data.frame(cor.mat),file=paste("../8cluster/corr_run",run,"_long.xlsx",sep=""))
}
