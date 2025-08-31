# if, for, while in Python

# 1. Comparison operators

# True statement
10 > 5

# False statement
10 < 5

# True and True
1 == 1 and 2 < 4


# --------------------------------------------


# 2. Conditional statements

# Weather today
weather = "snowy"

# Print when sunny
if weather == "sunny":
    print("It's a sunny day. Don't forget your sunscreen!")

# Print when rainy
elif weather == "rainy":
    print("It's raining. Remember to bring an umbrella!")

# Print when other conditions
else:
    print("Likely chilly. Wear a jacket!")


# --------------------------------------------


# 3. Control flow statements

# 3.1 for loop

# Guest list
guests = ["James Bond", "John Wick", "Jack Reacher", "Jason Bourne", "Jack Ryan"]

# Print guest names
for name in guests:
    # Print name
    print(name)


# 3.2 while loop

# Starting number
number = 1

# Count to 10
while number <= 10:
    # Print number
    print(number)

    # Add 1 to number
    number += 1


# --------------------------------------------


# 4. Loop control statements

# A shopping list program
shopping_list = ["milk", "bread", "chips", "apple", "toothpaste", "chocolate"]

# Loop through the list
for item in shopping_list:

    # Skip item if chip
    if item == "chips":
        print("Chips are unhealthy. Skipping ...")
        continue

    # Stop the loop if toothpaste
    if item == "toothpaste":
        print("Found toothpaste, done shopping early!")
        break

    # Do nothing if milk
    if item == "milk" or item == "bread":
        pass

    # Print item
    print("Putting", item, "into the cart.")