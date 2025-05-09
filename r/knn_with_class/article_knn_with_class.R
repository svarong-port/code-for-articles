# Code for KNN With class Package


# Step 1. Install and load class package

## Install
install.packages("class")

## Load
library(class)


# Step 2. Load and preview the dataset

## Load
data(iris)

## Preview
head(iris)


# Step 3. Prepare the data

## 3.1 Normalise the data

### Define a function for normalisation
normalise <- function(x) {
  return((x - min(x)) / (max(x) - min(x)))
}

### Apply the function to the dataset
iris_normalised <- as.data.frame(lapply(iris[, 1:4],
                                        normalise))

### Add species column back into the data frame
iris_normalised$Species <- iris$Species

### Check the results
summary(iris_normalised)


## 3.2 Split the data

### Set seed for reproducibility
set.seed(2025)

### Create a training index
train_index <- sample(1:nrow(iris_normalised),
                      0.7 * nrow(iris_normalised))

### Split the data
train_set <- iris_normalised[train_index, ]
test_set <- iris_normalised[-train_index, ]


## 3.3 Separate features from label

### Training set
train_X <- train_set[, 1:4]
train_Y <- train_set$Species

### Test set
test_X <- test_set[, 1:4]
test_Y <- test_set$Species


# Step 4. Create a KNN model
predictions <- knn(train = train_X,
                   test = test_X,
                   cl = train_Y,
                   k = 5)


# Step 5. Evaluate the model

## Create a confusion matrix
cm <- table(Predicted = predictions,
            Actual = test_Y)

## Print the matrix
print(cm)

## Calculate accuracy
acc <- sum(diag(cm)) / sum(cm)

## Print accuracy
cat("Accuracy:", round(acc, 2))


# Bonus: fine-tuning

## Create a set of k values
k_values <- 1:20

## Createa a vector for accuracy results
accuracy_results <- numeric(length(k_values))

## For-loop through the k values
for (i in seq_along(k_values)) {
  
  ### Set the k value
  k <- k_values[i]
  
  ### Create a KNN model
  predictions <- knn(train = train_X,
                     test = test_X,
                     cl = train_Y,
                     k = k)
  
  ### Create a confusion matrix
  cm <- table(Predicted = predictions,
              Actual = test_Y)
  
  ### Calculate accuracy
  accuracy_results[i] <- sum(diag(cm)) / sum(cm)
}

## Find the best k and the corresponding accuracy
best_k <- k_values[which.max(accuracy_results)]
best_accuracy <- max(accuracy_results)

## Print the best k and accuracy
cat(paste("Best k:", best_k),
    paste("Accuracy:", round(best_accuracy, 2)),
    sep = "\n")

## Plot the results
plot(k_values,
     accuracy_results,
     type = "b",
     pch = 19,
     col = "blue",
     xlab = "Number of Neighbors (k)",
     ylab = "Accuracy",
     main = "KNN Model Accuracy for Different k Values")
grid()