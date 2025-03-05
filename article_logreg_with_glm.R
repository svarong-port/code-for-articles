# Code for Logistic Regression with glm()



# Install and load necessary packages

# Install
install.packages("pROC")

# Load
library(pROC)



# Load the dataset
data(mtcars)



# Prepare the datast

## Preview the dataset
head(mtcars)

## Check the data typs of the columns
str(mtcars)

## Convert column `am` to factor
mtcars$am = factor(mtcars$am,
                   levels = c(0, 1),
                   labels = c("automatic", "manual"))

## Check the results
str(mtcars)



# Split the data

## Set seed for reproducibility
set.seed(300)

## Create a training index
train_index <- sample(1:nrow(mtcars),
                      nrow(mtcars) * 0.7)

## Create training and test sets
train_set <- mtcars[train_index, ]
test_set <- mtcars[-train_index, ]



# Create logistic regression model
log_reg <- glm(am ~ .,
               train_set,
               family = "binomial")


# Evaluate the model

## Get predictive probability
pred_prob <- predict(log_reg,
                     newdata = test_set,
                     type = "response")

## Predict the outcome
test_set$pred <- ifelse(pred_prob > 0.5,
                        1,
                        0)

test_set$pred <- as.factor(test_set$pred)

## Create a confusion matrix
cm <- table(Predicted = test_set$pred,
            Actual = test_set$am)

## Compute accuracy
accuracy <- sum(diag(cm)) / sum(cm)

cat("Accuracy:", round(accuracy, 2))

## Get ROC
ROC <- roc(test_set$am,
           pred_prob)

print(ROC)

plot(ROC,
     main = "ROC Curve",
     col = "blue",
     lwd = 2)

## Get AUC
AUC <- auc(ROC)

print(AUC)