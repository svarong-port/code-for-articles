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
       col = 1:4,
       pch = 4,
       cex = 2,
       lwd = 2)