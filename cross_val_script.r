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
thresh_seq = seq(from = .05, to = .95, by = .05)
n <- nrow(DTA)

pred = matrix(0, nrow = n, ncol = 19)
check = matrix(0, nrow = n, ncol = 19)

## Performs LOOCV 
for (j in 1:19) {
	for (i in 1:n) {

		test <- DTA_num[i,] # uses one element as a test
		train <- DTA_num[-i,] # uses remainder of data elements as training
	
		lda_out <- lda(HOF ~., data = train)
		lda_pred <- predict(lda_out, newdata = test)	
		
		# makes prediction based on current threshold value	
		if (lda_pred$posterior[1] > thresh_seq[j]) {
			pred[i,j] = 1
		}
		else {
			pred[i,j] = 0
		}
		
	}
}
	
## Checks the pred matrix to see which values
## were correctly predicted	
for (j in 1:19) {
predYesRight = 0 # reset number of HOF yes predicted correctly
predYesWrong = 0
predNoRight = 0
predNoWrong = 0

	for (i in 1:n) {
		if (pred[i,j] == 1) { # if yes was predicted
			if (DTA$HOF[i] == '1') { # compare to test case
				check[i,j] = 0 # marks prediction as correct
				predYesRight <- predYesRight + 1  # increase count
			}
			else {
				check[i,j] = 1 # marks prediction as incorrect
				predYesWrong <- predYesWrong + 1  
			}
		}
		if (pred[i,j] == 0) { # if no was predicted
			if (DTA$HOF[i] == '0') {
				check[i,j] = 0
				predNoRight <- predNoRight + 1  
			}
			else {
				check[i,j] = 1		
				predNoWrong <- predNoWrong + 1  				
			}
		}
	}
	
	sens[j] = predYesRight / (predYesRight + predYesWrong) # calculation for sensitivity 
	spec[j] = predNoWrong / (predNoWrong + predNoRight) # calculation for specificity 
	acc[j] = (sens[j] + spec[j]) / 2 # calculation for balanced accuracy
}

## can use sens, spec, and acc to display info