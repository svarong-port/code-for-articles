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

## View the dataset
View(flights)



# ---------------------------------------------



# data.table syntax:

## DT[i, j, by]

## >> i = rows
## >> j = columns
## >> by = grouping data



# ---------------------------------------------



# 1. Using i

## 1.1 Selecting rows

### 1.1.1 Selecting 1 row
flights[5]

### 1.1.2 Selecting a range of rows
flights[1:10]

### 1.1.3 Selecting multiple rows
flights[c(1, 3, 5, 7, 9)]

### 1.1.4 Deselecting
flights[-1]

flights[!1]


## 1.2 Filtering

### 1.2.1 Filtering by 1 condition
flights[distance >= 500]

### 1.2.2 Filtering by multiple conditions
flights[distance >= 500 & origin == "LGA"]

### 1.2.3 %between%
flights[distance %between% c(500, 1000)]

### 1.2.4 %like%
flights[dest %like% "^A"]

### 1.2.5 %chin%
flights[dest %chin% c("ATL", "LAX", "ORD")]


## 1.3 Sorting

### 1.3.1 Sorting in ascending order
flights[order(origin)]

### 1.3.2 Sorting in descending order
flights[order(origin, decreasing = TRUE)]

flights[order(-origin)]

### 1.3.3 Sorting by multiple columns
flights[order(origin, dest)]



# ---------------------------------------------



# 2. Using j

## 2.1 Selecting columns

### 2.1.1 Selecting 1 column
flights[, "origin"]

### 2.1.2 Selecting multiple columns with vector
flights[, c("origin", "dest", "air_time")]

### 2.1.3 Selecting multiple columns with list
flights[, list(origin, dest, air_time)]

### 2.1.4 Selecting multiple columns with .()
flights[, .(origin, dest, air_time)]

### 2.1.5 Selecting multiple columns with ..
cols <- c("origin", "dest", "air_time")
flights[, ..cols]

### 2.1.6 Deselecting
flights[, -c("carrier")]

flights[, !c("carrier")]


## 2.2 Computing

### 2.2.1 Computing 1 statistical value
flights[, mean(air_time)]

### 2.2.2 Computing multiple statistical value
flights[, .(avg_air_time = mean(air_time),
            sd_air_time = sd(air_time))]


## 2.3 Creating columns

### 2.3.1 Creating 1 new column
flights[, speed := distance / (air_time / 60)]

head(flights)

### 2.3.2 Creating multiple new columns
flights[, `:=`(speed = distance / (air_time / 60),
               total_delay = dep_delay + arr_delay)]

head(flights)



# ---------------------------------------------



# 3. Using by

## 3.1 Group by 1 column
flights[, mean(dep_delay), by = origin]

## 3.2 Group by multiple columns
flights[, mean(dep_delay), by = c("origin", "dest")]

flights[, mean(dep_delay), by = list(origin, dest)]

flights[, mean(dep_delay), by = .(origin, dest)]



# ---------------------------------------------



# 4. Combining and chaining

## 4.1 Combining i, j, by
flights[distance >= 500, 
        .(avg_speed = mean(distance / (air_time / 60))), 
        by = origin]

## 4.2 Chaining
flights[month == 8,
        .(avg_arr_delay = mean(arr_delay)),
        by = dest][order(-avg_arr_delay)][1:5]



# ---------------------------------------------



# 5. Special symbols

## 5.1 .N

### 5.1.1 Select rows
flights[500:.N]

### 5.1.2 Compute with .N
flights[, .N, by = origin]

## 5.2 .SD
flights[,
        lapply(.SD, max, na.rm = TRUE),
        by = month]

## 5.3 .SDcols
flights[,
        lapply(.SD, max, na.rm = TRUE),
        by = month,
        .SDcols = c("arr_delay", "dep_delay")]