# Code for Importing Data With DBI

# Install and load packages

# Install
install.packages("DBI")
install.packages("RSQLite")

# Load
library("DBI")
library("RSQLite")


# --------------------------------------------------------------


# Connect to database
con <- dbConnect(RSQLite::SQLite(),
                 "chinook.sqlite")


# List tables in the database
dbListTables(con)

# List columns in a table
dbGetQuery(con,
           "PRAGMA table_info(Artist)")

# List columns in all tables

# Get the table list
tables <- dbListTables(con)

# Get all columns
for (table_name in tables) {
  
  # Print the table name
  message(paste0("\n👉 Table: ", table_name))
  
  # Get the columns
  column_info <- dbGetQuery(con,
                            paste0("PRAGMA table_info(",
                                   table_name, 
                                   ")"))
  
  # Print the columns
  print(column_info)
}

# Query with dbReadTable()
dbReadTable(con,
            "Genre")


# Query with dbGetQuery()

# Example 1
dbGetQuery(con,
           "SELECT
              CustomerId,
              FirstName,
              LastName, Email
            FROM
              Customer
            WHERE
              country = 'Brazil';")

# Example 2
dbGetQuery(con,
           "SELECT
              BillingCountry,
              SUM(Total) AS TotalSales
            FROM
              Invoice
            GROUP BY
              BillingCountry
            ORDER BY
              TotalSales DESC;")

# Example 3
dbGetQuery(con,
           "SELECT
              T.Name AS TrackName,
              A.Title AS AlbumTitle
            FROM
              Track AS T
            JOIN
              Album AS A ON T.AlbumID = A.AlbumID
            LIMIT 10;")


# Query with dbSendQuery()

# Send query
res <- dbSendQuery(con,
                   "SELECT
                      CustomerId,
                      LastName,
                      FirstName,
                      Email
                    FROM
                      Customer
                    ORDER BY
                      LastName
                    LIMIT 10;")

# Fetch all
dbFetch(res)


# Send query
res <- dbSendQuery(con,
                   "SELECT
                      CustomerId,
                      LastName,
                      FirstName,
                      Email
                    FROM
                      Customer
                    ORDER BY
                      LastName
                    LIMIT 10;")

# Fetch five, thrice
dbFetch(res, n = 5)
dbFetch(res, n = 5)
dbFetch(res, n = 5)

# Clear results
dbClearResult()

# Close the connection
dbDisconnect(con)