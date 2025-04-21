# Code for Boosted Tree With xgboost Package


## Install and load packages

## Install
install.packages("xgboost")
install.packages("ggplot2")
install.packages("dplyr")

## Load
library(xgboost)
library(ggplot2)
library(dplyr)


# --------------------------------------------------


## Load the dataset

## Load
data(mpg)

## Preview
head(mpg)

## View the tructure
str(mpg)


# --------------------------------------------------


## Prepare the dataset

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


# --------------------------------------------------


## Separate the features from the outcome

## Get the features
x <- mpg |>
  
  ## Deselect the outcome
  select(-hwy)

## One-hot encode the features
x <- model.matrix(~ . - 1,
                  data = x)

## Get the outcome
y <- mpg$hwy


# --------------------------------------------------


## Split the data

## Set seed for reproducibility
set.seed(360)

## Get x_train index
train_index <- sample(1:nrow(x),
                      nrow(x) * 0.8)

## Create x train and test
x_train <- x[train_index, ]
x_test <- x[-train_index, ]

## Create y train and test
y_train <- y[train_index]
y_test <- y[-train_index]


# --------------------------------------------------


## Convert to DMatrix

## Training set
train_set <- xgb.DMatrix(data = x_train,
                         label = y_train)

## Test set
test_set <- xgb.DMatrix(data = x_test,
                        label = y_test)


# --------------------------------------------------


## Train the model

## Aet hyperparametres
hp <- list(objective = "reg:squarederror",
           eta = 0.1,
           max_depth = 4)


## Train
xgb_model <- xgb.train(params = hp,
                       data = train_set,
                       nrounds = 100,
                       watchlist = list(train = train_set,
                                        test = test_set),
                       verbose = 1)


# --------------------------------------------------


## Evaluate the model

## Make predictions
y_pred <- predict(xgb_model,
                  x_test)

## Visualise the predictions
ggplot(data.frame(actual = y_test,
                  predicted = y_pred),
       aes(x = actual,
           y = predicted)) +
  
  ## Instantiate a scatter plot
  geom_point(alpha = 0.5,
             color = "darkgreen") +
  
  ## Add line
  geom_abline(slope = 1,
              intercept = 0,
              color = "red") +
  
  ## Add error lines
  geom_segment(aes(x = actual,
                   xend = actual,
                   y = predicted,
                   yend = actual),
               color = "grey",
               linetype = "dashed") +
  
  ## Add text elements
  labs(title = "XGBoost: Actual vs Predicted",
       x = "Actual hwy",
       y = "Predicted hwy") +
  
  ## Set theme to minimal
  theme_minimal()


## Calculate errors
errors <- y_test - y_pred

## Calculate MAE
mae <- mean(abs(errors))

## Calculate RMSE
rmse <- sqrt(mean((errors)^2))

## Calculate R-squared
ss_res <- sum((errors)^2)
ss_tot <- sum((y_test - mean(y_test))^2)
r_squared <- 1 - (ss_res / ss_tot)

## Print the results
cat("MAE:", round(mae, 2), "\n")
cat("RMSE:", round(rmse, 2), "\n")
cat("R-squared:", round(r_squared, 2), "\n")