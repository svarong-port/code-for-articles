# Code for Logistic Regression with glm()


# Generate linear and logistic regression plots for comparison

## Load necessary library
library(ggplot2)

## Set seed for reproducibility
set.seed(123)

## Generate a continuous dataset
x_cont <- seq(-5, 5, length.out = 30)  # Wider range for x
y_cont <- 3 * x_cont + rnorm(30, mean = 0, sd = 3)  # Spread out y with noise

## Fit a linear regression model
lin_model <- lm(y_cont ~ x_cont)

## Create a sequence of x values for the fitted regression line
x_vals <- seq(min(x_cont), max(x_cont), length.out = 100)
y_preds <- predict(lin_model, newdata = data.frame(x_cont = x_vals))

## Plot 1: Linear regression with continuous outcome
p1 <- ggplot(data = data.frame(x_cont, y_cont), aes(x = x_cont, y = y_cont)) +
  geom_point(size = 2, alpha = 0.7) +  # Data points
  geom_line(data = data.frame(x_cont = x_vals, y = y_preds), aes(x = x_cont, y = y), 
            color = "red", linewidth = 1) +  # Regression line
  labs(title = "Linear Regression for a Continuous Outcome",
       x = "Independent Variable (x)",
       y = "Dependent Variable (y)") +
  theme_minimal()

# 2. Generate a binary outcome dataset with smooth transition
x_bin <- seq(-5, 5, length.out = 30)  # X values
prob_y <- 1 / (1 + exp(-x_bin))  # Sigmoid function to generate probabilities
y_bin <- rbinom(30, size = 1, prob = prob_y)  # Convert probabilities to 0 or 1

## Fit a linear regression model on binary data
lin_model_bin <- lm(y_bin ~ x_bin)

## Predict values for the regression line
y_preds_bin <- predict(lin_model_bin, newdata = data.frame(x_bin = x_vals))

## Plot 2: Linear regression on binary outcome (bad fit)
p2 <- ggplot(data = data.frame(x_bin, y_bin), aes(x = x_bin, y = y_bin)) +
  geom_point(size = 2, alpha = 0.7) +  # Data points
  geom_line(data = data.frame(x_bin = x_vals, y = y_preds_bin), aes(x = x_bin, y = y), 
            color = "red", linewidth = 1) +  # Regression line
  labs(title = "Linear Regression for a Binary Outcome",
       x = "Independent Variable (x)",
       y = "Dependent Variable (y)") +
  theme_minimal()

## Fit a logistic regression model
logit_model <- glm(y_bin ~ x_bin, family = binomial)

## Predict probabilities for logistic regression
y_probs <- predict(logit_model, newdata = data.frame(x_bin = x_vals), type = "response")

## Plot 3: Logistic regression fit (good fit)
p3 <- ggplot(data = data.frame(x_bin, y_bin), aes(x = x_bin, y = y_bin)) +
  geom_point(size = 2, alpha = 0.7) +  # Data points
  geom_line(data = data.frame(x_bin = x_vals, y = y_probs), aes(x = x_bin, y = y), 
            color = "red", linewidth = 1) +  # Sigmoid curve
  labs(title = "Logistic Regression for a Binary Outcome",
       x = "Independent Variable (x)",
       y = "Predicted Probability of y = 1") +
  theme_minimal()

## Print all plots
print(p1)  # Continuous dataset with linear regression
print(p2)  # Binary dataset with linear regression (bad fit)
print(p3)  # Binary dataset with logistic regression (good fit)



# --------------------------------------------------------



# 1. Install and load necessary packages

## Install
install.packages("pROC")

## Load
library(pROC)


# 2. Load the dataset
data(mtcars)


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


# 5. Evaluate the model

## Get predictive probability
test_set$pred_prob <- predict(log_reg,
                              newdata = test_set,
                              type = "response")

## Predict the outcome
test_set$pred <- ifelse(test_set$pred_prob > 0.5,
                        1, # if greater -> manual
                        0) # if lower/equal -> auto

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

### Calcualte ROC
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