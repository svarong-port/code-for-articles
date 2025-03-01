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


# --------------------------


# Prepare the dataset

## Load the dataset
data(mtcars)

## Convert flights dataset into data.table object
mtcars_dt <- as.data.table(mtcars)

## View the first 6 rows
head(mtcars_dt)

## Glimpse
glimpse(mtcars_dt)


# --------------------------



# dplyr vs data.table syntax

## dplyr
mtcars |>
  select(am, mpg) |>
  filter(am == 1 & mpg >= 20) |>
  arrange(desc(mpg))

## data.table
mtcars_dt[am == 1 & mpg >= 20, .(am, mpg)][order(-mpg)]


# --------------------------


# Working with dtplyr

## Convert mtcars dataset into lazy data.table object
mtcars_ldt <- lazy_dt(mtcars)

## Execute the syntax
mtcars_ldt |>
  select(am, mpg) |>
  filter(am == 1 & mpg >= 20) |>
  arrange(desc(mpg)) |>
  as.data.table()

## Execute the syntax, without as.data.table()
mtcars_ldt |>
  select(am, mpg) |>
  filter(am == 1 & mpg >= 20) |>
  arrange(desc(mpg))