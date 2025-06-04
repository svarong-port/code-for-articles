# Code for Importing Financial Data in R

# Install the package
install.packages("quantmod")
install.packages("ggplot2")
install.packages("ggfortify")

# Load the package
library(quantmod)
library(ggplot2)
library(ggfortify)


# --------------------------------------------


# Get Apple symbol
getSymbols("AAPL",
           src = "yahoo",
           from = "2025-01-01",
           to = "2025-05-31")

# View Apple data
AAPL

# Get adjusted price
Ad(AAPL)

# Get high price
Hi(AAPL)

# Get low price
Lo(AAPL)

# Get opening price
Op(AAPL)

# Get closing price
Cl(AAPL)

# Get volumne
Vo(AAPL)


# --------------------------------------------


# Plot all Apple data
autoplot(AAPL,
         ts.colour = "darkblue") +
  
  ## Add title and labels
  labs(title = "Apple Stock Data (Jan–May 2025)",
       x = "Time") +
  
  ## Set minimal theme
  theme_minimal()


# Plot multiple columns
autoplot(AAPL,
         columns = c("AAPL.Low", "AAPL.High"),
         facet = FALSE) +
  
  ## Add title and labels
  labs(title = "Apple Stock Low & High Price (Jan–May 2025)",
       x = "Date",
       y = "Price") +
  
  ## Set minimal theme
  theme_minimal()


# Plot a specific column
autoplot(AAPL,
         columns = "AAPL.High",
         ts.colour = "darkblue") +
  
  ## Add title and labels
  labs(title = "Apple Stock High Price (Jan–May 2025)",
       x = "Date",
       y = "Price") +
  
  ## Set minimal theme
  theme_minimal()


# --------------------------------------------


