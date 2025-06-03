# Code for "Intro to dtplyr" Article

## Data
## Name: 🚗Car Market Dataset 📊 100k+ Vehicles
## URL: https://www.kaggle.com/datasets/zain280/car-dataset
## Retrieved Date: 03 Jun 2025


# --------------------------


# Install and load the packages

## Install
install.packages("dplyr")
install.packages("dtplyr")
install.packages("data.table")
install.packages("tibble")
install.packages("microbenchmark")

## Load
library(dplyr)
library(dtplyr)
library(data.table)
library(tibble)
library(microbenchmark)


# --------------------------


# Load the dataset

## Load
cars <- read.csv("Car_Data.csv")

## Preview
head(cars)

## View the structure
glimpse(cars)


# --------------------------


# Prepare the dataset

## Define columns to convert to factor
fac_cols <- c("Brand",
              "Model",
              "Color",
              "Condition")

## Convert the columns to factor
cars <- cars |>
  mutate(across(.cols = all_of(fac_cols),
                .fns = as.factor))

## Check the results
glimpse(cars)


# --------------------------


# Convert dataset into data.table object

## Convert
cars_dt <- as.data.table(cars)

## Preview
head(cars_dt)

## View the structure
glimpse(cars_dt)


# --------------------------



# dplyr vs data.table syntax

## Find mean mileage and price for used vs new in 1994

## dplyr
cars |>
  
  ## Filter for year 1994
  filter(Year == 1994) |>
  
  ## Group by condition
  group_by(Condition) |>
  
  ## Compute mean mileage and price
  summarise(mean_mileage = mean(Mileage),
            mean_price = mean(Price)) |>
  
  ## Arrange by condition
  arrange(desc(Condition))


## data.table
cars_dt[Year == 1994,
        .(mean_mileage = mean(Mileage),
          mean_price = mean(Price)),
        by = Condition][order(-Condition)]


# --------------------------


# Working with dtplyr

## Convert mtcars dataset into lazy data.table object
cars_ldt <- lazy_dt(cars)

## Execute the syntax
cars_ldt |>
  
  ## Filter for year 1994
  filter(Year == 1994) |>
  
  ## Group by condition
  group_by(Condition) |>
  
  ## Compute mean mileage and price
  summarise(mean_mileage = mean(Mileage),
            mean_price = mean(Price)) |>
  
  ## Arrange by condition
  arrange(desc(Condition)) |>
  
  ## Show the results
  as.data.table()

## Execute the syntax, without as.data.table()
cars_ldt |>
  
  ## Filter for year 1994
  filter(Year == 1994) |>
  
  ## Group by condition
  group_by(Condition) |>
  
  ## Compute mean mileage and price
  summarise(mean_mileage = mean(Mileage),
            mean_price = mean(Price)) |>
  
  ## Arrange by condition
  arrange(desc(Condition))


# --------------------------


# Time the computation
benchmark_results <- microbenchmark(
  
  ## Set dplyr code
  dplyr_code = {
    
    cars |>
      
      ## Filter for year 1994
      filter(Year == 1994) |>
      
      ## Group by condition
      group_by(Condition) |>
      
      ## Compute mean mileage and price
      summarise(mean_mileage = mean(Mileage),
                mean_price = mean(Price)) |>
      
      ## Arrange by condition
      arrange(desc(Condition))
  },
  
  ## Set data.table code
  dt_code = {
    cars_dt[Year == 1994,
            .(mean_mileage = mean(Mileage),
              mean_price = mean(Price)),
            by = Condition][order(-Condition)]
  },
  
  ## Set dtplyr
  dtplyr_code = {
    cars_ldt |>
      
      ## Filter for year 1994
      filter(Year == 1994) |>
      
      ## Group by condition
      group_by(Condition) |>
      
      ## Compute mean mileage and price
      summarise(mean_mileage = mean(Mileage),
                mean_price = mean(Price)) |>
      
      ## Arrange by condition
      arrange(desc(Condition)) |>
      
      ## Show the results
      as.data.table()
  },
  
  ## Set rounds to execute
  times = 100,
  
  ## Set unit to display the results
  unit = "ms"
)

## Show the results
benchmark_results