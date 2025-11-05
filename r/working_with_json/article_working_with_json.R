# Working with JSON in R

# Install jsonlite
install.packages("jsonlite")

# Load jsonlite
library(jsonlite)



# 1. JSON to R: fromJSON()

# Create a JSON string
snacks_json_string <- '
[
  {
    "snack_name": "Corn Chips",
    "brand": "Nibble & Dip",
    "price_usd": 2.99,
    "is_vegan": true
  },
  {
    "snack_name": "Pita Chips",
    "brand": "DipMates",
    "price_usd": 4.25,
    "is_vegan": false
  },
  {
    "snack_name": "Tortilla Chips",
    "brand": "Casa Crunch",
    "price_usd": 3.49,
    "is_vegan": true
  }
]
'

# Convert to R object
snacks_r_obj <- fromJSON(snacks_json_string)

# View the df
snacks_r_obj



# 2. R to JSON: toJSON()

# Create a data frame
snacks_df <- data.frame(
  snack_name = c("Seaweed Thins", "Chickpea Puffs", "BBQ Potato Crisps"),
  brand      = c("OceanBite", "LegumeLab", "Spud & Spark"),
  price_usd  = c(2.45, 3.35, 3.10),
  is_vegan   = c(TRUE, TRUE, FALSE),
  stringsAsFactors = FALSE
)

# Convert to JSON
snacks_json_string <- toJSON(snacks_df, pretty = TRUE)

# View the JSON
snacks_json_string



# 3. Read JSON: read_json()

# Read JSON
snacks_from_json_file <- read_json("snacks.json")

# View the df
snacks_from_json_file



# 4. Write to JSON: write_json()

# Create a list
snacks_list <- data.frame(
  snack_name = c("Cassava Chips", "Lentil Crisps", "Cheese Puffs"),
  brand      = c("RootRush", "Pulse & Crunch", "CheezyPop"),
  price_usd  = c(2.85, 2.65, 3.99),
  is_vegan   = c(TRUE, TRUE, FALSE),
  stringsAsFactors = FALSE
)

# Write to JSON
write_json(snacks_list,
           "snacks_list.json", 
           pretty = TRUE)