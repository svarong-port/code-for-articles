# Code for PCA With prcomp()


# Install and load the package

# Install
install.packages("rattle")

# Load
library(rattle)


# -----------------------------------


# Load the dataset

## Load
data(wine)

## Preview
head(wine)

## View the structure
str(wine)


# -----------------------------------


# Perform PCA

## PCA
pca <- prcomp(wine[, -1],
              center = TRUE,
              scale. = TRUE)

## Print the results
summary(pca)

## Plot a scree plot

### Extract variance explained
pca_var <- pca$sdev^2
pca_var_exp <- pca_var / sum(pca_var)

### Compute cumulative variance explained
cum_var_exp <- cumsum(pca_var_exp)

### Plot a scree plot for cumulative variance explained
plot(cum_var_exp, 
     type = "b", col = "blue", pch = 19, lwd = 2,
     main = "Cumulative Variance Explained",
     xlab = "Number of Principal Components",
     ylab = "Cumulative Variance Explained",
     ylim = c(0, 1))