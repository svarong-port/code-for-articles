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

## Create a regression model with glm()
linear_reg <- glm(sales ~ temp + promo + weekend,
                  data = coffee_shop,
                  family = gaussian)

## Get model summary
summary(linear_reg)


# ----------------------------------------------------------


# Logistic regression: Predict probability of sold-out

## Create a logistic regression model
log_reg <- glm(sold_out ~ temp + promo + weekend,
               data = coffee_shop,
               family = binomial)

## Get model summary
summary(log_reg)

## Transform coefficient
exp(coef(log_reg))


# ----------------------------------------------------------


# Poisson regression: Predicting the number of customers per day

## Create a poisson regression model
poisson_reg <- glm(customers ~ temp + promo + weekend,
                   data = coffee_shop,
                   family = poisson)

## Get model summary
summary(poisson_reg)

## Transform the coefficients
exp(coef(poisson_reg))