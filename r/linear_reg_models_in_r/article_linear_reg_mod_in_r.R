# Code for Regression Models in R


# Install and load packages

## Install
install.packages("ggplot2") # for diamonds dataset
install.packages("dplyr") # for data manipulation

## Load
library(ggplot2)
library(dplyr)


# --------------------------------------------------


# Prepare the dataset

## Load the dataset
data(diamonds)

## View the structure
glimpse(diamonds)


## Subset the dataset

### Set seed for reproducibility
set.seed(2019)

### Create sample of 3000 from diamonds
dm <- sample_n(diamonds,
               3000)


## Check the distribution of `price`
ggplot(dm, aes(x = price)) +
  geom_histogram()

## Check the distribution of log `price`
ggplot(dm, aes(x = log(price))) +
  geom_histogram()


## Split the data

### Training index
train_index <- sample(nrow(dm),
                      0.8 * nrow(dm))

### Create training set
train_set <- dm[train_index, ]

### Create test set
test_set <- dm[-train_index, ]


# --------------------------------------------------


# Fit the model
linear_reg <- lm(log(price) ~ carat + cut + table,
                 data = train_set)

# View the model
summary(linear_reg)


# --------------------------------------------------


# Make predictions

## Predict in the log space
pred_log <- predict(linear_reg,
                    newdata = test_set,
                    type = "response")

## Print the results
pred_log

## Predict in the outcome space
pred <- exp(pred_log)

## Print the results
pred


# --------------------------------------------------


# Evaluate the model performance

## Calculate MAE
mae <- mean(abs(pred - test_set$price))

## Calculate RMSE
rmse <- sqrt(mean((pred - test_set$price)^2))

## Save the results
results <- data.frame(metrics = c("MAE", "RMSE"),
                      values = c(mae, rmse))

## Show the results
results