# Code for Working With Excel in R

# Install and load packages

# Install
install.packages("XLConnect")
install.packages("rJava")
install.packages("dplyr")

# Set JAVA
Sys.setenv(JAVA_HOME = "C:/Program Files/Java/jre1.8.0_451")

Sys.setenv(PATH = paste(Sys.getenv("PATH"),
                        "C:/Program Files/Java/jre1.8.0_451/bin",
                        sep = ";"))

# Load
library(XLConnect)
library(rJava)
library(dplyr)


# -------------------------------------------


# Load Excel
workbook <- loadWorkbook("Daily Household Transactions.xlsx")

# List sheets
getSheets(workbook)


# -------------------------------------------


# Get sheet data
sheet1_data <- readWorksheet(workbook,
                             sheet = "All Transactions")

# Print data
head(sheet1_data)


# -------------------------------------------


# Create a new sheet
createSheet(workbook,
            name = "New")

# List sheets
getSheets(workbook)

# Rename the new sheet
renameSheet(workbook,
            sheet = "New",
            newName = "Expense by Catogory")

# List sheets
getSheets(workbook)


# -------------------------------------------


# Add data to the new sheet

# Calculate expense by category
expense_by_cat <- sheet1_data |>
  
  # Filter for expense
  filter(Income.Expense == "Expense") |>
  
  # Group by category
  group_by(Category) |>
  
  # Calculate sum amount
  summarise(Sum = sum(Amount)) |>
    
  # Ungroup
  ungroup() |>
  
  # Sort by category
  arrange(desc(Sum))

# View the results
expense_by_cat

# Add data to "Expense by Catogory" sheet
writeWorksheet(workbook,
               data = expense_by_cat,
               sheet = "Expense by Catogory")


# -------------------------------------------


# Delete sheet
removeSheet(workbook,
            sheet = "All Transactions")

# List sheets
getSheets(workbook)


# -------------------------------------------


# Save the file
saveWorkbook(workbook,
             file = "Expense Summary.xlsx")