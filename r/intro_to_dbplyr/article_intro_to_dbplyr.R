# Code for dbplyr Article


# Install packages
install.packages("DBI")
install.packages("RSQLite")
install.packages("dplyr")
install.packages("dbplyr")

# Load packages
library(DBI)
library(RSQLite)
library(dplyr)
library(dbplyr)


# Connect to database
con <- dbConnect(RSQLite::SQLite(),
                 "chinook.sqlite")

# View all tables
dbListTables(con)


# Create lazy tibble
tracks <- tbl(con,
              "Track")

# View tibble
tracks


# Create query
album_info <- tracks |>
  
  # Group by album
  group_by(AlbumId) |>
  
  # Summarise
  summarise(
    
    # Number of tracks
    tracks = n(),
    
    # Average duration
    mean_millisec = mean(Milliseconds,
                         na.rm = TRUE),
    
    # Total size
    total_bytes = sum(Bytes)
  ) |>
  
  # Sort by duration
  arrange(desc(mean_millisec))


# Show query
show_query(album_info)


# Get result
album_info_tb <- collect(album_info)

# View the result
album_info_tb


# Disconnect from database
dbDisconnect(con)