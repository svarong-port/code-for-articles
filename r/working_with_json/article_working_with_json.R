# Working with JSON in R

# Install jsonlite
install.packages("jsonlite")

# Load jsonlite
library(jsonlite)



# 1. JSON to R: fromJSON()

# Create a JSON string
json_string <- '
[
  {"Name": "Chocolate Bar", "Brand": "SweetNest", "Price": 40, "Type": "Milk"},
  {"Name": "Gummy Bears", "Brand": "BearBites", "Price": 35, "Type": "Fruit"},
  {"Name": "Marshmallow", "Brand": "Softy", "Price": 28, "Type": "Vanilla"}
]
'

# Convert to R object
candies_df <- fromJSON(json_string)

# View the df
candies_df



# 2. R to JSON: toJSON()

# Create a data frame
snacks_df <- data.frame(
  SnackID = 1:5,
  Name = c("Potato Chips", "Tortilla Chips", "Nachos", "Popcorn", "Pretzels"),
  Brand = c("CrispyCo", "TastyTreats", "NachoKing", "PopJoy", "Twist&Bite"),
  Flavor = c("Original", "Cheese", "Spicy Jalapeño", "Butter", "Salted"),
  Price = c(35.00, 40.00, 45.00, 30.00, 28.00),
  IsVegan = c(TRUE, TRUE, FALSE, TRUE, TRUE)
)

# Convert to JSON
snacks_json <- toJSON(snacks_df, pretty = TRUE)

# View the JSON
snacks_json



# 3. Read JSON: read_json()

# Read JSON
snack_box_df <- read_json("snack_box.json")

# View the df
snack_box_df



# 4. Write to JSON: write_json()

# Create a list
cookies <- list(
  list(Name = "Choco Chip", Brand = "CookieJar", Price = 50, Vegan = FALSE),
  list(Name = "Oatmeal", Brand = "HealthyBite", Price = 45, Vegan = TRUE)
)

# Write to JSON
write_json(cookies,
           "cookies.json", 
           pretty = TRUE)