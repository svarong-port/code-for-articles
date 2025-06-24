# Code for Working With Excel in R - readxl

# Install and load packages

# Install
install.packages("readxl")

# Load
library(readxl)


# -------------------------------------------


# Import Excel data
all_transactions <- read_excel("Daily Household Transactions.xlsx",
                               sheet = 1)

# View the first 10 rows
head(all_transactions, n = 10)