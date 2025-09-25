# Creating Functions in Python


# 1. def syntax

# Create a function that calculates BMI
def bmi_cal(height, weight):
    # Calculate BMI
    bmi = weight / (height ** 2)

    # Return BMI (round to 2 decimals)
    return round(bmi, 2)

# Use the BMI calculator function
my_bmi = bmi_cal(height=1.8, weight=80)

# Print the result
print(my_bmi)


# ----------------------------------------------------


# 2. Docstring

# Using incorrect input
wrong_bmi = bmi_cal(height=180, weight=80)

# Print the result
print(wrong_bmi)

# Adding docstring to the function
def bmi_cal(height, weight):
    # Docstring
    """
    Calculate BMI using height and weight:
    - height: metre
    - weight: kg
    """

    # Calculate BMI
    bmi = weight / (height ** 2)

    # Return BMI (round to 2 decimals)
    return round(bmi, 2)

# ----------------------------------------------------


# 3. Arguments

# 3.1 Default arguments

# Create a function with default arguments
def power(x, n=2):
    return x ** n

# Call the function without n
print(power(5))

# Call the function with n
print(power(5, 3))


# 3.2 Arbitary arguments

# *args

# Create a function calculate total price
def total_price(*prices):
    return sum(prices)

# Examples
print(f"Basket 1: {total_price(500, 1000)}")
print(f"Basket 2: {total_price(100, 200, 300)}")


# **kargs

# Create a function to return user's data
def user_profile(**user_data):
    return user_data
        
# Examples
print(f"User 1: {user_profile(name='John')}")
print(f"User 2: {user_profile(name='Jane', gender='F', age=20)}")


# ----------------------------------------------------


# 4. lambda

# Create a function using lambda
x = lambda a, b: a + b

# Call x
print(x(1, 1))


# Same as lambda
def x(a, b):
    return a + b