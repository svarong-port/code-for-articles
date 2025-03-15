# Code for k-Means Model in R with kmeans()


# Step 1. Load the dataset

## Load
data(rock)

## Preview the dataset
head(rock)

## View the structure of the dataset
str(rock)


# ---------------------------------------------


# Step 2. Normalise the data

## Scale
rock_scaled <- scale(rock)

## Check the results
summary(rock_scaled)


# ---------------------------------------------


# Step 3. Find the optimal k

## Initialise a vector for within cluster sum of squares (wss)
wss <- numeric(15)

## For-loop through the wss
for (k in 1:15) {
  
  ## Try the k
  km <- kmeans(rock_scaled,
               centers = k,
               nstart = 20)
  
  ## Get WSS for the k
  wss[k] <- km$tot.withinss
}

## Plot the wss
plot(1:15,
     wss,
     type = "b",
     main = "The Number of Clusters vs WSS",
     xlab = "Number of Clusters",
     ylab = "WSS")

## Set optiomal k = 4
opt_k <- 4


# ---------------------------------------------


# Step 4. Train the model

## Set see for reproducibility
set.seed(500)

## Train the model
km <- kmeans(rock_scaled,
             centers = opt_k,
             nstart = 20)

## Print the model
print(km)

## Print the table
table(km$cluster)


# ---------------------------------------------


# Step 5. Visualise the clusters

## Create a plot
plot(rock_scaled[, c("shape", "perm")], 
     col = km$cluster,
     pch = 19,
     main = "K-Means Clustering (Rock Dataset)",
     xlab = "Shape",
     ylab = "Permeability")

## Add cluster centers
points(km$centers[, c("shape", "perm")], 
       col = 1:5,
       pch = 4,
       cex = 2,
       lwd = 2)



# ---------------------------------------------



# Visualisation code for k-means steps

## Load packages
library(ggplot2)
library(dplyr)

## Step 1: Generate a sample dataset
set.seed(42)
n_points <- 30
df <- data.frame(x = rnorm(n_points, mean = 5, sd = 2),
                 y = rnorm(n_points, mean = 5, sd = 2))

## Plot Step 1: Original data distribution
p1 <- ggplot(df, aes(x, y)) +
  geom_point() +
  ggtitle("Data for Clustering (n = 30)") +
  theme_classic()

print(p1)


## Step 2: Select k initial cluster centers at random
k <- 3
initial_centers <- df[sample(nrow(df), k), ]


## Plot Step 2: Initial cluster centers
p2 <- ggplot(df, aes(x, y)) +
  geom_point() +
  geom_point(data = initial_centers, aes(x, y), color = "red", size = 4, shape = 8) +
  ggtitle("Step 2: Randomly Place Centroids") +
  theme_classic()

print(p2)

## Step 3: Assign each point to the nearest cluster
assign_clusters <- function(df, centers) {
  df %>%
    rowwise() %>%
    mutate(cluster = which.min((x - centers$x)^2 + (y - centers$y)^2)) %>%
    ungroup()
}

df_assigned <- assign_clusters(df, initial_centers)

## Plot Step 3: Points colored by initial cluster assignment
p3 <- ggplot(df_assigned, aes(x, y, color = as.factor(cluster))) +
  geom_point() +
  geom_point(data = initial_centers, aes(x, y), color = "red", size = 4, shape = 8) +
  labs(title = "Step 3: Assign Data to Closest Centroids",
       color = "Clusters") +
  theme_classic()

print(p3)

## Step 4: Compute new centroids
update_centroids <- function(df) {
  df %>%
    group_by(cluster) %>%
    summarize(x = mean(x), y = mean(y), .groups = "drop")
}

new_centers <- update_centroids(df_assigned)

## Plot Step 4: Updated centroids
p4 <- ggplot(df_assigned, aes(x, y, color = as.factor(cluster))) +
  geom_point() +
  geom_point(data = new_centers, aes(x, y), color = "red", size = 5, shape = 8) +
  labs(title = "Step 4: Update Cluster Centroids",
       color = "Clusters") +
  theme_classic()

print(p4)


## Step 5: Repeat steps 3-4 until clusters don’t change
max_iter <- 10
centers <- initial_centers

for (i in 1:max_iter) {
  df_assigned <- assign_clusters(df, centers)
  new_centers <- update_centroids(df_assigned)
  
  # Stop if centroids do not change
  if (all(round(centers$x, 4) == round(new_centers$x, 4)) &&
      all(round(centers$y, 4) == round(new_centers$y, 4))) {
    break
  }
  
  centers <- new_centers
}

## Plot Step 5: Final cluster assignments and centroids
p5 <- ggplot(df_assigned, aes(x, y, color = as.factor(cluster))) +
  geom_point() +
  geom_point(data = centers, aes(x, y), color = "red", size = 5, shape = 8) +
  labs(title = "Step 5: Final Cluster Assignments and Centroids",
       color = "Clusters") +
  theme_classic()

print(p5)