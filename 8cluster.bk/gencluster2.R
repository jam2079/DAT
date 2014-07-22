
rm(list=ls())
require(zoo)
window <- 100


nn <- c(33095,32788,40000,24418,18561,0,0,0,0,0,513,460,460,432,486,296,430,893)
run <- 1
n <- 33095

W.IC_cav <- paste("../10watercounts/watercounts/data/watercounts_IC_cav_DAT_run",run,".dat",sep="")
W.IC_cav <- as.vector(rollmean(read.table(W.IC_cav,nrows=n),align="center",window))
W.IC_cha <- paste("../10watercounts/watercounts/data/watercounts_IC_cha_DAT_run",run,".dat",sep="")
W.IC_cha <- as.vector(rollmean(read.table(W.IC_cha,nrows=n),align="center",window))
W.sum <- W.IC_cav+W.IC_cha
Dist.TM1_6 <- paste("../7distances/cluster/data/tm16distance_DAT_run",run,".dat",sep="")
Dist.TM1_6 <- as.vector(rollmean(read.table(Dist.TM1_6,nrows=n),align="center",window))
Kink.TM51<- paste("../7distances/kinks/data/kink_DAT_run",run,"_bend5_264.txt",sep="")
Kink.TM52<- paste("../7distances/kinks/data/kink_DAT_run",run,"_bend5_265.txt",sep="")
Kink.TM5 <- (as.vector(rollmean(read.table(Kink.TM51,nrows=n),align="center",window))+as.vector(rollmean(read.table(Kink.TM52,nrows=n),align="center",window)))/2
Dist.Na_Na <- paste("../7distances/distances/data/distance_DAT_run",run,"_Na1_Na_nearest.dat",sep="")
Dist.Na_Na <- as.vector(rollmean(read.table(Dist.Na_Na,nrows=n),align="center",window))
Dist.E428_bulk.ion <- paste("../7distances/cluster/data/bulkions_DAT_run",run,".dat",sep="")
Dist.E428_bulk.ion <- as.vector(rollmean(read.table(Dist.E428_bulk.ion,nrows=n),align="center",window))
Contacts.IL4_Nter <- paste("../7distances/cluster/data/contacts_DAT_run",run,".dat",sep="")
Contacts.IL4_Nter <- as.vector(rollmean(read.table(Contacts.IL4_Nter,nrows=n),align="center",window))
mydata <- as.data.frame(cbind(W.IC_cav,W.IC_cha,W.sum,Dist.TM1_6,Kink.TM5,Dist.Na_Na,Dist.E428_bulk.ion,Contacts.IL4_Nter))
print(length(W.sum))
rm(W.IC_cav,W.IC_cha,W.sum,Dist.TM1_6,Kink.TM5,Kink.TM51,Kink.TM52,Dist.Na_Na,Dist.E428_bulk.ion,Contacts.IL4_Nter)
print(dim(mydata))

for (run in c(2:5,11:18)) {
n <- nn[run]

W.IC_cav <- paste("../10watercounts/watercounts/data/watercounts_IC_cav_DAT_run",run,".dat",sep="")
W.IC_cav <- as.vector(rollmean(read.table(W.IC_cav,nrows=n),align="center",window))
W.IC_cha <- paste("../10watercounts/watercounts/data/watercounts_IC_cha_DAT_run",run,".dat",sep="")
W.IC_cha <- as.vector(rollmean(read.table(W.IC_cha,nrows=n),align="center",window))
W.sum <- W.IC_cav+W.IC_cha
#stop()
Dist.TM1_6 <- paste("../7distances/cluster/data/tm16distance_DAT_run",run,".dat",sep="")
Dist.TM1_6 <- as.vector(rollmean(read.table(Dist.TM1_6,nrows=n),align="center",window))
Kink.TM51<- paste("../7distances/kinks/data/kink_DAT_run",run,"_bend5_264.txt",sep="")
Kink.TM52<- paste("../7distances/kinks/data/kink_DAT_run",run,"_bend5_265.txt",sep="")
Kink.TM5 <- (as.vector(rollmean(read.table(Kink.TM51,nrows=n),align="center",window))+as.vector(rollmean(read.table(Kink.TM52,nrows=n),align="center",window)))/2
Dist.Na_Na <- paste("../7distances/distances/data/distance_DAT_run",run,"_Na1_Na_nearest.dat",sep="")
Dist.Na_Na <- as.vector(rollmean(read.table(Dist.Na_Na,nrows=n),align="center",window))
Dist.E428_bulk.ion <- paste("../7distances/cluster/data/bulkions_DAT_run",run,".dat",sep="")
Dist.E428_bulk.ion <- as.vector(rollmean(read.table(Dist.E428_bulk.ion,nrows=n),align="center",window))
Contacts.IL4_Nter <- paste("../7distances/cluster/data/contacts_DAT_run",run,".dat",sep="")
Contacts.IL4_Nter <- as.vector(rollmean(read.table(Contacts.IL4_Nter,nrows=n),align="center",window))
mydata <- rbind(mydata,as.data.frame(cbind(W.IC_cav,W.IC_cha,W.sum,Dist.TM1_6,Kink.TM5,Dist.Na_Na,Dist.E428_bulk.ion,Contacts.IL4_Nter)))
print(length(W.sum))
rm(W.IC_cav,W.IC_cha,W.sum,Dist.TM1_6,Kink.TM5,Kink.TM51,Kink.TM52,Dist.Na_Na,Dist.E428_bulk.ion,Contacts.IL4_Nter)
print(dim(mydata))
}

save(mydata,file="cluster.Rdata")

