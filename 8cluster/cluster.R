
rm(list=ls())

n <- c(32996,32689,39901,24319,18462,0,0,0,0,0,414,361,361,333,387,197,331,794)
n1 <- list(c(1:n[1]))
nn <- lapply(2:18, function(i) c((sum(n[1:(i-1)])+1):sum(n[1:i])))
nn <- append(n1,nn)

load("cluster.Rdata")
#mydata <- mydata[nn[[1]],]

#REMOVE <- c(1:4,7,8,11:17)
REMOVE <- c(3,5,9:17)
RANGE <- 6
PLOT <- 1
PLOTALLK <- 0
SET <- "EC"
RANK <- 11

C <- list()
C[[1]] <- cor(mydata)

if (is.null(REMOVE)) {REMOVE <- 100}
#mydata <- mydata[,-REMOVE]
A <- list()

if (PLOTALLK) {
	# Determine number of clusters
	wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var))
	for (i in 2:15) wss[i] <- kmeans(mydata, centers=i)$tot.withinss
	plot(1:15, wss, type="b", xlab="Number of Clusters", ylab="Within groups sum of squares")
#	mn <- c()
#	for (k in 2:15) {
#		print(k)
#		all<- c()
#		for (i in 1:100) {
#			all[i] <- kmeans(mydata,k)$tot.withinss
#		}
#		mn[k] <- min(all)
#	}
#	plot(2:15,mn[2:15],"b")
}

for (NUM in RANGE) {

print(NUM)

fit <- kmeans(mydata[,-REMOVE], NUM) # cluster solution

avg <- as.matrix(aggregate(mydata,by=list(fit$cluster),FUN=mean))
avg <- cbind(avg,as.vector(table(fit$cluster)))
namesx <- c("W IC cav", "W IC cha", "W IC sum", "Dist TM1-6", "Kink TM5", "Dist Na-Na", "Dist E428-bulk ion", "Contacts IL4-Nter", "W EC cav", "W EC cha", "W EC sum", "MinDist W84-P387", "MinDist W84-F391", "MinDist W84 Y394", "Ca Dist W84-P387", "Ca Dist W84-F391", "Ca Dist W84 Y394")
#names <- c("Group",names[-REMOVE])
names <- c("Group",namesx,"Num")
colnames(avg) <- names
avg <- avg[do.call(order, lapply((RANK+1), function(i) avg[, i])), ]
inp <- avg[,1]
out <- 1:NUM
fit2 <- fit$cluster
for (i in 1:NUM) {fit2[fit$cluster==inp[i]] <- out[i]}
avg[,1] <- 1:NUM

if (PLOT) {
	for (run in c(1:5,11:18)) {
		print(run)
		png(paste("cluster/plots/set",SET,"_num",NUM,"_run",run,".png",sep=""),width=1100,height=825,res=160)
		plot(1:n[run],fit2[nn[[run]]],ylim=c(1,NUM),ylab="Cluster",xlab="Frame",main=paste("Cluster distribution of set",SET,"with",NUM,"groups in run",run),cex=0.01)
		dev.off()
		write.table(as.vector(fit2[nn[[run]]]),paste("cluster/data/set",SET,"_num",NUM,"_run",run,".dat",sep=""),row.names=FALSE)
	}
}

A[[NUM]] <- avg

}

for (i in RANGE) {C[[i]] <- cor(A[[i]][,2:(ncol(A[[i]])-1)])}
A[[1]] <- as.data.frame(t(sapply(1:ncol(mydata), function(i) mean(mydata[,i]))))
colnames(A[[1]]) <- namesx[-REMOVE]
save(A,C,file=paste("cluster/data/set",SET,".Rdata",sep=""))

coef1 <- append(0,lapply(RANGE, function(x) sapply(1:ncol(C[[RANGE[1]]]), function(i) sum(abs(C[[x]][,i])))))
coef2 <- append(0,lapply(RANGE, function(x) sum(abs(C[[x]]))))

