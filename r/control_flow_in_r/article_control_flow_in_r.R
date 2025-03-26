# Code for Control Flow in R

## If-else

score <- 71

### if
if (score >= 60) {
  print("Pass")
}

### else
if (score >= 60) {
  print("Pass")
} else {
  print("Fail")
}

### else if
if (score >= 90) {
  print("A")
} else if (score >= 80) {
  print("B")
} else if (score >= 70) {
  print("C")
} else if (score >= 60) {
  print("D")
} else {
  print("F")
}


# -----------------------------


## Loops

### for
friends <- c("John",
             "Sarah", 
             "Emma",
             "Mike")

for (friend in friends) {
  print(paste("Hello,", friend))
}


### while
set.seed(42)

roll <- sample(1:6, 1)

while (roll != 6) {
  print(paste("Rolled:", roll, "Not yet..."))
  roll <- sample(1:6, 1)
}

print("You rolled a 6! Congratulations!")


# -----------------------------


## Flow control

### next
colours <- c("🟢", "🔴", "🔵", "🔴", "🟠", "🟢")

for (colour in colours) {
  if (colour == "🔴" | colour == "🟠") next
  print(colour)  
}


### break
time <- 10  # Start countdown

while (time > 0) {
  print(paste("Counting down:", time))
  time <- time - 1
}


time <- 10  # Start countdown

while (time > 0) {
  if (time == 4) {
    print("Countdown stopped.")
    break
  }
  print(paste("Counting down:", time))
  time <- time - 1
}
