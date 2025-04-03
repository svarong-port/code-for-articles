# Code for Machine Learning With tidymodels (Regression - Normal Flow)


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

## Glimpse
glimpse(Boston)


# ---------------------------------------


# Prepare the data for regression task

## Create a new dataset
bt <- Boston

## Convert `chas` to factor
bt$chas <- factor(bt$chas,
                  levels = c(1, 0),
                  labels = c("tract bounds river", "otherwise"))

## Check the result
glimpse(bt)


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


# ---


# Step 2. Define the recipe
bt_rec <- recipe(medv ~ .,
                 data = bt_train) |>
  
  ## Remove near-zero variance predictors
  step_nzv(all_numeric_predictors()) |>
  
  ## Handle multicollinearity
  step_corr(all_numeric_predictors(),
            threshold = 0.8) |>
  
  ## Dummy-code nominal predictors
  step_dummy(all_nominal_predictors()) |>
  
  ## Normalise the predictors
  step_normalize(all_numeric_predictors()) |>
  
  ## Log-transform the outcome
  step_log(all_outcomes())


# ---


# Step 3. Prepare and bake

## Prepare
bt_rec_prep <- prep(bt_rec,
                    data = bt_train)

## Bake the training set
bt_train_baked <- bake(bt_rec_prep,
                       new_data = NULL)

## Bake the test set
bt_test_baked <- bake(bt_rec_prep,
                      new_data = bt_test)


# ---


# Step 4. Instantiate the model
dt_model <- decision_tree() |>
  
  ## Set the engine
  set_engine("rpart") |>
  
  # Set the mode
  set_mode("regression")


# ---


# Step 5. Fit the model
dt_model_fit <- fit(dt_model,
                    medv ~ .,
                    data = bt_train_baked)


# ---


# Step 6. Make predictions

## Make predictions
dt_results <- predict(dt_model_fit,
                      new_data = bt_test_baked,
                      type = "numeric") |>
  bind_cols(medv = bt_test_baked$medv)

## Print the results
dt_results


# ---


# Step 7. Evaluate the model performance

## Define a custom metrics
dt_metrics <- metric_set(mae,
                         rmse)

## Evaluate the model
dt_eva_results <- dt_metrics(dt_results,
                             truth = medv,
                             estimate = .pred)

## Print the results
dt_eva_results


# ---


# Step 8. Hyperparametre tuning

## Define the hyperparametres
dt_tune <- decision_tree(cost_complexity = tune(),
                         tree_depth = tune(),
                         min_n = tune()) |>
  
  ### Set engine
  set_engine("rpart") |>
  
  ### Set mode
  set_mode("regression")

## Define cross validation
dt_cv <- vfold_cv(bt_train_baked,
                  v = 5,
                  strata = medv)


## Define grid
dt_grid <- grid_random(cost_complexity(range = c(-5, 0),
                                       trans = log10_trans()),
                       tree_depth(range = c(1, 20)),
                       min_n(range = c(2, 50)),
                       size = 20)

## Tune the model
dt_tune_results <- tune_grid(dt_tune,
                             medv ~ .,
                             resamples = dt_cv,
                             grid = dt_grid,
                             metrics = dt_metrics)


# ---


# Step 9. Select the best model

## Show the 5 best models
show_best(dt_tune_results,
          metric = "mae",
          n = 5)

## Select the best model
dt_best_params <- select_best(dt_tune_results,
                              metric = "mae")


# ---


# Step 10. Finalise the best model
dt_best_model <- finalize_model(dt_tune,
                                dt_best_params)


# ---


# Step 11. Fit and evaluate the best model

## Fit the model
dt_best_fit <- fit(dt_best_model,
                   medv ~ .,
                   data = bt_train_baked)

## Make predictions
dt_best_results <- predict(dt_best_fit,
                           new_data = bt_test_baked) |>
  bind_cols(medv = bt_test_baked$medv)

## Evaluate the model
dt_best_eva_results <- dt_metrics(dt_best_results,
                                  truth = medv,
                                  estimate = .pred)

## Print the results
dt_best_eva_results


# ---


# Step 12. Compare the models
bind_rows(initial_model = dt_eva_results,
          tuned_model = dt_best_eva_results,
          .id = "model") |>
  tidyr::pivot_wider(names_from = .metric,
                     values_from = .estimate)