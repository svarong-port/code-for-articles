# Code for Machine Learning With caret

## Install and load packages

## Install
install.packages("caret")
install.packages("mlbench")

## Load
library(caret)
library(mlbench)


# ---------------------------------------


# Load the dataset

## Load
data("BostonHousing")

## Preview
head(BostonHousing)

## View the structure
str(BostonHousing)


# ---------------------------------------


# Split the data

## Set seed for reproducibility
set.seed(888)

## Get train index
train_index <- createDataPartition(BostonHousing$medv, ## Specify the outcome
                                   p = 0.7, ## Set aside 70% for training set
                                   list = FALSE) ## Return as matrix

## Create training set
bt_train <- BostonHousing[train_index, ]

## Create test set
bt_test <- BostonHousing[-train_index, ]

## Check the results
cat("Rows in training set:", nrow(bt_train), "\n")
cat("Rows in test set:", nrow(bt_test))


# ---------------------------------------


# Preprocessing

## Learn preprocessing on training set
ppc <- preProcess(bt_train[, -14], ## Select all predictors
                  method = c("center", "scale"))  ## Centre and scale

## Apply preprocessing to training set
bt_train_processed <- predict(ppc,
                              bt_train[, -14])

## Combine the preprocessed training set with outcome
bt_train_processed <- cbind(bt_train_processed,
                            medv = bt_train$medv)

## Apply preprocessing to test set
bt_test_processed <- predict(ppc,
                             bt_test[, -14])

## Combine the preprocessed test set with outcome
bt_test_processed <- cbind(bt_test_processed,
                           medv = bt_test$medv)


# ---------------------------------------


# Train the model

## Define training control:
## use k-fold cross-validation where k = 5
trc <- trainControl(method = "cv",
                    number = 5)

## Define grid:
## set k as odd numbers between 3 and 13
grid <- data.frame(k = seq(from = 3,
                           to = 13,
                           by = 2))

## Train
knn_model <- train(medv ~ ., ## Specify the formula
                   data = bt_train_processed, ## Use training set
                   method = "knn", ## Use kknn engine
                   trControl = trc, ## Specify training control
                   tuneGrid = grid) ## Use grid to tune the model

## Print the model
knn_model


# ---------------------------------------


# Evaluate the model

## Make predictions
predictions <- predict(knn_model,
                       newdata = bt_test_processed)

## Calculate MAE
mae <- MAE(predictions,
           bt_test_processed$medv)

## Calculate RMSE
rmse <- RMSE(predictions,
             bt_test_processed$medv)

## Calculate R squared
r2 <- R2(predictions,
         bt_test_processed$medv)

## Combine the results
results <- data.frame(Model = "KNN",
                      MAE = round(mae, 2),
                      RMSE = round(rmse, 2),
                      R_Squared = round(r2, 2))

## Print the results
results