# Code for Linear Regression in R


# Install and load packages

## Install
install.packages("ggplot2")

## Load
library(ggplot2)


# --------------------------------------------------


# Prepare the dataset

## Load dataset
data(diamonds)

## Preview the dataset
head(diamonds, 10)


## One-hot encode categorical variables

### Set option for one-hot encoding
options(contrasts = c("contr.treatment",
                      "contr.treatment"))

### One-hot encode
cat_dum <- model.matrix(~ cut + color + clarity - 1,
                        data = diamonds)

### Combine one-hot-encoded categorical and numeric variables
dm <- cbind(diamonds[, c("carat",
                         "depth",
                         "table",
                         "x",
                         "y",
                         "z")],
            cat_dum,
            price = diamonds$price)

## Check the results
str(dm)


## Check the distribution of `price`
ggplot(dm,
       aes(x = price)) +
  
  ### Instantiate a histogram
  geom_histogram(binwidth = 100,
                 fill = "skyblue3") +
  
  ### Add text elements
  labs(title = "Distribution of Price",
       x = "Price",
       y = "Count") +
  
  ### Set theme to minimal
  theme_minimal()


## Log-transform `price`
dm$price_log <- log(dm$price)

## Drop `price`
dm$price <- NULL


## Check the distribution of logged `price`
ggplot(dm,
       aes(x = price_log)) +
  
  ### Instantiate a histogram
  geom_histogram(fill = "skyblue3") +
  
  ### Add text elements
  labs(title = "Distribution of Price After Log Transformation",
       x = "Price (Logged)",
       y = "Count") +
  
  ### Set theme to minimal
  theme_minimal()


## Split the data

### Set seed for reproducibility
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

## Preview predictions
head(pred_log)

## Predict in the outcome space
pred <- exp(pred_log)

## Preview predictions
head(pred)

## Compare predictions to actual
results <- data.frame(actual = round(exp(test_set$price_log), 2),
                      predicted = round(pred, 2),
                      diff = round(exp(test_set$price_log) - pred, 2))

## Print results
head(results)


# --------------------------------------------------


# Evaluate the model performance

## Calculate MAE
mae <- mean(abs(results$diff))

## Calculate RMSE
rmse <- sqrt(mean((results$diff)^2))

## Print the results
cat("MAE:", round(mae, 2), "\n")
cat("RMSE:", round(rmse, 2))