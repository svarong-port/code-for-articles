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
train_index <- createDataPartition(BostonHousing$medv,
                                   
                                   ## Set aside 70% for training set
                                   p = 0.7,
                                   
                                   ## Return as matrix
                                   list = FALSE)

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
ppc <- preProcess(bt_train[, -14],
                  
                  ## Centre and scale
                  method = c("center",
                             "scale"))

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

## Define training control
trc <- trainControl(method= "cv",
                    number = 5)

## Train
knn_model <- train(medv ~ .,
                   
                   ## Use training set
                   data = bt_train_processed,
                   
                   ## Use knn engine
                   method = "knn",
                   
                   ## Specify training control
                   trControl = trc,
                   
                   ## Set tune length to 10
                   tuneLength = 10)

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
results <- data.frame(MAE = round(mae, 2),
                      RMSE = round(rmse, 2),
                      R_Squared = round(r2, 2))

## Print the results
results