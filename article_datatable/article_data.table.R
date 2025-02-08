# Install and load dat.table

## Install data.table
install.packages("data.table")

## Load data.table
library(data.table)



# ---------------------------------------------



# Import flights

## Import CSV
flights <- fread("flights14.csv")

## Preview the dataset
head(flights)

## View the datast
View(flights)



# ---------------------------------------------



# data.table syntax:

## DT[i, j, by, ...]

## >> i = rows
## >> j = columns
## >> by = grouping data
## >> ... = additional arguments



# ---------------------------------------------



# 1. Using i

## 1.1 Selecting

### 1.1.1 Selecting 1 row
flights[4]

### 1.1.2 Selecting a range of rows
flights[1:10]

### 1.1.3 Selecting multiple rows
flights[c(1, 3, 5, 7, 9)]

### 1.1.4 Deselecting
flights[-1]

flights[!1]


## 1.2 Filtering

### 1.2.1 Filtering by 1 condition
flights[hour >= 20]

### 1.2.2 Filtering by multiple conditions
flights[hour >= 20 & origin == "LGA"]

### 1.2.3 %between%
flights[hour %between% c(10, 20)]

### 1.2.4 %like%
flights[dest %like% "^A"]

### 1.2.5 %chin%
flights[dest %chin% c("ATL", "LAX", "ORD")]


# ---------------------------------------------




# 2. Using j

## 2.1 Selecting columns

### 2.1.1 Selecting 1 column


### 2.1.2 Selecting mulitple columns with vector
flights[, c("origin", "dest", "air_time")]

### 2.1.3 Selecting mulitple columns with list
flights[, list(origin, dest, air_time)]

### 2.1.4 Selecting mulitple columns with .()
flights[, .(origin, dest, air_time)]

# ---------------------------------------------



# Using by





# ---------------------------------------------



# Using ...

