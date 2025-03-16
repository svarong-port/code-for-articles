# Code for Tree-Based Models With rpart() and randomForest()

# Install and load the packages

## Install
install.packages("rpart")
install.packages("rpart.plot")
install.packages("randomForest")

## Load
library(rpart)
library(rpart.plot)
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

## Classification tree
ct <- rpart(am ~ .,
            data = train_set,
            method = "class",
            control = rpart.control(cp = 0, minsplit = 1, maxdepth = 5))

## Random forest
rf <- randomForest(am ~ .,
                   data = train_set,
                   ntree = 100)


# -----------------------------------------------


# Evaluate the models

## Plot classification tree
rpart.plot(ct,
           type = 3,
           extra = 101,
           under = TRUE,
           digits = 3,
           tweak = 1.2)

## Caculate accuracy for classification tree

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


# -----------------------------------------------


# Createa a simple example decision tree

## Create a small dataset for decision making
job_data <- data.frame(
  RelatedSkill = c("Yes", "Yes", "Yes", "Yes", "No", "No", "No", "No"),
  AttractiveSalary = c("Yes", "No", "Yes", "No", "Yes", "No", "Yes", "No"),
  WorkType = c("Hybrid", "Hybrid", "Remote", "Remote", "Hybrid", "Remote", "Remote", "Hybrid"),
  Apply = c("Yes", "No", "Yes", "No", "No", "No", "Yes", "No")  # Decision to apply
)

## Convert categorical variables to factors
job_data[] <- lapply(job_data, as.factor)

## Build the decision tree model
dt_model <- rpart(Apply ~ RelatedSkill + AttractiveSalary + WorkType, 
                  data = job_data, 
                  method = "class", 
                  control = rpart.control(cp = 0, minsplit = 1, maxdepth = 3))

## Plot the decision tree with all predictors
rpart.plot(dt_model,
           type = 3,
           extra = 101,
           under = TRUE,
           tweak = 1.2)