# Creating Functions in Python

# Create a function that calculates BMI
def bmi_cal(height, weight):
    # Calculate BMI
    bmi = weight / (height**2)

    # Return BMI (round to 2 decimals)
    return round(bmi, 2)

# Use the BMI calculator function
my_bmi = bmi_cal(height=1.8, weight=80)

# Print the result
print(my_bmi)


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
    bmi = weight / (height**2)

    # Return BMI (round to 2 decimals)
    return round(bmi, 2)


# Create a function with default arguments
def power(x, n=2):
    return x**n

# Call the function without n
print(power(5))

# Call the function with n
print(power(5, 3))


# Create a function using lambda
x = lambda a, b: a + b

# Call x
print(x(1, 1))

# Same as lambda
def x(a, b):
    return a + b