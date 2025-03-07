# Code for Logistic Regression with glm()


# Load necessary library
library(ggplot2)


# Set seed for reproducibility
set.seed(42)


# Generate a small dataset with 50 points for each outcome level
x_0 <- sort(runif(10, -2, 0))  # X values for y = 0
x_1 <- sort(runif(10, 0, 2))   # X values for y = 1
x <- c(x_0, x_1)
y <- c(rep(0, 10), rep(1, 10))  # Binary outcome


# Fit a logistic regression model
logit_model <- glm(y ~ x,
                   family = binomial)

# Create a sequence of x values for the sigmoid curve
x_vals <- seq(min(x),
              max(x),
              length.out = 100)
y_probs <- predict(logit_model,
                   newdata = data.frame(x = x_vals), type = "response")

# Create the plot
ggplot(data = data.frame(x, y),
       aes(x = x,
           y = y)) +
  geom_point(size = 5,
             alpha = 0.7) +  # Data points
  geom_line(data = data.frame(x = x_vals, y = y_probs),
            aes(x = x, y = y), 
            color = "red",
            linewidth = 1) +  # Sigmoid curve
  labs(title = "Logistic Regression Fit for Binary Outcome",
       x = "Independent Variable (X)",
       y = "Predicted Probability of Y = 1") +
  theme_classic()



# --------------------------------------------------------



# Install and load necessary packages

## Install
install.packages("pROC")

## Load
library(pROC)


# Load the dataset
data(mtcars)


# Prepare the datast

## Preview the dataset
head(mtcars)

## Check the data typs of the columns
str(mtcars)

## Convert column `am` to factor
mtcars$am <- factor(mtcars$am,
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


# Build a logistic regression model
log_reg <- glm(am ~ .,
               data = train_set,
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