# Code for sqldf Article

# Install packages
install.packages("sqldf")
install.packages("MASS")

# Load packages
library(sqldf)
library(MASS)


# Load the dataset
data(Cars93)

# View the dataset structure
str(Cars93)



# Example 1. SELECT

# Set query
select_query <- "
SELECT
  Manufacturer,
  Model,
  `Min.Price`,
  `Max.Price`
FROM
  Cars93
"

# Select from df
select_result <- sqldf(select_query)

# View the result
select_result



# Example 2. WHERE

# Set query
where_result <- "
SELECT
  Manufacturer,
  Model,
  `Min.Price`,
  `Max.Price`
FROM
  Cars93
WHERE
  Manufacturer LIKE 'M%'
"

# Filter df
where_result <- sqldf(where_result)

# View the result
where_result



# Example 3. Aggregate data

# Set query
aggregate_query <- "
SELECT
  Manufacturer,
  AVG(Price) AS Avg_Price
FROM
  Cars93
GROUP BY
  Manufacturer
ORDER BY
  Avg_Price DESC
LIMIT
  10;
"

# Aggregate df
aggregate_result <- sqldf(aggregate_query)

# View the result
aggregate_result