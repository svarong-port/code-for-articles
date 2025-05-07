# Code for Generalised Linear Model in R


# Generate mock coffee shop dataset (15 days)

## Set seed for reproducibility
set.seed(123)

## Generate
coffee_shop <- data.frame(
  
  ## Generate 15 days
  day = 1:15,
  
  ## Generate daily temperature
  temp = round(rnorm(15,
                     mean = 25,
                     sd = 5),
               1),
  
  ## Generate promotion day
  promo = sample(c(0, 1),
                 15,
                 replace = TRUE),
  
  ## Generate weekend
  weekend = c(0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1),
  
  ## Generate the number of sales
  sales = round(rnorm(15,
                      mean = 300,
                      sd = 50)),
  
  ## Generate the number of daily customers
  customers = rpois(15,
                    lambda = 80),
  
  ## Generate sold-out
  sold_out = sample(c(0, 1),
                    15,
                    replace = TRUE)
)

## Convert binary variables to factors
coffee_shop$promo <- factor(coffee_shop$promo,
                            levels = c(0, 1),
                            labels = c("NoPromo", "Promo"))

coffee_shop$weekend <- factor(coffee_shop$weekend,
                              levels = c(0, 1),
                              labels = c("Weekday", "Weekend"))

coffee_shop$sold_out <- factor(coffee_shop$sold_out,
                               levels = c(0, 1),
                               labels = c("No", "Yes"))

## View the dataset
print(coffee_shop)


# ----------------------------------------------------------


# Linear regression: Predicting sales

## Fit the model
linear_reg <- glm(sales ~ temp + promo + weekend,
                  data = coffee_shop,
                  family = gaussian)

## Get model summary
summary(linear_reg)

## Make predictions
linear_reg_preds <- predict(linear_reg,
                            type = "response")

## Compare predicted vs actual
linear_reg_results <- data.frame(
  predicted = round(linear_reg_preds, 2),
  actual = coffee_shop$sales
  )

## Print the results
linear_reg_results

## Plot predicted vs actual
plot(linear_reg_results$predicted,
     linear_reg_results$actual,
     main = "Linear Regression: Predicted vs Actual Sales",
     xlab = "Predicted Sales",
     ylab = "Actual Sales",
     pch = 16,
     col = "darkgreen")
abline(0,
       1,
       col = "red",
       lwd = 2,
       lty = 2)


# ----------------------------------------------------------


# Logistic regression: Predict probability of sold-out

## Fit the model
log_reg <- glm(sold_out ~ temp + promo + weekend,
               data = coffee_shop,
               family = binomial)

## Get model summary
summary(log_reg)

## Transform coefficient
exp(coef(log_reg))

## Get predictive probabilities
log_reg_probs <- predict(log_reg,
                         type = "response")

## Compare predicted vs actual
log_reg_results <- data.frame(
  probability = round(log_reg_probs, 2),
  predicted = ifelse(log_reg_probs > 0.5,
                     "Yes",
                     "No"),
  actual = coffee_shop$sold_out
)

## Print the results
log_reg_results

## Create a confusion matrix
table(predicted = log_reg_results$predicted,
      actual = log_reg_results$actual)


# ----------------------------------------------------------


# Poisson regression: Predicting the number of customers per day

## Fit the model
poisson_reg <- glm(customers ~ temp + promo + weekend,
                   data = coffee_shop,
                   family = poisson)

## Get model summary
summary(poisson_reg)

## Transform the coefficients
exp(coef(poisson_reg))

## Make predictions
poisson_reg_preds <- predict(poisson_reg,
                             type = "response")

## Compare predicted vs actual
poisson_reg_results <- data.frame(
  predicted = round(poisson_reg_preds, 0),
  actual = coffee_shop$customers
  )

## Print the results
poisson_reg_results

## Plot predicted vs actual
plot(poisson_reg_results$predicted,
     poisson_reg_results$actual,
     main = "Predicted vs Actual Customers (Poisson)",
     xlab = "Predicted",
     ylab = "Actual")
abline(0,
       1,
       col = "blue")