# Code for Machine Learning With tidymodels


# Install and load packages

## Install
install.packages("tidymodels")
install.packages("readr")

## Load
library(tidymodels)
library(readr)


# ---------------------------------------


# Load the dataset

## Define GitHub URL
url <- "https://raw.githubusercontent.com/svarong-port/code-for-articles/refs/heads/main/r/ml_with_tidymodels/bank.csv"

## Load the dataset with URL
bank <- read_delim(url,
                   delim = ";")

## Preview
head(bank)

## View structure
glimpse(bank)

## Check NA
colSums(is.na(bank))

## Convert character columns to factor

### Select character columns
bank <- bank |>
  mutate(across(where(is.character), as.factor))

### Check the results
glimpse(bank)


# ---------------------------------------


# Step 1. Split the data

## Set seed for reproducibility
set.seed(2025)

## Create row index for training set
bank_split <- initial_split(data = bank,
                            prop = 0.8,
                            strata = y)

## Create training set
bank_train <- training(bank_split)

## Create test set
bank_test <- testing(bank_split)


# ---------------------------------------


# Step 2. Prepare the recipe
bank_recipe <- recipe(y ~ .,
                      data = bank_train) |>
  
  ## Dummy code nomimal predictors
  step_dummy(all_nominal_predictors()) |>
  
  ## Normalise numeric variables
  step_normalize(all_numeric())


# ---------------------------------------


# Step 3. Prepare and bake

## Prepare the recipe
bank_recipe_prep <- prep(bank_recipe,
                         data = bank_train)

## Bake training set
bank_train_prep <- bake(bank_recipe_prep,
                        new_data = NULL)

## Bake test set
bank_test_prep <- bake(bank_recipe_prep,
                        new_data = bank_test)


# ---------------------------------------


# Step 4. Instantiate the model
ct_model <- decision_tree() |>

## Set engine
set_engine("rpart") |>
  
  ## Set mode
  set_mode("classification")


# ---------------------------------------


# Step 5. Train the model
ct_fit <- fit(ct_model,
              y ~ .,
              data = bank_train_prep)


# ---------------------------------------


# Step 6. Make predictions

## Predict outcomes
y_pred <- predict(ct_fit,
                  new_data = bank_test_prep,
                  type = "class")

## Get predicted probability
y_prob <- predict(ct_fit,
                  new_data = bank_test_prep,
                  type = "prob")

## Save the results
ct_results <- tibble(y = bank_test_prep$y,
                     y_pred = y_pred$.pred_class,
                     y_prob_yes = y_prob$.pred_yes,
                     y_prob_no = y_prob$.pred_no)


# ---------------------------------------


# Step 7. Evaluate the model

## Create a confusion matrix
cf <- conf_mat(ct_results,
               truth = y,
               estimate = y_pred)

## Print the confusion matrix
print(cf)

## Get metrics
cf |> summary()

## Define metric set
ct_metrics <- metric_set(accuracy,
                         sens,
                         spec)

## Compute the metrics
ct_metrics(ct_results,
           truth = y,
           estimate = y_pred)

## Plot ROC curve
roc_curve(ct_results,
          truth = y,
          y_prob_yes) |>
  autoplot()

## Compute ROC AUC
roc_auc(ct_results,
        truth = y,
        y_prob_yes)


# ---------------------------------------


# Step 8. Hyperparametre tuning