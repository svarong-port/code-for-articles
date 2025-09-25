# Importing Files in Python


# Create a file
with open("example.txt", "x") as file:
    file.write("This is the first line.\n")
    file.write("This is the second line.\n")
    file.write("This is the third line.")

# Read a file - all
with open("example.txt", "r") as file:
    file.read()

# Read a file - one line at a time
with open("example.txt", "r") as file:
    file.readline()
    file.readline()
    
# Add content to a file
with open("example.txt", "a") as file:
    file.write("This is the fourth line.")

# Overwrite a file
with open("example.txt", "w") as file:
    file.write("This is all there is now.")