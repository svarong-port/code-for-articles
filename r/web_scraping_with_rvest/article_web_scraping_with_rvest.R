# Install and load the package
install.packages("rvest")
library(rvest)


# Load the page
url <- "https://books.toscrape.com/catalogue/sapiens-a-brief-history-of-humankind_996/index.html"

page <- read_html(url)

page


# Extract the book title
book_title <- page |>
  html_element("h1") |>
  html_text2()

book_title


# Extract the book description
book_description <- page |>
  html_element("#product_description + p") |>
  html_text2()

book_description


# Extract the book price
book_price <- page |>
  html_element(".price_color") |>
  html_text2()

book_price


# Extract the book image url
book_img_url <- page |>
  html_element(".thumbnail img") |>
  html_attr("src")

book_img_url


# Extract the product info
book_info <- page |>
  html_element("table") |>
  html_table()

book_info