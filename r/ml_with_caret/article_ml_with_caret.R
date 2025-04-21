# Code for Machine Learning With caret


## Install and load packages

## Install
install.packages("caret")
install.packages("MASS")

## Load
library(caret)
library(MASS)


# ---------------------------------------


# Load the dataset

## Load
data(Boston)

## Preview
head(Boston)

## View the structure
str(Boston)


# ---------------------------------------


# Prepare the data for regression task

## Create a new dataset
bt <- Boston

## Convert `chas` to factor
bt$chas <- factor(bt$chas,
                  levels = c(1, 0),
                  labels = c("tract bounds river", "otherwise"))

## Check the result
str(bt)


# ---------------------------------------


## Pre-processing

## Remove near-zero variance (NZV) variables
nzv_vars <- nearZeroVar(bt[, -14])

## Print nzv_vars
if (length(nvz_vars) > 0) {
  
  ## Remove NZV variables
  bt <- bt[, !(names(bt) %in% nvz_vars)]
  
  ## Print a confirmation message
  print("Near-zero variance variables removed.")
} else {
  ## Print a help text
  print("No near-zero variance variables found.")
}

## Check the results
str(bt)


# ---------------------------------------


## Split the data

## Set seed for reproducibility
set.seed(2025)

## Get training rows
train_index <- createDataPartition(bt$medv,
                                   p = 0.8,
                                   list = FALSE)

## Create a training set
bt_train <- bt[train_index, ]

## Create a test set
bt_test  <- bt[-train_index, ]


# ---------------------------------------


## Train a random forest

## Set seed for reproducibility
set.seed(2025)

## Train
dt_model <- train(medv ~ .,
                  data = bt_train,
                  method = "ranger",
                  trControl = trainControl(method = "cv",
                                           number = 5,
                                           verboseIter = TRUE))


# ---------------------------------------


## Evaluate the model

## Predict on test data
predictions <- predict(dt_model,
                       newdata = bt_test)

## Evaluate performance
init_mod_results <- postResample(pred = predictions,
                                 obs = bt_test$medv)

## Print the results
init_mod_results


# ---------------------------------------


## Tune the model

## Define tune grid
tune_grid <- expand.grid(mtry = c(4, 6, 8, 10),
                         min.node.size = c(3, 5, 7),
                         splitrule = c("variance", "extratrees"))

## Set seed for reproducibility
set.seed(2025)

## Train
dt_model_tuned <- train(medv ~ .,
                        data = bt_train,
                        method = "ranger",
                        trControl = trainControl(method = "cv",
                                                 number = 5,
                                                 verboseIter = TRUE),
                        tuneGrid = tune_grid,
                        numtree = 1000)


# ---------------------------------------


## Evaluate the tuned model

## Predict on test data
pred_new <- predict(dt_model_tuned,
                    newdata = bt_test)

## Evaluate performance
tuned_mod_results <- postResample(pred = pred_new,
                                  obs = bt_test$medv)

## Print the results
tuned_mod_results

## Compare the models
bind_rows(initial = init_mod_results,
          tuned = tuned_mod_results,
          .id = "Model")