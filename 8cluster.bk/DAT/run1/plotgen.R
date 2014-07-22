args <- commandArgs(TRUE)
prot<-args[1]
run<-args[2]

source('rmsdplot.R')

rmsdplot(prot,run)
