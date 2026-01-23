# Web Scraping with Beautiful Soup


# Import packages
import requests
import bs4


# -----------------------------------------------------------------------------------------------


# Get the web page

# Set the URL
url = "https://books.toscrape.com/catalogue/sapiens-a-brief-history-of-humankind_996/index.html"

# Get the response
response = requests.get(url)

# Encode the response
response.encoding = "utf-8"

# Print the status code
print(response.status_code)


# -----------------------------------------------------------------------------------------------


# Parse the HTML with bs4

# Create soup
soup = bs4.BeautifulSoup(response.text, "html.parser")

# Print the first 1,000 characters
print(soup.prettify()[:1000])


# -----------------------------------------------------------------------------------------------


# Get the book title
title = soup.find("h1").get_text()

# Print the title
print(title)


# -----------------------------------------------------------------------------------------------


# Get the img tag
img_tag = soup.find("img")

# Extract the src attribute
image_relative_url = img_tag.get("src")

# Set base URL
base_url = "https://books.toscrape.com/"

# Concatenate the image URL
image_full_url = base_url + image_relative_url.replace("../", "")

# Print the image
print(image_full_url)


# -----------------------------------------------------------------------------------------------


# Get the price
price = soup.find("p", class_="price_color").get_text()

# Print the price
print(price)


# -----------------------------------------------------------------------------------------------


# Get the product description header
description_header = soup.find("div", id="product_description")

# Get the product description
description = description_header.find_next_sibling("p").get_text()

# Print the description
print(description)


# -----------------------------------------------------------------------------------------------


# Get the product information

# Instantiate an empty dict
product_info = {}

# Get the product info table
product_info_table = soup.find("table", class_="table table-striped")

# Print the table
print(product_info_table)

# Loop through the rows
for row in product_info_table.find_all("tr"):

    # Get the label
    key = row.find("th").get_text()

    # Get the value
    value = row.find("td").get_text()

    # Append to product_info
    product_info[key] = value

# Print the product info
print(product_info)