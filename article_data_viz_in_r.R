# Install ggplot2
install.packages("ggplot2")


# --------------------


# Load ggplot2
library(ggplot2)


# --------------------


# Get the dataset

## View the built-in dataset list
data()

## Load the dataset
data(airquality)

## Preview the dataset
head(airquality)

## Get info on the dataset
?airquality


# --------------------


# Create the plots

## Histogram, default binwidth
ggplot(data = airquality, aes(x = Temp)) +
  geom_histogram()

## Histogram, customised binwidth
ggplot(data = airquality, aes(x = Temp)) +
  geom_histogram(binwidth = 3)

# Box plot
ggplot(data = airquality, aes(x = factor(Month), y = Temp)) + 
  geom_boxplot()

# Scatter plot, no trend line
ggplot(data = airquality, aes(x = Temp, y = Wind)) +
  geom_point()

# Scatter plot, with trend line
ggplot(data = airquality, aes(x = Temp, y = Wind)) +
  geom_point() +
  geom_smooth(method = "lm")

# Line plot
ggplot(data = airquality, aes(x = as.numeric(Month), y = Temp, group = 1)) + 
  geom_line()

# Bar plot, using geom_col()
ggplot(data = airquality, aes(x = Month, y = Temp)) +
  geom_col()


# --------------------



