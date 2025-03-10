# Code for Classification Tree With rpart


# Install and load the packages

## Install
install.packages("rpart")
install.packages("rpart.plot")
install.packages("randomForest")

## Load
library(rpart)
library(rpart.plot)
library(randomForest)


# Load and preview the dataset

## Load
data(mtcars)

## Preview
head(mtcars)


# Prepare the data

## Check the data type
str(mtcars)

## Convert `am` to factor
mtcars$am <- factor(mtcars$am,
                    levels = c(0, 1),
                    labels = c("automatic", "manual"))

## Check the result
str(mtcars)


# Split the data

## Set seed for reproducibility
set.seed(300)

## Create train index
train_index <- sample(nrow(mtcars),
                      nrow(mtcars) * 0.7)

## Split the data
train_set <- mtcars[train_index, ]
test_set <- mtcars[-train_index, ]


# Train a classsification tree model

## Fit the model
class_tree <- rpart(am ~ .,
                    data = train_set,
                    method = "class")

## Visualise the model
rpart.plot(class_tree)


# Evaluate the model

## Predict the outcome
test_set$t_pred <- predict(class_tree,
                           newdata = test_set,
                           type = "class")

## Create a confusion matrix
cm_t <- table(Predicted = test_set$t_pred,
              Actual = test_set$am)

## Print confusion matrix
print(cm_t)

## Calculate accuracy
acc_t <- sum(diag(cm_t)) / sum(cm_t)

## Print accuracy
cat("Accuracy:",
    round(acc_t, 2))


# Train a random forest model
rf <- randomForest(am ~ .,
                   data = train_set)


# Evaluate the model

## Predict the outcome
test_set$rf_pred <- predict(rf,
                            newdata = test_set,
                            type = "class")


## Create a confusion matrix
cm_rf <- table(Predicted = test_set$rf_pred,
               Actual = test_set$am)

## Print cm
print(cm_rf)

## Calculate accuracy
acc_rf <- sum(diag(cm_rf)) / sum(cm_rf)

## Print accuracy
cat("Accuracy",
    round(acc_rf, 2))