#imports library for LDA
library(MASS)

## Load data
DTA <- read.csv("norm_hof_all_cp.csv")

## Variable declarations
sens = NULL # sensitivity 
spec = NULL # specificity
acc = NULL # accuracy
test = NULL # test data
train = NULL # training data

maxacc = NULL
index = 1

thresh_seq = seq(from = .05, to = .95, by = .05) # list of threshold values
n <- nrow(DTA) # stores number of rows in the data set
clm <- seq(from = 4, to = 26, by = 1) #stores the index of columns with numerical data
pred = matrix(0, nrow = n, ncol = 19) # matrix for storing predictions
check = matrix(0, nrow = n, ncol = 19) # matrix for storing the results of LOOCV

for (v in clm) { 

DTA_num <- as.matrix(DTA[, c(2,3, (v))]) # chooses indiviual variable to test

for (j in 1:19) { # makes a prediction for each threshold value
 # cycles through all data, using excluding one player each time to be used later for the accuracy check
	for (i in 1:n) {

		test <- as.data.frame(DTA_num[i,]) # uses one element as a test
		train <- as.data.frame(DTA_num[-i,]) # uses remainder of data elements as training
		
		ttest <- as.data.frame(t(test))
	
		# performs lda
		lda_out <- lda(HOF ~., data = train)
		lda_pred <- predict(lda_out, newdata = ttest)	
		
		# checks whether posterior probability from LDA is higher
		# than the current threshold value, then makes prediction
		if (lda_pred$posterior[1] > thresh_seq[j]) { 
			pred[i,j] = 1 # predicts as yes for HOF
		}
		else {
			pred[i,j] = 0 # predicts as no for HOF
		}
		
	}
}

## Performs LOOCV	
## Checks the pred matrix to see which values
## were correctly predicted	
for (j in 1:19) {
predYesRight = 0 # reset number of HOF yes predicted correctly
predYesWrong = 0 # reset number of HOF yes predicted incorrectly
predNoRight = 0 # reset number of HOF no predicted correctly
predNoWrong = 0 # reset number of HOF no predicted incorrectly

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
			if (DTA$HOF[i] == '0') { # compare to test case
				check[i,j] = 0 # marks prediction as correct
				predNoRight <- predNoRight + 1 # increase count
			}
			else {
				check[i,j] = 1 # marks prediction as incorrect		
				predNoWrong <- predNoWrong + 1  				
			}
		}
	}
	
	sens[j] = predYesRight / (predYesRight + predYesWrong) # calculation for sensitivity 
	spec[j] = predNoWrong / (predNoWrong + predNoRight) # calculation for specificity 
	acc[j] = (sens[j] + spec[j]) / 2 # calculation for balanced accuracy
}
	maxacc[index] = max(acc)
	index <- index + 1
	
}


#prints output to file
#sink('lda_cross_val.txt')
#cat("LDA: SP, G, H, AB, ASG, R\n")
#cat("threshold values:\n")
#print(thresh_seq)
#cat("sens:\n")
#print(sens)
#cat("spec:\n")
#print(spec)
#cat("acc:\n")
#print(acc)
#sink()

#AB,OBP 

###### removed "Hamner, Granny"

## can use sens, spec, and acc to display info