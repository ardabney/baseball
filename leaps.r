library(leaps)

## Load data
DTA <- read.csv("norm_hof.csv")


##y <- DTA[, c("HOF")]
###x <- DTA[, c(3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25)]
X = data.matrix(DTA[3:25))
y = data.matrix(DTA['HOF'])

analysis <- leaps(x, y, nbest = 1, method = "r2")
