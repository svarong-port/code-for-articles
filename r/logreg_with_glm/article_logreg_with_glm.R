# Code for Logistic Regression with glm()


# 1. Install and load necessary packages

## Install
install.packages("pROC")

## Load
library(pROC)


# --------------------------------------------------------


# 2. Load the dataset
data(mtcars)


# --------------------------------------------------------


# 3. Prepare the datast

## Preview the dataset
head(mtcars)

## Check the data typs of the columns
str(mtcars)

## Convert column `am` to factor
mtcars$am <- factor(mtcars$am,
                    levels = c(0, 1),
                    labels = c("automatic", "manual"))

## Check the result
str(mtcars)


# --------------------------------------------------------


# 4. Split the data

## Set seed for reproducibility
set.seed(300)

## Create a training index
train_index <- sample(1:nrow(mtcars),
                      nrow(mtcars) * 0.7)

## Create training and test sets
train_set <- mtcars[train_index, ]
test_set <- mtcars[-train_index, ]


# Build a logistic regression model
log_reg <- glm(am ~ .,
               data = train_set,
               family = "binomial")


# --------------------------------------------------------


# 5. Evaluate the model

## Get predictive probability
test_set$pred_prob <- predict(log_reg,
                              newdata = test_set,
                              type = "response")

## Predict the outcome
test_set$pred <- ifelse(test_set$pred_prob > 0.5,
                        1,
                        0)

## Set column `pred ` as factor
test_set$pred <- factor(test_set$pred,
                        levels = c(0, 1),
                        labels = c("automatic", "manual"))

## Check the results
head(test_set[c("pred_prob", "pred", "am")])


## Create a confusion matrix
cm <- table(Predicted = test_set$pred,
            Actual = test_set$am)

## Print cm
print(cm)

## Compute accuracy
accuracy <- sum(diag(cm)) / sum(cm)

## Print accuracy
cat("Accuracy:", round(accuracy, 2))


## Get ROC

### Calculate ROC
ROC <- roc(test_set$am,
           pred_prob)

### Plot ROC
plot(ROC,
     main = "ROC Curve",
     col = "blue",
     lwd = 2)


## Get AUC

### Calculate AUC
AUC <- auc(ROC)

### Print AUC
print(AUC)