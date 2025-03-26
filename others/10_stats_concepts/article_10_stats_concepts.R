library(ggplot2)


# ----------------------------------------------------------------------------



# NORMAL DISTRIBUTION

# Define mean and standard deviation
mean_value <- 0
sd_value <- 1

# Create data for the normal distribution curve
x_values <- seq(mean_value - 4*sd_value, mean_value + 4*sd_value, length = 1000)
y_values <- dnorm(x_values, mean = mean_value, sd = sd_value)

# Create a data frame
df <- data.frame(x = x_values, y = y_values)

# Plot the normal distribution
ggplot(df, aes(x, y)) +
  geom_line(size = 1) +
  
  # Shade the SD zones
  geom_area(data = subset(df, x >= mean_value - sd_value & x <= mean_value + sd_value), 
            aes(y = y), fill = "blue", alpha = 0.2) + # 34.1% for ±1 SD
  
  geom_area(data = subset(df, x >= mean_value + sd_value & x <= mean_value + 2*sd_value), 
            aes(y = y), fill = "red", alpha = 0.2) + # 13.6% for +1 to +2 SD
  
  geom_area(data = subset(df, x >= mean_value - 2*sd_value & x <= mean_value - sd_value), 
            aes(y = y), fill = "red", alpha = 0.2) + # 13.6% for -1 to -2 SD
  
  geom_area(data = subset(df, x >= mean_value + 2*sd_value & x <= mean_value + 3*sd_value), 
            aes(y = y), fill = "darkgreen", alpha = 0.2) + # 2.1% for +2 to +3 SD
  
  geom_area(data = subset(df, x >= mean_value - 3*sd_value & x <= mean_value - 2*sd_value), 
            aes(y = y), fill = "darkgreen", alpha = 0.2) + # 2.1% for -2 to -3 SD
  
  geom_area(data = subset(df, x >= mean_value + 3*sd_value | x <= mean_value - 3*sd_value), 
            aes(y = y), fill = "purple", alpha = 0.2) + # 0.1% for beyond ±3 SD
  
  
  # Add SD tick marks (dashed lines)
  geom_vline(xintercept = c(mean_value - 3*sd_value, mean_value - 2*sd_value, 
                            mean_value - sd_value, mean_value, mean_value + sd_value, 
                            mean_value + 2*sd_value, mean_value + 3*sd_value),
             linetype = "dashed", color = "black", alpha = 0.3) +
  
  
  # Add text annotations for SD zones
  annotate("text", x = mean_value - 0.5*sd_value, y = 0.28, label = "34%", color = "blue") +
  annotate("text", x = mean_value + 0.5*sd_value, y = 0.28, label = "34%", color = "blue") +
  
  annotate("text", x = mean_value - 1.5*sd_value, y = 0.19, label = "13%", color = "red") +
  annotate("text", x = mean_value + 1.5*sd_value, y = 0.19, label = "13%", color = "red") +
  
  annotate("text", x = mean_value - 2.5*sd_value, y = 0.05, label = "2%", color = "darkgreen") +
  annotate("text", x = mean_value + 2.5*sd_value, y = 0.05, label = "2%", color = "darkgreen") +
  
  annotate("text", x = mean_value - 3.5*sd_value, y = 0.02, label = "0.1%", color = "purple") +
  annotate("text", x = mean_value + 3.5*sd_value, y = 0.02, label = "0.1%", color = "purple") +
  
  
  # Horizontal lines for the 68%, 95%, and 99% areas
  geom_segment(aes(x = mean_value - sd_value, xend = mean_value + sd_value, y = -0.03, yend = -0.03), 
               color = "blue", size = 1) +  # 68% for ±1 SD
  geom_segment(aes(x = mean_value - 2*sd_value, xend = mean_value + 2*sd_value, y = -0.06, yend = -0.06), 
               color = "red", size = 1) +   # 95% for ±2 SD
  geom_segment(aes(x = mean_value - 3*sd_value, xend = mean_value + 3*sd_value, y = -0.09, yend = -0.09), 
               color = "darkgreen", size = 1) + # 99% for ±3 SD

  # Add annotations for the percentages
  annotate("text", x = mean_value, y = -0.015, label = "68%", color = "blue", size = 4, hjust = 0.5) + # 68% for ±1 SD
  annotate("text", x = mean_value, y = -0.045, label = "95%", color = "red", size = 4, hjust = 0.5) +  # 95% for ±2 SD
  annotate("text", x = mean_value, y = -0.075, label = "99%", color = "darkgreen", size = 4, hjust = 0.5) + # 99% for ±3 SD
  
  
  # Add annotations for the SD labels on the horizontal lines
  annotate("text", x = mean_value - sd_value, y = -0.04, label = "-1SD", color = "darkgrey", size = 4) + 
  annotate("text", x = mean_value + sd_value, y = -0.04, label = "+1SD", color = "darkgrey", size = 4) + 
  
  annotate("text", x = mean_value - 2*sd_value, y = -0.07, label = "-2SD", color = "darkgrey", size = 4) + 
  annotate("text", x = mean_value + 2*sd_value, y = -0.07, label = "+2SD", color = "darkgrey", size = 4) + 
  
  annotate("text", x = mean_value - 3*sd_value, y = -0.10, label = "-3SD", color = "darkgrey", size = 4) + 
  annotate("text", x = mean_value + 3*sd_value, y = -0.10, label = "+3SD", color = "darkgrey", size = 4) +

  
  # Labels and theme
  labs(title = "Area in Normal Distribution",
       x = "",
       y = "") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme_classic()



# ----------------------------------------------------------------------------



# SAMPLING DISTRIBUTION
# Set parametres
set.seed(13)
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
  geom_histogram(binwidth = 0.5, color = "black", alpha = 0.5) +
  facet_wrap(~samples, scales = "free_y") +
  labs(title = "Sampling Distributions (Sample Size = 30)",
       x = "Sample Mean",
       y = "Frequency") +
  theme_classic() +
  theme(legend.position = "none")