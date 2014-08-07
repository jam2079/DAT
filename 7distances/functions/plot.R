prot <- "DAT"

for (run in c(1:5)) {
runn <- run
if (as.numeric(run) < 10) {
    runn <- paste(0,run,sep="")
}
window <- 100

require(zoo)

set<-"S2"
res<-c(60,335,428)

if (0) {

path <- paste("distances/")
for (r1 in res){
    for (r2 in res) {if (r1 < r2){
        pngfile<-paste(path,"plots/distance_",r1,"_",r2,"_",prot,"_run",runn,".png",sep="")
        datfile<-paste(path,"data/distance_",r1,"_",r2,"_",prot,"_run",run,".dat",sep="")
	print(datfile)
	print(pngfile)
        if ( file.exists(datfile) ) {
            a<-read.table(datfile)
            a<-as.vector(as.matrix(a))
            a <- rollmean(a,window)
            png(pngfile,width=1100,height=825,res=160)
            plot((1:length(a))-1,a,"l",main=paste(prot,"run",run,"distance",r1,r2),xlab="Frame", ylab="Distance")
            dev.off()
        }
    }}
}

r1<-"Na1"
r2<-"Na2"
pngfile<-paste(path,"plots/distance_",prot,"_run",runn,"_",r1,"_",r2,".png",sep="")
datfile<-paste(path,"data/distance_",prot,"_run",run,"_",r1,"_",r2,".dat",sep="")
#if ( (!file.exists(pngfile)) && (file.exists(datfile)) ) {
#print("alo")
if ( file.exists(datfile) ) {
#print("ola")
    a<-read.table(datfile)
    a<-as.vector(as.matrix(a))
    a <- rollmean(a,window)
    png(pngfile,width=1100,height=825,res=160)
    plot((1:length(a))-1,a,"l",main=paste(prot,"run",run,"distance",r1,r2),xlab="Frame", ylab="Distance")
    dev.off()
}

pngfile<-paste(path,"plots/distance_",prot,"_run",runn,"_",r1,"_Na_nearest.png",sep="")
datfile<-paste(path,"data/distance_",prot,"_run",run,"_",r1,"_Na_nearest.dat",sep="")
#if ( (!file.exists(pngfile)) && (file.exists(datfile)) ) {
if ( file.exists(datfile) ) {
    a<-read.table(datfile)
    a<-as.vector(as.matrix(a))
    a <- rollmean(a,window)
    png(pngfile,width=1100,height=825,res=160)
    plot((1:length(a))-1,a,"l",main=paste(prot,"run",run,"distance",r1,"-n earest Na"),xlab="Frame", ylab="Distance")
    dev.off()
}


path <- paste("cluster/")
pngfile<-paste(path,"plots/tm16distance_",prot,"_run",runn,".png",sep="")
datfile<-paste(path,"data/tm16distance_",prot,"_run",run,".dat",sep="")
#if ( (!file.exists(pngfile)) && (file.exists(datfile)) ) {
if ( file.exists(datfile) ) {
    a<-read.table(datfile)
    a<-as.vector(as.matrix(a))
    a <- rollmean(a,window)
    png(pngfile,width=1100,height=825,res=160)
    plot((1:length(a))-1,a,"l",main=paste(prot,"run",run,"distance TMs 1-6"),xlab="Frame", ylab="Distance")
    dev.off()
}

pngfile<-paste(path,"plots/bulkions_",prot,"_run",runn,".png",sep="")
datfile<-paste(path,"data/bulkions_",prot,"_run",run,".dat",sep="")
#if ( (!file.exists(pngfile)) && (file.exists(datfile)) ) {
if ( file.exists(datfile) ) {
    a<-read.table(datfile)
    a<-as.vector(as.matrix(a))
    a <- rollmean(a,window)
    png(pngfile,width=1100,height=825,res=160)
    plot((1:length(a))-1,a,"l",main=paste(prot,"run",run,"min distance E428-ion in bulk"),xlab="Frame", ylab="Distance")
    dev.off()
}

res<-c(66,333,443)
path <- paste("cluster/")
for (r1 in res){
    for (r2 in res) {if (r1 < r2){
        pngfile<-paste(path,"plots/cadistance_",r1,"_",r2,"_",prot,"_run",runn,".png",sep="")
        datfile<-paste(path,"data/cadistance_",r1,"_",r2,"_",prot,"_run",run,".dat",sep="")
	print(datfile)
	print(pngfile)
        if ( file.exists(datfile) ) {
            a<-read.table(datfile)
            a<-as.vector(as.matrix(a))
            a <- rollmean(a,window)
            png(pngfile,width=1100,height=825,res=160)
            plot((1:length(a))-1,a,"l",main=paste(prot,"run",run,"CA distance",r1,r2),xlab="Frame", ylab="Distance")
            dev.off()
        }
    }}
}

path <- "cluster/"
pngfile<-paste(path,"plots/contacts_",prot,"_run",runn,".png",sep="")
datfile<-paste(path,"data/contacts_",prot,"_run",run,".dat",sep="")
if ( file.exists(datfile) ) {
    a<-read.table(datfile)
    a<-as.vector(as.matrix(a))
    a <- rollmean(a,window)
    png(pngfile,width=1100,height=825,res=160)
    plot((1:length(a))-1,a,"l",main=paste(prot,"run",run,"contacts IL4-N terminus"),xlab="Frame", ylab="Number")
    dev.off()
}

pngfile<-paste(path,"plots/pip2icl4distance_",prot,"_run",runn,".png",sep="")
datfile<-paste(path,"data/pip2icl4distance_",prot,"_run",run,".dat",sep="")
if ( file.exists(datfile) ) {
        a<-read.table(datfile)
        a<-as.vector(as.matrix(a))
        a <- rollmean(a,window)
        png(pngfile,width=1100,height=825,res=160)
        plot((1:length(a))-1,a,"l",main=paste(prot,"run",run,"PIP2-ICL4 distance"),xlab="Frame", ylab="Distance")
        dev.off()
}
}

path <- "cluster/"
pngfile<-paste(path,"plots/mediatedcontacts_",prot,"_run",runn,".png",sep="")
datfile<-paste(path,"data/mediatedcontacts_",prot,"_run",run,".dat",sep="")
if ( file.exists(datfile) ) {
    a<-read.table(datfile)
    a<-as.vector(as.matrix(a))
    a <- rollmean(a,window)
    png(pngfile,width=1100,height=825,res=160)
    plot((1:length(a))-1,a,"l",main=paste(prot,"run",run,"PIP2 mediated contacts IL4-N terminus"),xlab="Frame", ylab="Number",ylim=c(0,7))
    dev.off()
}







}
