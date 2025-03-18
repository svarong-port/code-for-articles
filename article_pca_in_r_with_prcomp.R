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

## Plot a biplot
biplot(pca)

## Plot a scree plot

### Extract variance explained
pca_var <- pca$sdev^2
pca_var_exp <- pca_var / sum(pca_var)

### Plot
plot(pca_var_exp,
     type = "b", col = "red", pch = 19, lwd = 2,
     main = "PCA Scree Plot",
     xlab = "Number of Principal Components",
     ylab = "Proportion of Variance Explained")