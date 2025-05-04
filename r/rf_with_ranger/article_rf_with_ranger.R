# Code for Random Forest With ranger Package

# Install and load

## Install
install.packages("ranger")
install.packages("vip")
install.packages("ggplot2")

## Load
library(ranger)
library(vip)
library(ggplot2)


# ------------------------------------------------------------------


# Load the dataset

## Load
data(mpg)

## Preview
head(mpg)

## View the structure
str(mpg)


# ------------------------------------------------------------------


# Prepare the dataset

## Convert character columns to factor

## Get character columns
chr_cols <- c("manufacturer", "model",
              "trans", "drv",
              "fl", "class")

## For-loop through the character columns
for (col in chr_cols) {
  mpg[[col]] <- as.factor(mpg[[col]])
}

## Check the results
str(mpg)


# ------------------------------------------------------------------


# Split the data

## Set seed for reproducibility
set.seed(123)

## Get training rows
train_rows <- sample(nrow(mpg),
                     nrow(mpg) * 0.7)

## Create a training set
train <- mpg[train_rows, ]

## Create a test set
test <- mpg[-train_rows, ]


# ------------------------------------------------------------------


# Initial random forest model

## Set seed for reproducibility
set.seed(123)

## Train the model
rf_model <- ranger(hwy ~ .,
                   data = train)

## Print the model
rf_model


## Evaluate the model

## Make predictions
preds <- predict(rf_model,
                 data = test)$predictions

## Get errors
errors <- test$hwy - preds

## Calculate MAE
mae <- mean(abs(errors))

## Calculate RMSE
rmse <- sqrt(mean(errors^2))

## Calculate R squared
r_sq <- 1 - (sum((errors)^2) / sum((test$hwy - mean(test$hwy))^2))

## Print the results
cat("Initial model MAE:", round(mae, 2), "\n")
cat("Initial model RMSE:", round(rmse, 2), "\n")
cat("Initial model R squared:", round(r_sq, 2), "\n")


## Get variabe importance
vip(rf_model)  +
  
  ## Add title and labels
  labs(title = "Variable Importance - Initial Random Forest Model",
       x = "Variables",
       y = "Importance") +
  
  ## Set theme to minimal
  theme_minimal()


# ------------------------------------------------------------------


# Hyperparametre tuning

## # Define hyperparametres
ntree_vals <- c(300, 500, 700)
mtry_vals <- 2:5
min_node_vals <- c(1, 5, 10)

## Create a hyperparametre grid
grid <- expand.grid(num.trees = ntree_vals,
                    mtry = mtry_vals,
                    min.node.size = min_node_vals)

## Instantiate an empty data frame
hpt_results <- data.frame()

## For-loop through the hyperparametre grid
for (i in 1:nrow(grid)) {
  
  ## Get the combination
  params <- grid[i, ]
  
  ## Set seed for reproducibility
  set.seed(123)
  
  ## Fit the model
  model <- ranger(hwy ~ .,
                  data = train,
                  num.trees = params$num.trees,
                  mtry = params$mtry,
                  min.node.size = params$min.node.size)
  
  ## Make predictions
  preds <- predict(model,
                   data = test)$predictions
  
  ## Get errors
  errors <- test$hwy - preds
  
  ## Calculate MAE
  mae <- mean(abs(errors))
  
  ## Calculate RMSE
  rmse <- sqrt(mean(errors^2))
  
  ## Store the results
  hpt_results <- rbind(hpt_results,
                       cbind(params,
                             MAE = mae,
                             RMSE = rmse))
}

## View the results
hpt_results


## Visualise the results
ggplot(hpt_results,
       aes(x = mtry,
           y = RMSE,
           color = factor(num.trees))) +
  
  ## Use scatter plot
  geom_point(aes(size = min.node.size),
             alpha = 0.7) +
  
  ## Set theme to minimal
  theme_minimal() +
  
  ## Add title, labels, and legends
  labs(title = "Hyperparametre Tuning Results",
       x = "mtry",
       y = "RMSE",
       color = "num.trees",
       size = "min.node.size")

## Define the best hyperparametres
best_num.tree <- 300
best_mtry <- 4
best_min.node.size <- 2.5

## Fit the model
rf_model_new <- ranger(hwy ~ .,
                       data = train,
                       num.tree = best_num.tree,
                       mtry = best_mtry,
                       min.node.size = best_min.node.size)

## Evaluate the model

## Make predictions
preds_new <- predict(rf_model_new,
                     data = test)$predictions

## Get errors
errors_new <- test$hwy - preds_new

## Calculate MAE
mae_new <- mean(abs(errors_new))

## Calculate RMSE
rmse_new <- sqrt(mean(errors_new^2))

## Calculate R squared
r_sq_new <- 1 - (sum((errors_new)^2) / sum((test$hwy - mean(test$hwy))^2))

## Print the results
cat("Final model MAE:", round(mae_new, 2), "\n")
cat("Final model RMSE:", round(rmse_new, 2), "\n")
cat("Final model R squared:", round(r_sq_new, 2), "\n")


## Compare the two models
model_comp <- data.frame(Model = c("Initial", "Final"),
                         MAE = c(round(mae, 2), round(mae_new, 2)),
                         RMSE = c(round(rmse, 2), round(rmse_new, 2)),
                         R_Squared = c(round(r_sq, 2), round(r_sq_new, 2)))

## Print
model_comp


## Get variabe importance

## Fit the model with importance
rf_model_new <- ranger(hwy ~ .,
                       data = train,
                       num.tree = best_num.tree,
                       mtry = best_mtry,
                       min.node.size = best_min.node.size,
                       importance = "permutation") # Add importance

## Get variable importance
vip(rf_model_new)  +
  
  ## Add title and labels
  labs(title = "Variable Importance – Final Random Forest Model",
       x = "Variables",
       y = "Importance") +
  
  ## Set theme to minimal
  theme_minimal()