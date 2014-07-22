
rm(list=ls())

run <- 1
n <- 33095

a <- paste("../10watercounts/watercounts/long/set3/data/waterbasiccounts_DAT_IC_cav_run",run,".dat",sep="")
data <- read.table(t(a),nrows=n)
b <- paste("../10watercounts/watercounts/long/set3/data/waterbasiccounts_DAT_IC_cha_run",run,".dat",sep="")
data <- cbind(data,read.table(b,nrows=n))
data <- cbind(data,(read.table(a,nrows=n)+read.table(b,nrows=n)))
c <- paste("../7distances/cluster/data/tm16distance_DAT_run",run,".dat",sep="")
data <- cbind(data,read.table(c,nrows=n))
d <- paste("../7distances/kinks/data/kink_DAT_run",run,"_bend5_264.txt",sep="")
e <- paste("../7distances/kinks/data/kink_DAT_run",run,"_bend5_265.txt",sep="")
data <- cbind(data,(read.table(d,nrows=n)+read.table(e,nrows=n))/2)
f <- paste("../7distances/distances/data/distance_DAT_run",run,"_Na1_Na_nearest.dat",sep="")
data <- cbind(data,read.table(f,nrows=n))
g <- paste("../7distances/cluster/data/bulkions_DAT_run",run,".dat",sep="")
data <- cbind(data,read.table(g,nrows=n))
h <- paste("../7distances/cluster/data/contacts_DAT_run",run,".dat",sep="")
data <- cbind(data,read.table(h,nrows=n))

run <- 2
n <- 32788

a <- paste("../10watercounts/watercounts/long/set3/data/waterbasiccounts_DAT_IC_cav_run",run,".dat",sep="")
data2 <- read.table(t(a),nrows=n)
b <- paste("../10watercounts/watercounts/long/set3/data/waterbasiccounts_DAT_IC_cha_run",run,".dat",sep="")
data2 <- cbind(data2,read.table(b,nrows=n))
data2 <- cbind(data2,(read.table(a,nrows=n)+read.table(b,nrows=n)))
c <- paste("../7distances/cluster/data/tm16distance_DAT_run",run,".dat",sep="")
data2 <- cbind(data2,read.table(c,nrows=n))
d <- paste("../7distances/kinks/data/kink_DAT_run",run,"_bend5_264.txt",sep="")
e <- paste("../7distances/kinks/data/kink_DAT_run",run,"_bend5_265.txt",sep="")
data2 <- cbind(data2,(read.table(d,nrows=n)+read.table(e,nrows=n))/2)
f <- paste("../7distances/distances/data/distance_DAT_run",run,"_Na1_Na_nearest.dat",sep="")
data2 <- cbind(data2,read.table(f,nrows=n))
g <- paste("../7distances/cluster/data/bulkions_DAT_run",run,".dat",sep="")
data2 <- cbind(data2,read.table(g,nrows=n))
h <- paste("../7distances/cluster/data/contacts_DAT_run",run,".dat",sep="")
data2 <- cbind(data2,read.table(h,nrows=n))

data <- rbind(data,data2)
rm(data2)

run <- 3
n <- 40000

a <- paste("../10watercounts/watercounts/long/set3/data/waterbasiccounts_DAT_IC_cav_run",run,".dat",sep="")
data3 <- read.table(t(a),nrows=n)
b <- paste("../10watercounts/watercounts/long/set3/data/waterbasiccounts_DAT_IC_cha_run",run,".dat",sep="")
data3 <- cbind(data3,read.table(b,nrows=n))
data3 <- cbind(data3,(read.table(a,nrows=n)+read.table(b,nrows=n)))
c <- paste("../7distances/cluster/data/tm16distance_DAT_run",run,".dat",sep="")
data3 <- cbind(data3,read.table(c,nrows=n))
d <- paste("../7distances/kinks/data/kink_DAT_run",run,"_bend5_264.txt",sep="")
e <- paste("../7distances/kinks/data/kink_DAT_run",run,"_bend5_265.txt",sep="")
data3 <- cbind(data3,(read.table(d,nrows=n)+read.table(e,nrows=n))/2)
f <- paste("../7distances/distances/data/distance_DAT_run",run,"_Na1_Na_nearest.dat",sep="")
data3 <- cbind(data3,read.table(f,nrows=n))
g <- paste("../7distances/cluster/data/bulkions_DAT_run",run,".dat",sep="")
data3 <- cbind(data3,read.table(g,nrows=n))
h <- paste("../7distances/cluster/data/contacts_DAT_run",run,".dat",sep="")
data3 <- cbind(data3,read.table(h,nrows=n))

data <- rbind(data,data3)
rm(data3)

run <- 4
n <- 24418

a <- paste("../10watercounts/watercounts/long/set3/data/waterbasiccounts_DAT_IC_cav_run",run,".dat",sep="")
data4 <- read.table(t(a),nrows=n)
b <- paste("../10watercounts/watercounts/long/set3/data/waterbasiccounts_DAT_IC_cha_run",run,".dat",sep="")
data4 <- cbind(data4,read.table(b,nrows=n))
data4 <- cbind(data4,(read.table(a,nrows=n)+read.table(b,nrows=n)))
c <- paste("../7distances/cluster/data/tm16distance_DAT_run",run,".dat",sep="")
data4 <- cbind(data4,read.table(c,nrows=n))
d <- paste("../7distances/kinks/data/kink_DAT_run",run,"_bend5_264.txt",sep="")
e <- paste("../7distances/kinks/data/kink_DAT_run",run,"_bend5_265.txt",sep="")
data4 <- cbind(data4,(read.table(d,nrows=n)+read.table(e,nrows=n))/2)
f <- paste("../7distances/distances/data/distance_DAT_run",run,"_Na1_Na_nearest.dat",sep="")
data4 <- cbind(data4,read.table(f,nrows=n))
g <- paste("../7distances/cluster/data/bulkions_DAT_run",run,".dat",sep="")
data4 <- cbind(data4,read.table(g,nrows=n))
h <- paste("../7distances/cluster/data/contacts_DAT_run",run,".dat",sep="")
data4 <- cbind(data4,read.table(h,nrows=n))

data <- rbind(data,data4)
rm(data4)

rm(list=ls())

run <- 5
n <- 18561

a <- paste("../10watercounts/watercounts/long/set3/data/waterbasiccounts_DAT_IC_cav_run",run,".dat",sep="")
data5 <- read.table(t(a),nrows=n)
b <- paste("../10watercounts/watercounts/long/set3/data/waterbasiccounts_DAT_IC_cha_run",run,".dat",sep="")
data5 <- cbind(data5,read.table(b,nrows=n))
data5 <- cbind(data5,(read.table(a,nrows=n)+read.table(b,nrows=n)))
c <- paste("../7distances/cluster/data/tm16distance_DAT_run",run,".dat",sep="")
data5 <- cbind(data5,read.table(c,nrows=n))
d <- paste("../7distances/kinks/data/kink_DAT_run",run,"_bend5_264.txt",sep="")
e <- paste("../7distances/kinks/data/kink_DAT_run",run,"_bend5_265.txt",sep="")
data5 <- cbind(data5,(read.table(d,nrows=n)+read.table(e,nrows=n))/2)
f <- paste("../7distances/distances/data/distance_DAT_run",run,"_Na1_Na_nearest.dat",sep="")
data5 <- cbind(data5,read.table(f,nrows=n))
g <- paste("../7distances/cluster/data/bulkions_DAT_run",run,".dat",sep="")
data5 <- cbind(data5,read.table(g,nrows=n))
h <- paste("../7distances/cluster/data/contacts_DAT_run",run,".dat",sep="")
data5 <- cbind(data5,read.table(h,nrows=n))

data <- rbind(data,data5)
rm(data5)

dim(data)
