# Code for Machine Learning With tidymodels (Regression – Workflow)


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


# Step 3. Instantiate the model
dt_mod <- decision_tree() |>
  
  ## Set the engine
  set_engine("rpart") |>
  
  ## Set the mode
  set_mode("regression")


# ---------------------------------------


# Step 4. Bundle the recipe and the model
dt_wfl <- workflow() |>
  
  ## Add recipe
  add_recipe(rec) |>
  
  ## Add model
  add_model(dt_mod)


# ---------------------------------------


# Step 5. Fit the model
dt_last_fit <- last_fit(dt_wfl,
                        split = bt_split,
                        metrics = metric_set(mae, rmse))


# ---------------------------------------


# Step 6. Evaluate the model

## Collect predictions
dt_predictions <- collect_predictions(dt_last_fit)

## Print predictions
dt_predictions


## Collect metrics
dt_metrics <- collect_metrics(dt_last_fit)

## Print metrics
dt_metrics