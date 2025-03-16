# Code for Hierarchical Cluster Analysis (HCA) With hclust()

# Step 1. Load the dataset

## Load
data(USArrests)

## Preview
head(USArrests)


# -------------------------------------------------


# Step 2. Normalise the data

## Perform z-score standardisation
USArrests_scaled <- scale(USArrests)

## Check the results

### Mean
round(colMeans(USArrests_scaled), 2)

### SD
apply(USArrests_scaled, 2, sd)


# -------------------------------------------------


# Step 3. HCA

## Create a distance matrix
dm <- dist(USArrests_scaled)

## HCA
hc <- hclust(dm,
             method = "ward.D2")


# -------------------------------------------------


# Step 4. Check the results

## Print HCA
print(hc)

## Plot a dendrogram
plot(hc,
     hang = -1,
     cex = 0.8,
     main = "Dendrogram of USArrests Data")


# -------------------------------------------------


# Dendrogram example

## Load necessary library
set.seed(123)  # Ensure reproducibility

## Step 1: Create a simple dataset (fake customer data)
customers <- data.frame(
  Name = c("Alice", "Bob", "Charlie", "David", "Eve", "Frank", "Grace", "Henry", "Ivy", "Jack"),
  Spending = c(2, 3, 5, 8, 7, 6, 4, 9, 10, 1),
  Transactions = c(10, 12, 25, 40, 35, 30, 18, 50, 55, 8)
)

## Step 2: Compute the Euclidean distance matrix
dist_matrix <- dist(customers[, c("Spending", "Transactions")], # only use numerical columns
                    method = "euclidean")

## set names for distance matrix
attr(dist_matrix, "Labels") <- customers$Name

# Step 3: Perform hierarchical clustering using Ward's method
hc_ex <- hclust(dist_matrix,
                method = "ward.D2")

## Step 4: Plot the dendrogram
plot(hc_ex,
     hang = -1,
     cex = 1,
     main = "Customer Segmentation Dendrogram")