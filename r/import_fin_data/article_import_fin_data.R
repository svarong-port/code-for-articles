# Code for Importing Financial Data in R

# Install the packages
install.packages("quantmod")
install.packages("ggplot2")

# Load the packages
library(quantmod)
library(ggplot2)


# ---------------------------------------------------


# 1. getSymbols() Basics

# 1.1 Symbols

# 1.1.1 Load single instrument
getSymbols("AAPL")

# Print result
head(AAPL)

# 1.1.2 Load multiple instruments
getSymbols(c("AAPL", "GOOGL", "MSFT", "NVDA"))

# Print result
head(AAPL)

# 1.2 src

# 1.2.1 Load data from online source
getSymbols("AAPL", src = "FRED")

# Print result
head(AAPL)

# 1.2.2 Load csv data
getSymbols("AAPL", src = "csv")

# Print result
head(AAPL)


# 1.3 auto.assign

# 1.3.1 Set to FALSE to assign to custom variable
apple_data <- getSymbols("AAPL", auto.assign = FALSE)

# 1.3.2 Set to FALSE without variable assignment
getSymbols("AAPL", auto.assign = FALSE)

# 1.4 new.env

# 1.4.1 Create a local environment to store data

# Create a new environment
my_env <- new.env()

# Load data into the environment
getSymbols("AAPL", env = my_env)

# List all variables in environment
ls(envir = my_env)

# Show Apple data
head(my_env$AAPL)

# 1.5 from, to
apple_data_2025_05 = getSymbols("AAPL",
                                auto.assign = FALSE,
                                from = "2025-05-01",
                                to = "2025-05-31")

# Print results
print("First three records:")
head(apple_data_2025_05, n = 3)
print("------------------------------------------------------------------------------")
print("Last three records:")
tail(apple_data_2025_05, n = 3)


# ---------------------------------------------------


# 2. Set defaults

# 2.1 Set and get defaults for getSymbols()

# Get defaults before changing
print("Defaults (before):")
getDefaults(getSymbols)

# Set defaults
setDefaults(getSymbols,
            src = "FRED",
            auto.assign = FALSE)

# Check defaults after changing
print("Defaults (after):")
getDefaults(getSymbols)

# Reset defaults
setDefaults(getSymbols, 
            src = NULL,
            auto.assign = NULL)

# Check defaults after resetting
getDefaults(getSymbols)


# 2.2 Set and get defaults for specific instrument

# Set default for Google
setSymbolLookup(GOOG = list(src = "google"))

# Get new defaults
getSymbolLookup()

# Reset defaults
setSymbolLookup(GOOG = NULL)

# Get defaults after resetting
getSymbolLookup()


# 2.3 Save and load defaults

# Save defaults
saveSymbolLookup(file = "symbols.rds")

# Load defaults
loadSymbolLookup(file = "symbols.rds")


# ---------------------------------------------------


# 3. View specific columns

# 3.1 Opening price
Op(AAPL)

# 3.2 Highest price
Hi(AAPL)

# 3.3 Lowest price
Lo(AAPL)

# 3.4 Closing price
Cl(AAPL)

# 3.5 Adjusted price
Ad(AAPL)

# 3.6 Volume
Vo(AAPL)

# 3.7 All price
OHLC(AAPL)


# ---------------------------------------------------


# 4. Plotting

# 4.1 autoplot()
autoplot(Cl(AAPL),
         ts.colour = "darkgreen") +
  
  # Add text
  labs(title = "AAPL Closing Price (Jan 2007 – Jun 2025)",
       x = "Time",
       y = "Price (USD)")

# 4.2 chartSeries()
chartSeries(Cl(AAPL))