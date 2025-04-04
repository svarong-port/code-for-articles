# Code for Tree-Based Models With rpart() and randomForest() - rpart()

# Install and load the packages

## Install
install.packages("rpart")
install.packages("rpart.plot")

## Load
library(rpart)
library(rpart.plot)


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
ct <- rpart(am ~ .,
            data = train_set,
            method = "class",
            control = rpart.control(cp = 0, minsplit = 1, maxdepth = 5))


# -----------------------------------------------


# Evaluate the models

## Plot classification tree
rpart.plot(ct,
           type = 3,
           extra = 101,
           under = TRUE,
           digits = 3,
           tweak = 1.2)

## Calculate accuracy for classification tree

### Predict the outcome
test_set$pred_ct <- predict(ct,
                            newdata = test_set,
                            type = "class")


### Create a confusion matrix
cm_ct <- table(Predicted = test_set$pred_ct,
               Actual = test_set$am)

### Print confusion matrix
print(cm_ct)

### Get accuracy
acc_ct <- sum(diag(cm_ct)) / sum(cm_ct)

### Print accuracy
cat("Accuracy (classification tree):", acc_ct)