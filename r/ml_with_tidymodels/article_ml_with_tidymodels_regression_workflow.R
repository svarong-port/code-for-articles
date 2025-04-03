# Code for Machine Learning With tidymodels (Regression - Workflow)


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


# Step 3. Instantiate the model
dt_model <- decision_tree() |>
  
  ## Set the engine
  set_engine("rpart") |>
  
  ## Set the mode
  set_mode("regression")


# ---


# Step 4. Bundle the recipe and the model
bt_wfl <- workflow() |>
  
  ## Add recipe
  add_recipe(bt_rec) |>
  
  ## Add model
  add_model(dt_model)


# ---


# Step 5. Fit the model
dt_last_fit <- last_fit(bt_wfl,
                        split = bt_split,
                        metrics = metric_set(mae, rmse))


# ---


# Step 6. Make predictions

## Collect predictions
predictions <- collect_predictions(dt_last_fit)

## Print predictions
predictions


# ---


# Step 7. Evaluate the model performance

## Collect metrics
metrics <- collect_metrics(dt_last_fit)

## Print metrics
metrics


# ---


# Step 8. Hyperparametre tuning

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
  add_recipe(bt_rec) |>
  
  ### Add model
  add_model(dt_model_tune)

## Cross-validation for tuning
dt_cv <- vfold_cv(bt_train, v = 5, strata = medv)

## Define the grid for tuning
dt_grid <- grid_random(cost_complexity(range = c(-5, 0), trans = log10_trans()),
                       tree_depth(range = c(1, 20)),
                       min_n(range = c(2, 50)),
                       size = 20)

## Tune the model
dt_tune_results <- tune_grid(bt_wfl_tune,
                             resamples = dt_cv,
                             grid = dt_grid,
                             metrics = metric_set(mae, rmse))


# ---


# Step 9. Select and fit the best model

## Show the best model
show_best(dt_tune_results,
          metric = "mae",
          n = 5)

## Finalise the best workflow
dt_wkl_best <- finalize_workflow(bt_wfl_tune,
                                 dt_best_params)

## Fit the best model
dt_best_fit <- last_fit(dt_wkl_best,
                        split = bt_split,
                        metrics = metric_set(mae, rmse))


# ---


# Step 10. Collect predictions and metrics

## Collect predictions
predictions_best <- collect_predictions(dt_best_fit)

## Print predictions
predictions_best


# ---


# Step 7. Evaluate the model performance

## Collect metrics
metrics_best <- collect_metrics(dt_best_fit)

## Print metrics
metrics_best


# ---


# Step 8. Compare the model
bind_rows(initial_model = metrics,
          tuned_model = metrics_best,
          .id = "model") |>
  tidyr::pivot_wider(names_from = .metric,
                     values_from = .estimate)