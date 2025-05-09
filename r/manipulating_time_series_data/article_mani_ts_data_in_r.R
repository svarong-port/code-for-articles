# Code for Manipulating Time Series Data in R

## Dataset: 
## URL: https://www.kaggle.com/datasets/shiivvvaam/bitcoin-historical-data
## Retrieved date: 


## Install and load packages

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


# ------------------------------


# Load the data

## Load
btc <- read.csv("Bitcoin History.csv")

## Preview
head(btc)

## View the structure
str(btc)


# ----------------------------------------


# Clean the dataset

## Make a copy of the dataset
btc_cleaned <- btc

## Rename columns

### Create new column names
new_col_names <- c("date",
                   "close", "open",
                   "high", "low",
                   "volume", "change_percentage")

### Rename
colnames(btc_cleaned) <- new_col_names

### Check the results
str(btc_cleaned)


## Convert data types

### Specify the columns to clean
cols_to_clean <- c("close", "open",
                   "high", "low")

### Remove comma
for (col in cols_to_clean) {
  btc_cleaned[[col]] <- gsub(",",
                             "",
                             btc_cleaned[[col]])
}

### Remove "K"
btc_cleaned$volume <- gsub("K",
                           "",
                           btc_cleaned$volume)

### Remove "%"
btc_cleaned$change_percentage <- gsub("%",
                                      "",
                                      btc_cleaned$change_percentage)

### Specify columns to convert to numeric
cols_to_num <- colnames(btc_cleaned[, -1])

### Convert data type to numeric
for (col in cols_to_num) {
  btc_cleaned[[col]] <- as.numeric(btc_cleaned[[col]])
}

### Check the results
str(btc_cleaned)


# ----------------------------------------


# Convert character to Date
btc_cleaned$date <- as.Date(btc_cleaned$date,
                            format = "%b %d, %Y")

# Check the results
str(btc_cleaned)


# ----------------------------------------


# Convert data to zoo object

## Convert
btc_zoo <- zoo(btc_cleaned[, -1],
               order.by = btc_cleaned$date)

## Check the results
head(btc_zoo)


# ----------------------------------------


# Fill the missing value

## Check for missing values
anyNA(btc_zoo)

## Count the missing values in each columns
colSums(is.na(btc_zoo))

## Impute with na.approx()
btc_zoo <- na.approx(btc_zoo)

## Check the results
colSums(is.na(btc_zoo))


# ----------------------------------------


# Plot the time series
autoplot.zoo(btc_zoo[, "close"]) +
  
  ## Adjust line colour
  geom_line(color = "blue") +
  
  ## Add title and labels
  labs(title = "Bitcoin Closing Price Across the Years (2010-2024)",
       x = "Date",
       y = "Closing Price (USD)") +
  
  ## Use minimal theme
  theme_minimal()


# ----------------------------------------


# Subsetting

## Method 1. Use window()

### Subset
btc_winter_1 <- window(x = btc_zoo,
                       start = as.Date("2021-11-01"),
                       end = as.Date("2022-12-31"))

### Plot the results
autoplot.zoo(btc_winter_1[, "close"]) +
  
  ### Adjust line colour
  geom_line(color = "blue") +
  
  ### Add title and labels
  labs(title = "Bitcoin Closing Price During Crypto Winter (Nov 2021 - Dec 2022)",
       x = "Date",
       y = "Closing Price (USD)") +
  
  ### Use minimal theme
  theme_minimal()


## Method 2. Boolean masking

### Create a Boolean masking
crypto_winter_index <- 
  index(btc_zoo) >= "2021-11-01" &
  index(btc_zoo) <= "2022-12-31"

### Subset
btc_winter_2 <- btc_zoo[crypto_winter_index, ]
  
### Plot the results
autoplot.zoo(btc_winter_2[, "close"]) +  
  
  ### Adjust line colour
  geom_line(color = "blue") +
  
  ### Add title and labels
  labs(title = "Bitcoin Closing Price During Crypto Winter (Nov 2021 - Dec 2022)",
       x = "Date",
       y = "Closing Price (USD)") +
  
  ### Use minimal theme
  theme_minimal()


## Method 3. Specific date

### Subset
btc_first_halving <- btc_zoo["2012-11-28"]

### Print the result
btc_first_halving


# ----------------------------------------


# Aggregate data

## View yearly max price
btc_yr_max <- apply.yearly(btc_zoo[, "close"],
                           FUN = max)

## Plot the results
autoplot.zoo(btc_yr_max) +  
  
  ### Adjust line colour
  geom_line(color = "blue") +
  
  ### Add title and labels
  labs(title = "Bitcoin Yearly Max Closing Price (2010-2024)",
       x = "Date",
       y = "Closing Price (USD)") +
  
  ### Use minimal theme
  theme_minimal()


## Create customised frequency

### Create half-year interval
half_year_eps <- endpoints(x = btc_zoo,
                           on = "months",
                           k = 6)

### Apply the interval
btc_half_yr_data <- period.apply(x = btc_zoo[, "close"],
                                 INDEX = half_year_eps,
                                 FUN = mean)

### Plot the results
autoplot.zoo(btc_half_yr_data) +  
  
  ### Adjust line colour
  geom_line(color = "blue") +
  
  ### Add title and labels
  labs(title = "Bitcoin Average Closing Price at a 6-Month Interval (2010-2024)",
       x = "Date",
       y = "Closing Price (USD)") +
  
  ### Use minimal theme
  theme_minimal()