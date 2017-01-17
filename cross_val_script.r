library(MASS)

## Load data
DTA <- read.csv("hof_data.csv")

## Extract a few offensive statistics (numerical variables).
num_vars <- c("SP", "G", "H", "AB", "ASG", "R")
X <- as.matrix(DTA[, num_vars])

## Variable declarations
sens = NULL
spec = NULL
acc = NULL
test = NULL
train = NULL
thresh_seq = seq(from = .05, to = .95, by = .05)
n <- nrow(DTA)

## Performs LOOCV 
for (i in 1:n) {
	test <- as.matrix(DTA[i, c("HOF")])
	tr1 <- as.matrix(DTA[0:(i-1), c("HOF")])
	tr2 <- as.matrix(DTA[(i+1):1016, c("HOF")])
    train <- as.data.frame(merge(tr1, tr2, by = "row.names", all = TRUE))
	
    lda_out <- lda(HOF ~ X, data = train)
    lda_pred <- predict(lda_out, newdata = test)
	
	p_hat <- lda_pred$posterior
	
	for (j in 1:thresh_seq) {
		results <- as.matrix(table(lda_pred, DTA$HOF))
		
		sens[i] = results[1,1] / (results[1,1] + results[2,1])
		spec[i] = results[1,2] / (results[1,2] + results[2,2])
	    acc[i] = (sens[i] + spec[i]) / 2
	}
	
}

## can use sens, spec, and acc to display info



