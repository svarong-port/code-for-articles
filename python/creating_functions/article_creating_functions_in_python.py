# Creating Functions in Python


# 1. def syntax

# Create a function that calculates BMI
def calculate_bmi(weight, height):

    # Calculate BMI
    bmi = weight / (height ** 2)

    # Round to 2 decimals
    bmi_rounded = round(bmi, 2)

    # Return BMI
    return bmi_rounded

# Use the BMI calculator function
my_bmi = calculate_bmi(weight=80, height=1.8)

# Print the result
print(my_bmi)


# ----------------------------------------------------


# 2. Docstring

# Using incorrect input
wrong_bmi = calculate_bmi(height=180, weight=80)

# Print the result
print(wrong_bmi)

# Adding docstring to the function
def calculate_bmi(height, weight):

    # Docstring
    """
    Calculate BMI using weight and height:
    - Weight: kg
    - Height: m

    Return BMI rounded to 2 decimals
    """

    # Calculate BMI
    bmi = weight / (height ** 2)

    # Round to 2 decimals
    bmi_rounded = round(bmi, 2)

    # Return BMI
    return bmi_rounded

# ----------------------------------------------------


# 3. Arguments

# 3.1 Default arguments

# Create a function with default arguments
def calculate_power(number, power=2):

    # Calculate number to the power of power
    result = number ** power

    # Return result
    return result

# Call the function without power
print(calculate_power(5))

# Call the function with power
print(calculate_power(5, 3))


# 3.2 Arbitary arguments

# *args

# Create a function calculate total price
def calculate_total_price(*prices):

    # Calculate sum
    total = sum(prices)

    # Return total
    return total

# Examples
total_basket_01 = calculate_total_price(500, 1000)
total_basket_02 = calculate_total_price(100, 200, 300)

print(f"Basket 1: {total_basket_01}")
print(f"Basket 2: {total_basket_02}")


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
addition = lambda a, b: a + b

# Call addition
print(addition(1, 1))


# Same as lambda
def addition(a, b):
    return a + b