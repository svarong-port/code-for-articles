# Code for Generalised Linear Model in R

# Load the data
data(mtcars)

# Convert `vs` to factor
mtcars$vs <- factor(mtcars$vs,
                    levels = c(0, 1),
                    labels = c("V-shaped", "straight"))

# Convert `am` to factor
mtcars$am <- factor(mtcars$am,
                    levels = c(0, 1),
                    labels = c("automatic", "manual"))

# View the structure
str(mtcars)


# Linear regression

## Fit the model
linear_reg <- glm(mpg ~ wt + hp,
                  data = mtcars,
                  family = gaussian)

## View the model
summary(linear_reg)


# Logistic regression

## Fit the model
log_reg <- glm(am ~ wt + hp,
               data = mtcars,
               family = binomial)

## View the model
summary(log_reg)


# Poisson regression

## Fit the model
poisson_reg <- glm(cyl ~ wt + hp,
                   data = mtcars,
                   family = poisson)

## View the model
summary(poisson_reg)


# Quasi-poisson regression

## Fit the model
qp_reg <- glm(cyl ~ wt + hp,
              data = mtcars,
              family = quasipoisson(link = "log"))

## View the model
summary(qp_reg)