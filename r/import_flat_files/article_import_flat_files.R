# Code for Importing Flat Files in R

# Install and load packages

# Install
install.packages("readr")
install.packages("data.table")

# Load
library(readr)
library(data.table)


# ----------------------------------------------


# 1. Import with utils package

# 1.1 read.csv()
nutrition.csv <- read.csv("Nutrition_Value_Dataset.csv")

# View the first few rows
head(nutrition.csv)


# 1.2 read.delim()
nutrition.delim <- read.delim("Nutrition_Value_Dataset.tsv")

# View the first few rows
head(nutrition.delim)


# 1.3 read.table()
nutrition.table <- read.table("Nutrition_Value_Dataset.txt",
                              header = TRUE,
                              sep = "/")

# View the first few rows
head(nutrition.table)


# ----------------------------------------------


# 2. readr

# 2.1 read_csv()
nutrition_csv <- read_csv("Nutrition_Value_Dataset.csv")

# View the first few rows
head(nutrition_csv)


# 2.2 read_tsv()
nutrition_tsv <- read_tsv("Nutrition_Value_Dataset.tsv")

# View the first few rows
head(nutrition_tsv)

# 2.3 read_delim()
nutrition_delim <- read_delim("Nutrition_Value_Dataset.txt",
                              delim = "/")

# View the first few rows
head(nutrition_delim)


# ----------------------------------------------


# 3. data.table

# 3.1 fread() for CSV
nutrition_fread_csv <- fread("Nutrition_Value_Dataset.csv")

# View the first few rows
head(nutrition_fread_csv)


# 3.2 fread() for TSV
nutrition_fread_tsv <- fread("Nutrition_Value_Dataset.tsv")

# View the first few rows
head(nutrition_fread_tsv)


# 3.3 fread() for TXT with "/" separator
nutrition_fread_txt <- fread("Nutrition_Value_Dataset.txt",
                             sep = "/")

# View the first few rows
head(nutrition_fread_txt)