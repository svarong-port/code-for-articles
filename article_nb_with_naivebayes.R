# Code for Naive Baye in R With naivebayes Package

# Install and load the package

## Install
install.packages("naivebayes")

## Load
library(naivebayes)


# --------------------------------


# Load the dataset

## Load
data(iris)

## Preview
head(iris)

str(iris)


# --------------------------------


# Split the dataset

## Set seed for reproducibility
set.seed(2025)

## Create a training index
training_index <- sample(1:nrow(iris),
                         0.7 * nrow(iris))

## Split the dataset
train_set <- iris[training_index, ]
test_set <- iris[-training_index, ]


# --------------------------------


# Create a Naive Bayes model

## Create a NB model
nb <- naive_bayes(Species ~ .,
                  data = train_set)

## Predict the outcomes
pred <- predict(nb,
                newdata = test_set[, 1:4],
                type = "class")

print(pred)


# --------------------------------


# Evaluate the model

## Create a confusion matrix
cm <- table(Predicted = pred, 
            Actual = test_set$Species)

print(cm)

## Calculate the accuracy
accuracy <- sum(diag(cm)) / sum(cm)

cat("Accuracy:", round(accuracy, 2))