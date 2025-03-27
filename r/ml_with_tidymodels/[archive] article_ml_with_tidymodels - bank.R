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
github_raw <- "https://raw.githubusercontent.com/svarong-port/code-for-articles/refs/heads/main/r/ml_with_tidymodels/bank.csv"

## Load the dataset with URL
bank <- read_delim(github_raw,
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
ct_results <- tibble(actual = bank_test_prep$y,
                     predicted = y_pred$.pred_class,
                     prob_yes = y_prob$.pred_yes,
                     prob_no = y_prob$.pred_no)

## View the results
print(ct_results)


# ---------------------------------------


# Step 7. Evaluate the model

## Create a confusion matrix
cm <- conf_mat(ct_results,
               truth = actual,
               estimate = predicted)

## Print the confusion matrix
print(cm)

## Get metrics
cm |> summary()

## Define metric set
ct_metrics <- metric_set(accuracy,
                         sens,
                         yardstick::spec)

## Compute the metrics
ct_metrics(ct_results,
           truth = actual,
           estimate = predicted)

## Plot ROC curve
roc_curve(ct_results,
          truth = actual,
          prob_yes) |>
  autoplot()

## Compute ROC AUC
roc_auc(ct_results,
        truth = actual,
        prob_yes)


# ---------------------------------------


# Step 8. Hyperparametre tuning

## Define the parametres for tuning
ct_model_tune <- decision_tree(cost_complexity = tune(),
                               tree_depth = tune(),
                               min_n = tune()) |>
  set_engine("rpart") |>
  set_mode("classification")

## Define the parametre grid
ct_grid <- grid_random(cost_complexity(range = c(-5, 0), trans = log10_trans()),
                       tree_depth(range = c(1, 20)),
                       min_n(range = c(2, 50)),
                       size = 20 )

## Define v-fold cross validation (CV)

### Set seed for reproducibility
set.seed(2025)

## Create v-fold CV
cv_folds <- vfold_cv(bank_train_prep,
                     v = 5,
                     strata = y)


## Create a workflow
ct_wfl <- workflow() |>
  add_recipe(bank_recipe_prep) |>
  add_model(ct_model_tune)

## Tune the model
tune_results <- tune_grid(ct_wfl,
                          resamples = cv_folds,
                          grid = ct_grid,
                          metrics = metric_set(roc_auc))


# ---------------------------------------


# Step 9. Select the best model

## Show the parametre combinations
tune_results |> show_best(metric = "roc_auc",
                          n = 5)

## Select the best combination
best_params <- select_best(tune_results,
                           metric = "roc_auc")

## Select the best parametre combination
ct_best_model <- finalize_model(ct_model_tune,
                                best_params)


# ---------------------------------------


# Step 10. Fit the best model
ct_best_fit <- fit(ct_best_model,
                   y ~ .,
                   data = bank_train_prep)


# ---------------------------------------


# Step 11. Make predictions

## Make predictions
y_pred_best <- predict(ct_best_fit,
                       new_data = bank_test_prep,
                       type = "class")

## Get predicted probabilities
y_prob_best <- predict(ct_best_fit,
                       new_data = bank_test_prep,
                       type = "prob")

## Save the results
ct_best_results <- tibble(actual = bank_test_prep$y,
                          predicted = y_pred_best$.pred_class,
                          prob_yes = y_prob_best$.pred_yes,
                          prob_no = y_prob_best$.pred_no)


# ---------------------------------------


# Step 12. Evaluate the model

## Create a confusion matrix
cm_best <- conf_mat(ct_best_results,
                    truth = actual,
                    estimate = predicted)

## View the confusion matrix
print(cm_best)

## Get metrics
summary(cm_best)

## Plot ROC curve
roc_curve(ct_best_results,
          truth = actual,
          prob_yes) |>
  autoplot()

## Compute ROC AUC
roc_auc(ct_best_results,
        truth = actual,
        prob_yes)