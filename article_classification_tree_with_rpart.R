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
set.seed(2025)

## Create train index
train_index <- sample(nrow(mtcars),
                      nrow(mtcars) * 0.7)

## Split the data
train_set <- mtcars[train_index, ]
test_set <- mtcars[-train_index, ]


# Train a model

## Fit the model
class_tree <- rpart(am ~ .,
                    data = train_set,
                    method = "class")

## Visualise the model
rpart.plot(class_tree)


# Evaluate the model

## Predict the outcome
test_set$pred <- predict(class_tree,
                         newdata = test_set,
                         type = "class")

## Create a confusion matrix
cm <- table(Predicted = test_set$pred,
            Actual = test_set$am)

## Print confusion matrix
print(cm)

## Calculate accuracy
accuracy <- sum(diag(cm)) / sum(cm)

### Print accuracy
cat("Accuracy:",
    round(accuracy, 2))