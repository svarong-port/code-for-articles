# Code for Boosted Tree With xgboost Package


# Install and load packages

## Install
install.packages("xgboost")
install.packages("ggplot2")

## Load
library(xgboost)
library(ggplot2)


# --------------------------------------------------


# Load the dataset

## Load
data(mpg)

## Preview
head(mpg)

## View the tructure
str(mpg)


# --------------------------------------------------


# Prepare the dataset

## Convert character columns to factor

## Get character columns
chr_cols <- c("manufacturer",
              "model",
              "trans",
              "drv",
              "fl",
              "class")

## For-loop through the character columns
for (col in chr_cols) {
  mpg[[col]] <- as.factor(mpg[[col]])
}

## Check the results
str(mpg)


# --------------------------------------------------


# Separate the features from the outcome

## Get the features
x <- mpg[, !names(mpg) %in% "hwy"]

## One-hot encode the features
x <- model.matrix(~ . - 1,
                  data = x)

## Get the outcome
y <- mpg$hwy


# --------------------------------------------------


# Split the data

## Set seed for reproducibility
set.seed(360)

## Get training index
train_index <- sample(1:nrow(x),
                      nrow(x) * 0.8)

## Create x, y train
x_train <- x[train_index, ]
y_train <- y[train_index]

## Create x, y test
x_test <- x[-train_index, ]
y_test <- y[-train_index]

## Check the results
cat("TRAIN SET", "\n")
cat("1. Data in x_train:", nrow(x_train), "\n")
cat("2. Data in y_train:", length(y_train), "\n")
cat("---", "\n", "TEST SET", "\n")
cat("1. Data in x_test:", nrow(x_test), "\n")
cat("2. Data in y_test:", length(y_test), "\n")


# --------------------------------------------------


# Convert to DMatrix

## Training set
train_set <- xgb.DMatrix(data = x_train,
                         label = y_train)

## Test set
test_set <- xgb.DMatrix(data = x_test,
                        label = y_test)

## Check the results
cat("TRAIN SET:", "\n")
train_set
cat("---", "\n", "TEST SET", "\n")
test_set


# --------------------------------------------------


# Train the model

## Set hyperparametres
hp <- list(objective = "reg:squarederror",
           eta = 0.1,
           max_depth = 4,
           eval_metric = c("rmse",
                           "mae"))

## Train
xgb_model <- xgb.train(params = hp,
                       data = train_set,
                       nrounds = 50,
                       watchlist = list(train = train_set,
                                        test = test_set),
                       verbose = 1)

## Print the model
xgb_model


# --------------------------------------------------


# Evaluate the model

## Make predictions
y_pred <- predict(xgb_model,
                  newdata = x_test)

## Compare predictions to actual outcomes
results <- data.frame(actual = y_test,
                      predicted = y_pred,
                      error = y_test - y_pred)

## Preview the results
head(results, 10)

## Calculate MAE
mae <- mean(abs(results$error))

## Calculate RMSE
rmse <- sqrt(mean((results$error)^2))

## Calculate R squared
ss_res <- sum((results$error)^2)
ss_tot <- sum((results$actual - mean(results$actual))^2)
r_squared <- 1 - (ss_res / ss_tot)

## Print the results
cat("MAE:", round(mae, 2), "\n")
cat("RMSE:", round(rmse, 2), "\n")
cat("R squared:", round(r_squared, 2), "\n")