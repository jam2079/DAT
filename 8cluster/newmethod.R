
if(file.exists("DAT/8cluster")==TRUE){setwd("DAT/8cluster")}
rm(list=ls())
#source("unpack2.R")
#options(warn=-1)

PERCENT <- 2
STRIDE <- 100
SET <- "1"
if (SET==1){TAKE <- c(1,2,4,6,15);RANK <- 4}
if (SET==2){TAKE <- c(9,10,13,16);RANK <- 9}
if (SET==3){TAKE <- c(5,7,8,12,14,17);RANK <- 14}
if (SET=="ALL"){TAKE <- c(1:17);RANK <- 4}
PLOT <- 0

load("cluster.Rdata")

#load("cluster.Rdata")
#cat(paste("Number of events:",dim(mydata)[1]))
#dist <- as.matrix(dist(mydata[seq(100,dim(mydata)[1],100),],diag=TRUE))

#c <- as.matrix(read.table("version/example_distances.dat"))
#dist <- matrix(0,max(c[,1:2]),max(c[,1:2]))
#for (i in 1:dim(c)[1]){
#    dist[c[i,1],c[i,2]] <- c[i,3]
#    dist[c[i,2],c[i,1]] <- c[i,3]
#}

#load("dist.Rdata")
#dist <- unpack2(c3)
#rm(c3)

#load("example.Rdata")

####################################################################################

standardize <- function(mydata){
    for (i in 1:dim(mydata)[2]){
        mydata[,i] <- (mydata[,i] - mean(mydata[,i]))/(max(mydata[,i]) - min(mydata[,i]))
    }
    return(mydata)
}

rank <- function(mydatao, icl, RANK){
    centers <- mydatao[icl,]
    rownames(centers) <- 1:length(icl)
    centers <- centers[do.call(order, lapply(RANK, function(i) centers[, i])), ]
    inp <- as.numeric(rownames(centers))
    out <- 1:length(icl)
    rownames(centers) <- out
    icl <- icl[inp]
    cl <- rep(-1,ND)
    cl[icl] <- out
    return(list(centers,icl,cl))
}

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

####################################################################################

n <- dim(mydata)[1]
mydata <- mydata[seq(STRIDE,n,STRIDE),]
mydatao <- mydata
mydata <- mydata[,TAKE]
mydata <- standardize(mydata)
dist <- as.matrix(dist(mydata))

ND <- dim(dist)[1]
N <- ND*(ND-1)/2

cat(paste("average PERCENTage of neighbours (hard coded):",PERCENT,"\n"))
position <- round(N*PERCENT/100)
dc <- sort(dist)[round(position)]
maxd <- max(dist)

cat(paste("Computing Rho with gaussian kernel of radius:", dc,"\n"))
# Gaussian kernel
rho <- unlist(lapply(1:ND, function(i) sum(exp(-(dist[i,]/dc)*(dist[i,]/dc))))) - 1

# "Cut off" kernel
#
#for i=1:ND-1
#  for j=i+1:ND
#    if (dist(i,j)<dc)
#   #       rho(i)=rho(i)+1.; rho(j)=rho(j)+1.;
#    end
#  end
#end

rho_sorted <- sort(rho,decreasing=TRUE)
ordrho <- sapply(1:ND, function(i) which(rho==rho_sorted[i]))

delta <- rep(0,ND)
nneigh <- rep(0,ND)
delta[ordrho[1]]=-1

for (ii in 2:ND){
    delta[ordrho[ii]] <- min(c(dist[ordrho[ii],ordrho[1:(ii-1)]],maxd))
    nneigh[ordrho[ii]] <- ordrho[which(dist[ordrho[ii],ordrho[1:(ii-1)]]==delta[ordrho[ii]])]
}

delta[ordrho[1]]=max(delta);
#cat("Generated file: DECISION GRAPH","\n")
#cat("column 1: Density","\n")
#cat("column 2: Delta","\n")
#tmp <- cbind(rho,delta)
#save(tmp,file="DECISION_GRAPH")

cat("Select rho_min and delta_min enclosing cluster centers","\n")
gamma <- rho*delta
par(mfrow=c(1,1))
plot(rho,delta,'p',main="Decision Graph",xlab="rho",ylab="delta",cex=0.75,pch=16)

#cat("rho minimum: ")
#rhomin <- scan(n=1)
rhomin <- as.numeric(readline("rho minimum: "))
#rhomin <- 20
#cat("delta minimum: ")
#deltamin <- scan(n=1)
deltamin <- as.numeric(readline("delta minimum: "))
#deltamin <- 10
icl <- (rho>rhomin) & (delta>deltamin)
icl <- c(1:ND)[icl]
nclust <- length(icl)

list[centers,icl,cl] <- rank(mydatao,icl,RANK)
centers[,5] <- centers[,5]*180/pi

#cat(paste("NUMBER OF CLUSTERS:", nclust,"\n"))
cat("Performing assignation","\n")
#assignation
for (i in 1:ND){
    if ( cl[ordrho[i]]==-1 ){
	cl[ordrho[i]] <- cl[nneigh[ordrho[i]]]
    }
}

#halo
halo <- cl
bord_rho <- rep(0,nclust)
if ( nclust > 1 ){
    ind <- which(dist <= dc)
    r <- ((ind-1) %% ND) + 1
    c <- floor((ind-1) / ND) + 1
    mat <- cbind(r,c)
    mat <- mat[((cl[r]!=cl[c])),] 
    for (i in 1:nclust){
        mat2 <- as.matrix(mat[cl[mat[,1]]==i,])
        if (dim(mat2)[1]==0){next}
        bord_rho[i] <- max(rho[mat[,1]]+rho[mat[,2]])/2
    }
    halo[ rho < bord_rho[cl]] <- 0
}

nc <- rep(0,nclust)
nh <- rep(0,nclust)
for (i in 1:nclust){
    nc[i] <- length(cl[cl==i])
    nh[i] <- length(halo[halo==i])
}
for (i in 1:nclust){
    points(rho[icl[i]],delta[icl[i]],col=i+1,pch=16)
    text(rho[icl[i]],delta[icl[i]]-0.0125,labels=i,col=i+1)
}
centers <- cbind(centers,' '=nc,N.core=nh,N.halo=nc-nh)
print(centers[,TAKE])
print(centers)

Sys.sleep(1)
cat("Performing 2D nonclassical multidimensional scaling \n")
Y1 <- cmdscale(dist)
#Y1 = mdscale(dist, 2,,'metricstress');
par(mfrow=c(2,1))
plot(rho,delta,'p',main="Decision Graph",xlab="rho",ylab="delta",cex=0.75,pch=16)
for (i in 1:nclust){
    points(rho[icl[i]],delta[icl[i]],col=i+1,pch=16)
    text(rho[icl[i]],delta[icl[i]]-0.05,labels=i,col=i+1)
}
plot(Y1[,1],Y1[,2],'p',main="2D multidimensional scaling",xlab="X",ylab="Y",cex=0.01)
for (i in 1:nclust){
    points(Y1[cl==i,1],Y1[cl==i,2],'p',col=i+1,cex=0.01)
}

#%for i=1:ND
#%   if (halo(i)>0)
#    %      ic=int8((halo(i)*64.)/(nclust*1.));
#%      hold on
#%      plot(Y1(i,1),Y1(i,2),'o','MarkerSize',2,'MarkerFaceColor',cmap(ic,:),'MarkerEdgeColor',cmap(ic,:));
#%   end
#%end
#faa = fopen('CLUSTER_ASSIGNATION', 'w');
#cat("Generated file: CLUSTER_ASSIGNATION\n")
#cat("column 1: element id\n")
#cat("column 2: cluster assignation without halo control\n")
#cat("column 3: cluster assignation with halo control\n")
#tmp <- cbind(1:ND,cl,halo)
#save(tmp,file="CLUSTER_ASSIGNATION")

if (PLOT) {
  n <- c(32996,32689,39901,24319,18462,0,0,0,0,0,414,361,361,333,387,197,331,794)
  n <- floor(n/STRIDE)
  n1 <- list(c(1:n[1]))
  nn <- lapply(2:18, function(i) c((sum(n[1:(i-1)])+1):sum(n[1:i])))
  nn <- append(n1,nn)
    for (run in c(1:5,11:18)) {
        png(paste("new/set",SET,"_num",nclust,"_run",run,".png",sep=""),width=1100,height=825,res=160)
        if(run<10){plot((1:n[run]),cl[nn[[run]]],ylim=c(1,nclust),ylab="Cluster",xlab="Frame",main=paste("Cluster distribution of set",SET,"with",nclust,"groups in run",run),cex=0.01)}
        if(run>10){plot((1:n[run]),cl[nn[[run]]],"l",ylim=c(1,nclust),ylab="Cluster",xlab="Frame",main=paste("Cluster distribution of set",SET,"with",nclust,"groups in run",run),cex=0.01)}
        dev.off()
    }
png(paste("new/set",SET,"_num",nclust,".png",sep=""),width=700,height=1400,res=160)
par(mfrow=c(2,1))
plot(rho,delta,'p',main="Decision Graph",xlab="rho",ylab="delta",cex=0.75,pch=16)
for (i in 1:nclust){
    points(rho[icl[i]],delta[icl[i]],col=i+1,pch=16)
    text(rho[icl[i]],delta[icl[i]]-0.05,labels=i,col=i+1,cex=1)
}
plot(Y1[,1],Y1[,2],'p',main="2D multidimensional scaling",xlab="X",ylab="Y",cex=0.01)
for (i in 1:nclust){
    points(Y1[cl==i,1],Y1[cl==i,2],'p',col=i+1,cex=0.01)
}
dev.off()
}

#heatmap(abs(cor(mydata)),dendrogram="none",col=colorRampPalette(c("blue","cyan","yellow","red"))(256))