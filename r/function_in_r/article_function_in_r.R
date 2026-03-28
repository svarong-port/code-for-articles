# Code for Function in R Article

# Without function
1 + 2 + 3 + 4 + 5

# With function
sum(1:5)


# Randomly pick 3 numbers between 1 to 10
sample(1:10, 3)

# Positional arguments
sample(1:10, 3)

# Keyword arguments
sample(x = 1:10, size = 3)


# Read round() documentation
?round

# Learn about round() arguments
args(round)


# Data frame of my friends
friends <- data.frame(
  name = c("Alice", "Bob", "Charlie", "David", "Eve", "Frank", "Grace", "Heidi"),
  age = c(28, 32, 25, 30, 29, 35, 27, 31)
)

# friends data frame:
#       name age
#  1   Alice  28
#  2     Bob  32
#  3 Charlie  25
#  4   David  30
#  5     Eve  29
#  6   Frank  35
#  7   Grace  27
#  8   Heidi  31

# Sample 3 of my frends
sample_n(friends, 3)

# Install package
install.packages("dplyr")

# Load package
library(dplyr)

# Sample 3 of my frends
sample_n(friends, 3)


# Custome function to find circle area
circle_area <- function(radius) {
  
  # Calculate area
  area <- pi * (radius^2)
  
  # Return area
  print(area)
}

# Calculate circle area where radius is 14
circle_area(14)