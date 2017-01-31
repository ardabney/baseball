library(MASS)

## Load data
DTA <- read.csv("hof_data.csv")

## Extract a few offensive statistics (numerical variables).
num_vars <- c("SP", "G", "H", "AB", "ASG", "R")
X <- as.matrix(DTA[, num_vars])
DTA_num <- DTA[, c("HOF", num_vars)]

## Variable declarations
sens = NULL
spec = NULL
acc = NULL
test = NULL
train = NULL
posts = NULL
thresh_seq = seq(from = .05, to = .95, by = .05)
n <- nrow(DTA)

## Performs LOOCV 
for (i in 1:n) {

	test <- DTA_num[i,]
	##tr1 <- as.matrix(DTA_num[(1:(i-1)),])
	##tr2 <- as.matrix(DTA_num[((i+1):n),])
	train <- DTA_num[-i, ]
	
    lda_out <- lda(HOF ~ ., data = train)
    lda_pred <- predict(lda_out, newdata = test)
	
	posts[i] = lda_pred$posterior
	
	for (j in 1:19) {
		if (lda_pred$posterior > thresh_seq[j]) {
			predYesRight <- predYesRight + 1   
			##results <- as.matrix(table(lda_pred, DTA$HOF))
			
			if (test$HOF[i] == 'N') {
				predYesWrong <- predYesWrong + 1  			
			}
		
		}
		else {
			predNoRight <- predNoRight + 1 
			
			if (test$HOF[i] == 'Y') {
				predNoWrong <- predNoWrong + 1  			
			}
		
		}
		
	}
	
	sens[i] = predYesRight / (predYesRight + predYesWrong)
	spec[i] = predNoWrong / (predNoWrong + predNoRight)
	acc[i] = (sens[i] + spec[i]) / 2
	
}

## can use sens, spec, and acc to display info