library(leaps)

## Load data
DTA <- read.csv("norm_hof.csv")

X = data.matrix(DTA[3:25))
y = data.matrix(DTA['HOF'])
analysis_rs <- regsubsets(x=x,y=y,data=DTA,nbest=1,method=c("exhaustive", "backward", "forward", "seqrep",matrix=TRUE, matrix.logical = FALSE,)
summary(analysis_rs,all.best=TRUE,matrix=TRUE,matrix.logical=FALSE)
