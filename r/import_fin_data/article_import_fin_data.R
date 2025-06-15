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


# getSymbols basics

# auto.assign argument

# auto.assign = TRUE
getSymbols("AAPL",
           src = "yahoo",
           from = "2025-01-01",
           to = "2025-05-31",
           auto.assign = TRUE)

# View the results
head(AAPL)


# auto.assign = FALSE
AAPL_2025 <- getSymbols("AAPL",
                        src = "yahoo",
                        from = "2025-01-01",
                        to = "2025-05-31",
                        auto.assign = FALSE)

# View the results
head(AAPL_2025)


# Environment
env_2025 <- new.env()


# Create data in the environment
getSymbols("AAPL",
           src = "yahoo",
           from = "2025-01-01",
           to = "2025-05-31",
           env = env_2025)

# View the results
head(env_2025$AAPL)


# --------------------------------------------



# Assess the data

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


# Set defaults




# --------------------------------------------


# Plot the data

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


