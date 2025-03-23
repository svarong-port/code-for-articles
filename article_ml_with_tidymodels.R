# Code for Machine Learning With tidymodels


# Install and load the packages

## Install
install.packages("tidymodels")
install.packages("MASS")
install.packages("dplyr")

## Load
library(tidymodels)
library(MASS)
library(dplyr)


# ---------------------------------------


# Load the dataset

## Load
data(Boston)

## Preview
head(Boston)

## View the structure
str(Boston)


# ---------------------------------------


# Create datasets for regression and classification

## Convert `chas` to factor
Boston$chas <- factor(Boston$chas,
                      levels = c(1, 0),
                      labels = c("tract bounds river", "otherwise"))

## Check the result
str(Boston)


# ---------------------------------------


# Regression

# Step 0. Create a dataset for regression

## Regression dataset
bt_reg <- tibble(Boston)


## Step 1. Split the data

### Set seed for reproducibility
set.seed(2500)

### Define the split
bt_reg_split <- initial_split(bt_reg,
                              prop = 0.8,
                              strata = medv)

### Create training and test sets
bt_reg_train <- training(bt_reg_split)
bt_reg_test <- testing(bt_reg_split)


## Step 2. Specify the recipe
bt_reg_rec <- recipe(medv ~ .,
                     data = bt_reg_train) |>
  
  ### Normalise the data
  step_normalize(all_numeric_predictors()) |>
  
  ### Remove near-zero variance predictors
  step_nzv(all_numeric_predictors()) |>
  
  ### Handle multicollinearity
  step_corr(all_numeric_predictors(),
            threshold = 0.8) |>
  
  ### Dummy-code nominal variable
  step_dummy(all_nominal())



## Step 4. Prepare and bake the data

### Prepare the recipe
bt_reg_rec_prep <- prep(bt_reg_rec)

### Prepare the training set
bt_reg_train_prep <- bake(bt_reg_rec_prep,
                          new_data = NULL)

### Prepare the test set
bt_reg_test_prep <- bake(bt_reg_rec_prep,
                          new_data = bt_reg_test)


## Step 5. Instantiate a linear regression model
lm_model <- linear_reg() |>
  set_engine("lm") |>
  set_mode("regression")


## Step 6. Fit the model

### Fit
lm_fit <- fit(lm_model,
              medv ~ .,
              data = bt_reg_train_prep)

### See summary
tidy(lm_fit)


## Step 7. Make predictions

### Predict
medv_pred <- predict(lm_fit,
                     new_data = bt_reg_test_prep)

### Save the results
bt_reg_results <- tibble(medv = bt_reg_test_prep$medv,
                         medv_pred = medv_pred$.pred)
  

### Step 8. Evaluate the performance

### Compute RMSE
rmse(bt_reg_results,
     truth = medv,
     estimate = medv_pred)

### Compute R squared
rsq(bt_reg_results,
    truth = medv,
    estimate = medv_pred)


# ---------------------------------------


# Classification (logistic regression)

# Step 0. Create a dataset for classification

## Create a new dataset
bt_class <- Boston |>
  
  ### Create the new column
  mutate(medv_level = if_else(medv > quantile(medv, 0.50),
                              "high",
                              "low"))

## Convert `medv_level` to factor
bt_class$medv_level <- factor(bt_class$medv_level,
                              levels = c("high", "low"))

## Drop `medv`
bt_class$medv <- NULL

## Check the results
str(bt_class)


# Step 1. Split the data

### Set seed for reproducibility
set.seed(2500)

### Define the split
bt_class_split <- initial_split(bt_class,
                                prop = 0.8,
                                strata = medv_level)

### Create training and test sets
bt_class_train <- training(bt_class_split)
bt_class_test <- testing(bt_class_split)


## Step 2. Specify the recipe
bt_class_rec <- recipe(medv_level ~ .,
                       data = bt_class_train) |>
  
  ### Normalise the data
  step_normalize(all_numeric_predictors()) |>
  
  ### Remove near-zero variance predictors
  step_nzv(all_numeric_predictors()) |>
  
  ### Handle multicollinearity
  step_corr(all_numeric_predictors(),
            threshold = 0.8) |>
  
  ### Dummy-code nominal variable
  step_dummy(all_nominal(), -all_outcomes())


## Step 4. Prepare and bake the data

### Prepare the recipe
bt_class_rec_prep <- prep(bt_class_rec)

### Prepare the training set
bt_class_train_prep <- bake(bt_class_rec_prep,
                            new_data = NULL)

### Prepare the test set
bt_class_test_prep <- bake(bt_class_rec_prep,
                           new_data = bt_class_test)


## Step 5. Instantiate a linear regression model
log_reg_model <- logistic_reg() |>
  set_engine("glm") |>
  set_mode("classification")


## Step 6. Fit the model

### Fit
log_reg_fit <- fit(log_reg_model,
                   medv_level ~ .,
                   data = bt_class_train_prep)


## Step 7. Make predictions

### Predict the outcome
medv_level_pred <- predict(log_reg_fit,
                           new_data = bt_class_test_prep,
                           type = "class")

### Get predicted probability
medv_level_prob <- predict(log_reg_fit,
                           new_data = bt_class_test_prep,
                           type = "prob")

### Save the results
bt_class_results <- tibble(medv_level = bt_class_test_prep$medv_level,
                           medv_level_pred = medv_level_pred$.pred_class,
                           medv_level_prob_low = medv_level_prob$.pred_low,
                           medv_level_prob_high = medv_level_prob$.pred_high
)

### Step 8. Evaluate the performance

### Create a confusion matrix
conf_mat(bt_class_results,
         medv_level,
         medv_level_pred)

### Customise metrics
class_metrics <- metric_set(accuracy,
                            sens,
                            spec)

### Get metrics
class_metrics(bt_class_results,
              truth = medv_level,
              estimate = medv_level_pred)

### ROC curve
roc_curve(bt_class_results,
          truth = medv_level,
          medv_level_prob_high) |>
  autoplot()

### ROC AUC
roc_auc(bt_class_results,
        truth = medv_level,
        medv_level_prob_high)