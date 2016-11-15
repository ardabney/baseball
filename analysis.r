####
#### Career statistics for Major League Baseball players, as well as indicators for 
#### whether the players are in the Hall of Fame (HOF). 
####

## Load data.
source("load_data.r")

## Side-by-side boxplot and two-sample t-test for 'H' variable, comparing HOF = N to 
## HOF = Y.
with(DTA, boxplot(H ~ HOF))
with(DTA, t.test(H[HOF == "N"], H[HOF == "Y"]))

##
## Linear discriminant analysis.
##

library(MASS)

lda_out <- lda(HOF ~ H + HR + RBI + AVG + SLG + OBP, data = DTA)
lda_pred <- predict(lda_out, newdata = DTA)$class
table(lda_pred, DTA$HOF)


