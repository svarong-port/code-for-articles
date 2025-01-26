library(ggplot2)

# Set parametres
set.seed(42)
population <- rnorm(10000, mean = 50, sd = 10)

# Function to calculate sample means
sample_means <- function(num_samples, sample_size) {
  replicate(num_samples, mean(sample(population, sample_size, replace = TRUE)))
}

# Generate sample means
means_10 <- sample_means(10, 30)
means_100 <- sample_means(100, 30)
means_1000 <- sample_means(1000, 30)

# Combine data for plotting
data <- data.frame(
  mean = c(means_10, means_100, means_1000),
  samples = factor(
    rep(c("10 Samples", "100 Samples", "1,000 Samples"), 
        times = c(length(means_10), length(means_100), length(means_1000))),
    levels = c("10 Samples", "100 Samples", "1,000 Samples") # Ensure correct order
  )
)

# Plot sampling distributions
ggplot(data, aes(x = mean, fill = samples)) +
  geom_histogram(binwidth = 0.5, color = "black", alpha = 0.7) +
  facet_wrap(~samples, scales = "free_y") +
  labs(title = "Sampling Distributions (Sample Size = 30)",
       x = "Sample Mean",
       y = "Frequency") +
  theme_minimal() +
  theme(legend.position = "none")