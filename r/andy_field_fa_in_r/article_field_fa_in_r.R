# Code from Discovering Statistics With R by Andy Field

# Note: Follow along = pp. 772-785

# Install the packages
install.packages(tidyverse)
install.packages(corpcor)
install.packages(psych)
install.packages(lavaan)

# Load the packages
library(tidyverse)
library(corpcor)
library(psych)
library(lavaan)


# ------------------------------------------------------------


# Load the dataset

#Define raw data URL
raq_raw <- "https://raw.githubusercontent.com/profandyfield/discovr/refs/heads/master/data-raw/csv_files/raq.csv"

# Load the dataset
raq <- read_csv(raq_raw)

# Preview the dataset
head(raq)

# View the structure
glimpse(raq)

# Drop `id`
raq <- raq |>
  select(-1)

# Check the results
glimpse(raq)


# ------------------------------------------------------------


# Get a correlation matrix
raq_matrix <- cor(raq)

# View the matrix
round(raq_matrix, 2)

# Run Bartlett’s test
cortest.bartlett(raq_matrix,
                 n = 2571)

# Find KMO
KMO(raq)

# Find the determinants of the correlation matrix
det(raq_matrix)


# ------------------------------------------------------------


# Perform a PCA
pc1 <- principal(raq_matrix,
                 nfactors = 23,
                 rotate = "none")

# Print the results
pc1

# Create a scree plot
plot(pc1$values,
     type = "b")

# Note: The plot suggests 5 factors.

# Perform another PCA
pc2 <- principal(raq_matrix,
                  nfactors = 5,
                  rotate = "none")

# Print the results
pc2


# ------------------------------------------------------------


# Reproduce the correlation matrix
factor.model(pc2$loadings)

# Find the differences between the initial and reproduced correlation matrix
factor.residuals(raq_matrix,
                 pc2$loadings)