# Code for Machine Learning With caret


# Install and load the pacakges
install.packages("caret") # for machine learning
install.packages("MASS") # for dataset

# Load
library(caret)
library(MASS)


# ---------------------------------------


# Load the dataset

## Load
data(Boston)

## Create a copy of Boston
bt <- Boston

## View the structure
str(bt)


# ---------------------------------------


# Preprocessing

## Dummy encoding

### Convert `chas` to factor
bt$chas <- factor(bt$chas,
                  levels = c(1, 0),
                  labels = c("river_bound", "otherwise"))

### Prepare a dummy encoding recipe
dummy_rec <- dummyVars(medv ~ .,
                       data = bt)

### Apply the recipe
bt_prep <- predict(dummy_rec,
                   newdata = bt) |> as.data.frame()


### Add `medv` back into the data frame
bt_prep$medv <- bt$medv

### Check the results
str(bt_prep)


# ---------------------------------------


# Split the data

## Create training set index
train_index <- createDataPartition(bt_prep$medv,
                                   p = 0.8,
                                   list = FALSE)

## Create training set
bt_train <- bt_prep[train_index, ]

## Create test set
bt_test <- bt_prep[-train_index, ]


# ---------------------------------------


# Tune and train the model

## Set up cross-validation

### Set seed for reproducibility
set.seed(2025)

### Set cross-validation to 10 folds
train_control <- trainControl(method = "cv",
                              number = 10,
                              verboseIter = TRUE)

### Set tune grid
tune_grid <- expand.grid(mtry = c(2, 4, 6, 8, 10),  
                         min.node.size = c(1, 5, 10),
                         splitrule = c("variance"))


## Train a random forest
rf_model <- train(medv ~ .,
                  data = bt_train,
                  method = "ranger",
                  trControl = train_control,
                  tuneGrid = tune_grid)


# ---------------------------------------


# Evaluate the model

## Make predictions
pred <- predict(rf_model,
                newdata = bt_test)

## Compute the performance metrics
metrics <- postResample(pred = pred,
                        obs = bt_test$medv)

## Print the results
metrics