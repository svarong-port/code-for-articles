# Code for Working With API With httr2

# Install and load packages

# Install
install.packages("httr2")

# Library
library(httr2)


# ---------------------------------------------


# 1. GET method

# Define base URL
base_url <- "https://fakestoreapi.com"


# Build a request
get_req <- request(base_url) |>
  
  # Add endpoint
  req_url_path_append("products")


# Dry run the request
get_req |> req_dry_run()

# Perform the request
get_resp <- get_req |> req_perform()

# View response status
get_resp |> resp_status()

# Check the response content type
get_resp |> resp_content_type()

# Extract the content
products <- get_resp |> resp_body_json()

# View the first entry
head(products, n = 1)


# ---------------------------------------------


# 2. POST method

# Build a request
post_req <- request(base_url) |>
  
  # Add endpoint
  req_url_path_append("products") |>
  
  # Change method to POST
  req_method("POST") |>
  
  # Add body
  req_body_json(list(
    title = "Summer Sunglasses",
    price = 29.99,
    description = "One pair for all summers.",
    image = "https://unsplash.com/photos/sunglasses-beside-a-purse-LJqRUWr9V0w",
    category = "Accessory"
    ))

# Dry run the request
post_req |> req_dry_run()

# Perform the request
post_resp <- post_req |> req_perform()

# Check response status
post_resp |> resp_status()

# Extract the content
post_resp |> resp_body_json()


# ---------------------------------------------


# 3. PATCH

# Build a request
patch_req <- request(base_url) |>
  
  # Add endpoint
  req_url_path_append("products/1001") |>
  
  # Change method to PATCH
  req_method("PATCH") |>
  
  # Add body
  req_body_json(list(
    price = 59.99,
    description = "Limited edition: One pair for all summers."
  ))

# Dry run the request
patch_req |> req_dry_run()

# Perform the request
patch_resp <- patch_req |> req_perform()

# Check response status
patch_resp |> resp_status()

# Extract the content
patch_resp |> resp_body_json()


# ---------------------------------------------


# 4. DELETE

# Build a request
delete_req <- request(base_url) |>
  
  # Add endpoint
  req_url_path_append("products/1001") |>
  
  # Change method to DELETE
  req_method("DELETE")

# Dry run the request
delete_req |> req_dry_run()

# Perform the request
delete_resp <- delete_req |> req_perform()

# Check response status
delete_resp |> resp_status()

# Extract the content
delete_resp |> resp_body_json()