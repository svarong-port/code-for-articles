# Code for Handling Exceptions in Python

# Define function to process payment
def process_payment(amount):

    # Check for negative payment
    if amount <= 0:
        raise ValueError("Amount must be greater than zero.")

    # Check for large payment
    if amount > 10000:
        raise Exception("Payment gateway limit exceeded.")

# Set order amount
orders = {"Alex": -10,
          "Ben": 5000,
          "Carter": 20000,}

# Validate payment
for key in orders:

    # Print the customer's name
    print(f"{key}: {orders[key]}")

    # Try block
    try:
        print("Processing your payment ...")
        payment_success = process_payment(orders[key])

    # Exception block: value error
    except ValueError as ve:
        print(f"Payment failed: {ve}")

    # Exception block: exception
    except Exception as e:
        print(f"Something went wrong during payment: {e}")

    # Else block
    else:
        print("Payment successful! Your order is confirmed.")

    # Finally block
    finally:
        print("Thank you for shopping with us.")

    # Print divider
    print("-------------------------------------------------------")