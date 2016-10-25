####
#### Career statistics for Major League Baseball players, as well as indicators for 
#### whether the players are in the Hall of Fame (HOF).
####

## Load data.
DTA <- read.csv("hof_data.csv")

## Extract a few offensive statistics (numerical variables).
num_vars <- c("H", "HR", "RBI", "AVG", "SLG", "OBP")
X <- as.matrix(DTA[, num_vars])

## Standardized variables.
X_st <- scale(X, center = TRUE, scale = TRUE)
DTA_st <- data.frame(DTA$HOF, X_st)
colnames(DTA_st) <- c("HOF", num_vars)

n <- nrow(DTA)
p <- ncol(X)
