# Code for Regression Models in R


# Install and load packages

## Install
install.packages("ggplot2") # for diamonds dataset and visualisation
install.packages("dplyr") # for data manipulation

## Load
library(ggplot2)
library(dplyr)


# --------------------------------------------------


# Prepare the dataset

## Preview the dataset
head(diamonds)


## Dummy encode categorical variables

### Set option to dummy encoding
options(contrasts = c("contr.treatment",
                      "contr.treatment"))

### Dummy encode
cat_dum <- model.matrix(~ cut + color + clarity,
                        data = diamonds)[, -1]

### Combine dummy-encoded categorical and numeric variables
dm <- cbind(diamonds |> select(carat,
                               depth,
                               table,
                               y,
                               z),
            cat_dum,
            price = diamonds$price)

## Check the results
glimpse(dm)


## Check the distribution of `price`
ggplot(dm,
       aes(x = price)) +
  geom_histogram(binwidth = 100)

## Check the distribution of log `price`
ggplot(dm,
       aes(x = log(price))) +
  geom_histogram()

## Log-transform `price`
dm$price_log <- log(dm$price)

## Drop `price`
dm$price <- NULL

## Check the results
glimpse(dm)


## Split the data

## Set seed for reproducibility
set.seed(181)

### Training index
train_index <- sample(nrow(dm),
                      0.8 * nrow(dm))

### Create training set
train_set <- dm[train_index, ]

### Create test set
test_set <- dm[-train_index, ]


# --------------------------------------------------


# Fit the model
linear_reg <- lm(price_log ~ .,
                 data = train_set)

# View the model
summary(linear_reg)


# --------------------------------------------------


# Make predictions

## Predict in the log space
pred_log <- predict(linear_reg,
                    newdata = test_set,
                    type = "response")

## Predict in the outcome space
pred <- exp(pred_log)

## Compare predictions to actual
results <- data.frame(actual = exp(test_set$price),
                      predicted = pred)

## Print results
head(results)


# --------------------------------------------------


# Evaluate the model performance

## Calculate MAE
mae <- mean(abs(pred - test_set$price))

## Calculate RMSE
rmse <- sqrt(mean((pred - test_set$price)^2))

## Print the results
cat("MAE:", mae, "\n")
cat("RMSE:", rmse)