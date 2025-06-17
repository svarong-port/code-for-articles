# Code for Handling Exceptions in Python

# Set payment
payment = "one thousand"

# 1. try, except
try:
    payment >= 0
except TypeError:
    print("Payment must be a number.")

# Set payment
payment = 500

# 2. else
try:
    payment >= 0
except TypeError:
    print("Payment must be a number.")
else:
    print("Processing payment ...")

# 3. finally
try:
    payment >= 0
except TypeError:
    print("Payment must be a number.")
else:
    print("Processing payment ...")
finally:
    print("Your order will be confirmed shortly.")

# 4. raise
try:
    payment = float(payment_input)
    if payment <= 0:
        raise ValueError("Payment must be greater than 0.")
except:
    TypeError("Payment must be a number.")
else:
    print("Processing payment ...")
finally:
    print("Thank you for your payment.")