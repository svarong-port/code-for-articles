# Code for Manipulating Time Series Objects in R


# Install and load the packages

## Install
install.packages("lubridate")
install.packages("zoo")
install.packages("xts")
install.packages("ggplot2")

## Load
library(lubridate)
library(zoo)
library(xts)
library(ggplot2)


# ---------------------------------------------


# Load the dataset

## Load 
passengers <- read.csv("AirPassengers.csv")

## Preview
head(passengers)

## View the structure
str(passengers)


# ---------------------------------------------


# Convert the dataset to `zoo`

## Convert `Month` to Date
passengers$Month <- as.yearmon(passengers$Month)

## Check the results
str(passengers)

## Convert `Passengers` to `zoo`
pass_zoo <- zoo(passengers$X.Passengers,
                order.by = passengers$Month)

## Check the results
head(pass_zoo)
tail(pass_zoo)


# ---------------------------------------------


# Plot the time series
autoplot.zoo(pass_zoo) +
  
  ## Add title and label
  labs(title = "Number of Passengers From 1950 to 1960",
       x = "Month",
       y = "Number of Passengers")


# ---------------------------------------------


# Subsetting

## Method 1. Using stats::window
pass_49_50 <- window(x = pass_zoo,
                     start = "Jan 1949",
                     end = "Dec 1950")

## Print the results
pass_49_50


## Method 2. Using logical expression

### Create a Boolean masking
index_55_56 <- index(pass_zoo) >= "Jan 1955" &
  index(pass_zoo) <= "Dec 1956"

## Print the Boolean masking
index_55_56

### Apply the Boolean masking
pass_zoo[index_55_56]


# ---------------------------------------------


# Aggregating

## Aggregate at quarterly level
pass_yr <- apply.yearly(x = pass_zoo,
                        FUN = mean)

## Plot yearly data
autoplot.zoo(pass_yr) +
  
  ## Add title and label
  labs(title = "Number of Passengers From 1950 to 1960",
       x = "Year",
       y = "Averange Number of Passengers")


## Aggregate at quarterly level
pass_qtr <- apply.quarterly(x = pass_zoo,
                            FUN = max)

## Plot quarterly data
autoplot.zoo(pass_qtr) +
  
  ## Add title and label
  labs(title = "Number of Passengers From 1950 to 1960",
       x = "Quarter",
       y = "Maximum Number of Passengers")