# Variables

## assigment
x <- 10
print(x)


## numeric
age <- 10
print(age)


## character
name <- "Ben Tennyson"
print(name)


## logical
is_hero <- TRUE
print(is_hero)


## date
date_of_birth <- as.Date("1995-12-27")
print(date_of_birth)


## factor
gender <- as.factor("Male")
print(gender)


## check class
class(age)


# ------------------------------


# Data structures

## vector
v <- c(1, 3, 5, 7, 9)
print(v)


## matrix
m <- matrix(1:9, ncol = 3)
print(m)


## array
a <- array(1:24, dim = c(4, 3, 2))
print(a)


## list
grocery_list = list("apple",
                    "milk",
                    TRUE,
                    250,
                    c(1, 3, 5, 7, 9),
                    list("Walmart", "Target"))
print(grocery_list)


## data frame
groceries <- data.frame(
  Item = c("Apples", "Carrots", "Milk"),
  Category = c("Fruit", "Vegetable", "Dairy"),
  Quantity = c(5, 2, 1),
  Price = c(1.50, 0.75, 2.50)
)
print(groceries)



# ------------------------------


# Operators

## assignment
my_name <- "John"


## arithmetic
3 + 4


## logical
!TRUE


## relational
15 > 11



# ------------------------------


# Function

## built-in
print("Hello, World!")


## user-defined
greeting <- function(name) {
  print(paste("Hello", name))
}
greeting("John")