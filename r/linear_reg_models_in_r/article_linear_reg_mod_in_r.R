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

## Subset the dataset

### Set seed for reproducibility
set.seed(2019)

### Create sample of 3000 from diamonds
dm <- sample_n(diamonds,
               3000)

### View the structure
glimpse(dm)


## Dummy encode categorical variables

### Set option to dummy encoding
options(contrasts = c("contr.treatment",
                      "contr.treatment"))

### Dummy encode
cat_dum <- model.matrix(~ cut + color + clarity,
                        data = dm)[, -1]

### Combine dummy-encoded categorical and numeric variables
dm_prep <- cbind(dm |> select(carat, depth, table, x, y, z),
                 cat_dum,
                 price = dm$price)

## Check the results
glimpse(dm_prep)


## Check the distribution of `price`
ggplot(dm_prep, aes(x = price)) +
  geom_histogram()

## Check the distribution of log `price`
ggplot(dm_prep, aes(x = log(price))) +
  geom_histogram()


## Split the data

### Training index
train_index <- sample(nrow(dm_prep),
                      0.8 * nrow(dm_prep))

### Create training set
train_set <- dm_prep[train_index, ]

### Create test set
test_set <- dm_prep[-train_index, ]


# --------------------------------------------------


# Fit the model
linear_reg <- lm(log(price) ~ .,
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


# --------------------------------------------------


# Evaluate the model performance

## Calculate MAE
mae <- mean(abs(pred - test_set$price))

## Calculate RMSE
rmse <- sqrt(mean((pred - test_set$price)^2))

## Print the results
cat("MAE:", mae)
cat("RMSE:", rmse)