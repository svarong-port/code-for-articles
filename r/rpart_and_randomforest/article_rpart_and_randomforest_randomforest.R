# Code for Tree-Based Models With rpart() and randomForest() - randomForest()

# Install and load the packages

## Install
install.packages("randomForest")

## Load
library(randomForest)


# -----------------------------------------------


# Load the dataset

## Load
data(mtcars)

## Preview
head(mtcars)


# -----------------------------------------------


# Preprocess the data

## Convert `am` to factor
mtcars$am <- factor(mtcars$am,
                    levels = c(0, 1),
                    labels = c("automatic", "manual"))

## Check the result
class(mtcars$am)


# -----------------------------------------------


# Split the data

## Set seed for reproducibility
set.seed(100)

## Get training index
train_index <- sample(nrow(mtcars),
                      nrow(mtcars) * 0.7)

## Split the data
train_set <- mtcars[train_index, ]
test_set <- mtcars[-train_index, ]


# -----------------------------------------------


# Train the models
rf <- randomForest(am ~ .,
                   data = train_set,
                   ntree = 100)


# -----------------------------------------------


# Evaluate the models

## Caculate accuracy for random forest

### Predict the outcome
test_set$pred_rf <- predict(rf,
                            newdata = test_set,
                            type = "class")


### Create a confusion matrix
cm_rf <- table(Predicted = test_set$pred_rf,
               Actual = test_set$am)

### Print confusion matrix
print(cm_rf)

### Get accuracy
acc_rf <- sum(diag(cm_rf)) / sum(cm_rf)

### Print accuracy
cat("Accuracy (random forest):", acc_rf)