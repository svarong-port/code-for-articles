# Install ggplot2 (for data viz)
install.packages("ggplot2")

# Install dplyr (for data transformation)
install.packages("dplyr")


# ----------------------------------------


# Load ggplot2 and dplyr
library(ggplot2)
library(dplyr)


# ----------------------------------------


# Load and preview the dataset

## Load the dataset
tips <- read.csv("tips.csv")

## Preview the dataset
head(tips)


# ----------------------------------------



# Histogram: distribution of `tip` (default binwidth)
ggplot(tips, aes(x = tip)) +
  geom_histogram()

# Histogram: distribution of `tip` (binwidth = 1)
ggplot(tips, aes(x = tip)) +
  geom_histogram(binwidth = 1)


# ----------------------------------------


# Box plot: distribution of `tip` by `time`
ggplot(tips, aes(x = factor(time, levels = c("Lunch", "Dinner")), y = tip)) +
  geom_boxplot()


# ----------------------------------------


# Scatter plot: relationship between `tip` and `total_bill`
ggplot(tips, aes(x = total_bill, y = tip)) +
  geom_point()

# Scatter plot: relationship between `tip` and `total_bill` with a trend line
ggplot(tips, aes(x = total_bill, y = tip)) +
  geom_point() +
  geom_smooth(method = "lm")


# ----------------------------------------


# Line plot: `tip` vs `size`
ggplot(tips, aes(x = size, y = tip)) +
  geom_line()

# Line plot: fix the plot by calculating mean for `tip` by `size`

## Calculate mean for each `size`
tips_by_size <- tips |>
  group_by(size) |>
  summarise(tip_mean = mean(tip))

## Create the plot                
ggplot(tips_by_size, aes(x = size, y = tip_mean)) +
  geom_line()

# ----------------------------------------


# Bar plot: `tip` by `day`
ggplot(tips, aes(x = factor(day, levels = c("Thur", "Fri", "Sat", "Sun")), y = tip)) +
  geom_col()

# Bar plot with mean sleep hours

## Calculate mean sleep hours
tips_by_day <- tips |>
  group_by(day) |>
  summarise(tip_mean = mean(tip))

## Create a bar plot
ggplot(tips_by_day, aes(x = factor(day, levels = c("Thur", "Fri", "Sat", "Sun")), y = tip_mean)) +
  geom_col()


# ----------------------------------------


# Adding a third variable: `tip` vs `total_bill` with `size` as size
ggplot(tips, aes(x = total_bill, y = tip, size = size)) +
  geom_point()

# Adding a third variable: `tip` vs `total_bill` with `smoker` as color
ggplot(tips, aes(x = total_bill, y = tip, color = smoker)) +
  geom_point()

# Adding two variables: `tip` vs `total_bill` with `smoker` as color and `size` as size
ggplot(tips, aes(x = total_bill, y = tip, size = size, color = smoker)) +
  geom_point()

# ----------------------------------------


# Adjusting shape: `tip` vs `total_bill`
ggplot(tips, aes(x = total_bill, y = tip)) +
  geom_point(shape = 1)

# Adjust color
ggplot(tips, aes(x = total_bill, y = tip)) +
  geom_point(color = "blue")

# Adjusting shape: `tip` vs `total_bill`
ggplot(tips, aes(x = total_bill, y = tip)) +
  geom_point(shape = 1, color = "blue")


# ----------------------------------------


# Classic theme
ggplot(tips, aes(x = total_bill, y = tip)) +
  geom_point() +
  theme_bw()


# ----------------------------------------


# Adding labels
ggplot(tips, aes(x = total_bill, y = tip)) +
  geom_point() +
  theme(plot.title = element_text(size = 16),
        axis.title.x = element_text(size = 14), 
        axis.title.y = element_text(size = 14)) +
  labs(title = "Tips vs Total Bill",
       x = "Total Bill",
       y = "Tips")


# ----------------------------------------


# Putting it all together
ggplot(tips, aes(x = total_bill, y = tip, size = size, color = smoker)) +
  geom_point(alpha = 0.7) +
  theme_bw() +
  theme(plot.title = element_text(size = 16),
        axis.title.x = element_text(size = 14), 
        axis.title.y = element_text(size = 14)) +
  labs(title = "Tips vs Total Bill",
       x = "Total Bill",
       y = "Tips",
       color = "Smoker")
