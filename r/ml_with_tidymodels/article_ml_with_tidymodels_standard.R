# Code for Machine Learning With tidymodels (Regression – Standard Flow)


# Install and load packages

## Install
install.packages("tidymodels")
install.packages("MASS")

## Load
library(tidymodels)
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


# Step 1. Split the data

## Set seed for reproducibility
set.seed(2025)

## Define the training set index
bt_split <- initial_split(data = bt,
                          prop = 0.8,
                          strata = medv)

## Create the training set
bt_train <- training(bt_split)

## Create the test set
bt_test <- testing(bt_split)


# ---------------------------------------


# Step 2. Create a recipe
rec <- recipe(medv ~ .,
              data = bt_train) |>
  
  ## Remove near-zero variance predictors
  step_nzv(all_numeric_predictors()) |>
  
  ## Handle multicollinearity
  step_corr(all_numeric_predictors(),
            threshold = 0.8)


# ---------------------------------------


# Step 3. Prepare and bake

## Prepare
rec_prep <- prep(rec,
                 data = bt_train)

## Bake the training set
bt_train_baked <- bake(rec_prep,
                       new_data = NULL)

## Bake the test set
bt_test_baked <- bake(rec_prep,
                      new_data = bt_test)


# ---------------------------------------


# Step 4. Instantiate the model
dt_mod <- decision_tree() |>
  
  ## Set the engine
  set_engine("rpart") |>
  
  ## Set the mode
  set_mode("regression")


# ---------------------------------------


# Step 5. Fit the model
dt_mod_fit <- fit(dt_mod,
                  medv ~ .,
                  data = bt_train_baked)


# ---------------------------------------


# Step 6. Make predictions

## Make predictions
dt_results <- predict(dt_mod_fit,
                      new_data = bt_test_baked,
                      type = "numeric") |>
  bind_cols(actual = bt_test_baked$medv)

## Print the results
dt_results


# ---------------------------------------


# Step 7. Evaluate the model

## Calculate MAE
dt_mae <- mae(dt_results,
              truth = actual,
              estimate = .pred)

## Calculate RMSE
dt_rmse <- rmse(dt_results,
                truth = actual,
                estimate = .pred)

## Print MAE and RMSE
cat("MAE:", "\n")
dt_mae
cat("------------------------------------------", "\n")
cat("RMSE:", "\n")
dt_rmse


cat("MAE:", round(dt_mae$.estimate, 2), "\n")
cat("RMSE:", round(dt_rmse$.estimate, 2), "\n")

## Define a custom metrics
dt_metrics <- metric_set(mae,
                         rmse)

## Evaluate the model
dt_eva_results <- dt_metrics(dt_results,
                             truth = actual,
                             estimate = .pred)

## Print the results
dt_eva_results