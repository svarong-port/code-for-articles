# Code for Importing Financial Data in R

# Install the package
install.packages("quantmod")
install.packages("ggplot2")

# Load the package
library(quantmod)
library(ggplot2)


# ---------------------------------------------------


# 1. getSymbols() Basics

# 1.1 src

# 1.1.1 Load data from online source
getSymbols("AAPL", src = "yahoo")

# Print result
head(AAPL)

# 1.1.2 Load csv data
getSymbols("AAPL", src = "csv")

# Print result
head(AAPL)


# 1.2 auto.assign

# 1.2.1 Set to FALSE to assign to custom variable
aapl_data <- getSymbols("AAPL",
                        src = "csv",
                        auto.assign = FALSE)

# 1.3 new.env

# 1.3.1 Create a local environment to store data

# Create a new environment
my_env <- new.env()

# Load data onto environment
getSymbols("AAPL",
           src = "csv",
           env = my_env)

# List all variables in environment
ls(envir = my_env)

# Show data
head(my_env$AAPL)


# ---------------------------------------------------


# 2. View specific columns

# 2.1 Opening price
Op(AAPL)

# 2.2 Highest price
Hi(AAPL)

# 2.3 Lowest price
Lo(AAPL)

# 2.4 Closing price
Cl(APPL)

# 2.5 Adjusted price
Ad(AAPL)

# 2.6 Volume
Vo(AAPL)

# 2.7 All price
OHLC(AAPL)


# ---------------------------------------------------


# 3. Plotting

# 3.1 autoplot()
autoplot(Cl(AAPL),
         ts.colour = "darkgreen") +
  
  # Set theme to minimal
  theme_minimal() +
  
  # Add text
  labs(title = "AAPL Closing Price (USD)",
       x = "Time",
       y = "Price (USD)")

# 3.2 chartSeries()
chartSeries(Cl(AAPL))


# ---------------------------------------------------


# 4. Set defaults

# 4.1 Set and get defaults for getSymbols()

# Get defaults
getDefaults(getSymbols)

# Set defaults
setDefaults(getSymbols,
            src = "yahoo",
            auto.assign = FALSE)

# Check defaults
getDefaults(getSymbols)

# 4.2 Set and get defaults for specific instrument

# Set default for Google
setSymbolLookup(GOOG = list(src = "google"))

# Get default
getSymbolLookup()

# 4.3 Save and load defaults

# Save defaults
saveSymbolLookup(file = "symbols.rds")

# Load defaults
loadSymbolLookup(file = "symbols.rds")


# ---------------------------------------------------


# 5. Aggregating

# 5.1 Fixed interval
monthly_data <- apply.monthly(Cl(AAPL),
                              FUN = mean)

# 5.2 Custom interval

# Creat end points
end_points <- endpoints(Cl(AAPL),
                        on = "weeks")

# Calculate
weekly_avg <- period.apply(Cl(AAPL),
                           INDEX = end_points,
                           FUN = mean)


# ---------------------------------------------------


# 6. Adjust price

# 6.1 Auto-adjust
adjusted_price_auto <- adjustOHLC(AAPL)

# Print result
head(adjusted_price_auto)

# 6.2 Manually

# Get splits
splits <- getSplits("AAPL")

# Get dividends
dividends <- getDividends("AAPL", split.adjust = FALSE)

# Get adjust ratios
adj_ratios <- adjRatios(splits,
                        dividends,
                        Cl(APPL))

# Calculate adjusted price
adjusted_price_manual <- Cl(AAPL) * adj_ratios[, "Split"] * adj_ratios[, "Div"]

# Print result
head(adjusted_price_manual)

# Print adjusted price
head(Ad(AAPL))


# ---------------------------------------------------


# 7. Fill NA

# 7.1 Check for NA
colSums(is.na(AAPL))

# 7.2 LOCF
aapl_locf <- na.locf(AAPL)

# 7.3 spline
aapl_spline <- na.spline(AAPL)

# 7.4 approx
aapl_approx <- na.approx(AAPL)