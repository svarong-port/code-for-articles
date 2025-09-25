# Importing Files in Python


# Create a file
with open("example.txt", "x") as file:
    file.write("This is the first line.\n")
    file.write("This is the second line.\n")
    file.write("This is the third line.")


# Read the file - all
with open("example.txt", "r") as file:
    file.read()

# Read the file - one line at a time
with open("example.txt", "r") as file:
    file.readline()
    file.readline()

# Read the file - line by line
with open("example.txt", "r") as file:
    
    # Loop through each line
    for line in file:
        print(line)
    
    
# Add content to the file
with open("example.txt", "a") as file:
    file.write("This is the fourth line.")


# Overwrite the file
with open("example.txt", "w") as file:
    file.write("This is all there is now.")


# Import os module
import os

# Delete the file
os.remove("example.txt")