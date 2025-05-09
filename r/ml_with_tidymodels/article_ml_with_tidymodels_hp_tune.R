# Code for Machine Learning With tidymodels (Regression – Hyperparametre Tuning)


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


# Step 3. Hyperparametre tuning

## Define the tuning parameters
dt_model_tune <- decision_tree(cost_complexity = tune(),
                               tree_depth = tune(),
                               min_n = tune()) |>
  
  ### Set engine
  set_engine("rpart") |>
  
  ### Set mode
  set_mode("regression")


## Define the workflow with tuning
bt_wfl_tune <- workflow() |>
  
  ### Add recipe
  add_recipe(rec) |>
  
  ### Add model
  add_model(dt_model_tune)


## Set k-fold cross-validation for tuning
hpt_cv <- vfold_cv(bt_train,
                   v = 5,
                   strata = medv)


## Set seed for reproducibility
set.seed(2025)

## Define the grid for tuning
hpt_grid <- grid_random(cost_complexity(range = c(-5, 0), trans = log10_trans()),
                        tree_depth(range = c(1, 20)),
                        min_n(range = c(2, 50)),
                        size = 20)


## Define metrics
hpt_metrics = metric_set(mae,
                         rmse)


## Tune the model
dt_tune_results <- tune_grid(bt_wfl_tune,
                             resamples = hpt_cv,
                             grid = hpt_grid,
                             metrics = hpt_metrics)


# ---------------------------------------


# Step 5. Select and fit the best model

## Show the best model
show_best(dt_tune_results,
          metric = "rmse",
          n = 5)

## Select the best model
dt_best_params <- select_best(dt_tune_results,
                              metric = "rmse")

## Finalise the best workflow
dt_wkl_best <- finalize_workflow(bt_wfl_tune,
                                 dt_best_params)

## Fit the best model
dt_best_fit <- last_fit(dt_wkl_best,
                        split = bt_split,
                        metrics = metric_set(mae, rmse))


# ---------------------------------------


# Step 6. Collect predictions and metrics

## Collect predictions
predictions_best <- collect_predictions(dt_best_fit)

## Print predictions
predictions_best


# ---------------------------------------


# Step 7. Evaluate the model performance

## Collect metrics
metrics_best <- collect_metrics(dt_best_fit)

## Print metrics
metrics_best