# Code for "Intro to dtplyr" Article


# --------------------------


# Install and load the packages

## Install
install.packages("dplyr")
install.packages("dtplyr")
install.packages("data.table")
install.packages("tibble")
install.packages("microbenchmark")
install.packages("ggplot2")
install.packages("nycflights13")

## Load
library(dplyr)
library(dtplyr)
library(data.table)
library(tibble)
library(microbenchmark)
library(ggplot2)
library(nycflights13)


# --------------------------


# Preview the dataset

## Convert flights dataset into data.table object
flights_dt <- as.data.table(flights)

## View the first 6 rows
head(flights_dt)

## Glimpse
glimpse(flights_dt)


# --------------------------



# dplyr vs data.table syntax

## dplyr
flights |>
  select(flight, distance) |>
  filter(distance >= 1000) |>
  arrange(desc(distance))

## data.table
flights_dt[distance >= 1000, .(flight, distance)][order(-distance)]


# --------------------------


# Working with dtplyr

## Convert flights dataset into lazy data.table object
flights_ldt <- lazy_dt(flights)

## Execute the syntax
flights_ldt |>
  select(flight, distance) |>
  filter(distance >= 1000) |>
  arrange(desc(distance)) |>
  as.data.table()

## Execute the syntax, without as.data.table()
flights_ldt |>
  select(flight, distance) |>
  filter(distance >= 1000) |>
  arrange(desc(distance))


# --------------------------


# dyplr speed test

## dplyr
dplyr_syntax <- function() {
  flights |>
    select(flight, distance) |>
    filter(distance >= 1000) |>
    arrange(desc(distance))
}

## dtplyr
dtplyr_syntax <- function() {
  flights_ldt |>
    select(flight, distance) |>
    filter(distance >= 1000) |>
    arrange(desc(distance)) |>
    as.data.table()
}

## data.table
data_table_syntax <- function() {
  flights_dt[distance >= 1000, .(flight, distance)][order(-distance)]
}

## Compare speed
results <- microbenchmark(
  dplyr = dplyr_syntax(),
  dtplyr = dtplyr_syntax(),
  data_table = data_table_syntax(),
  times = 100
)

print(results)