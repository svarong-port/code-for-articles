# Load required packages
library(dplyr)
library(tidyr)
library(ggplot2)
library(GGally)

library(RColorBrewer)


# ---------------------------------------------


# Set seed for reproducibility
set.seed(32)


# ---------------------------------------------


# 1. Histogram Dataset: Ages of residents in a city
ages_in_city <- data.frame(
  Age = c(
    rnorm(800, mean = 35, sd = 10), # Working-age adults
    rnorm(150, mean = 18, sd = 2),  # Teenagers
    rnorm(50, mean = 70, sd = 5)    # Seniors
  ) %>%
    round() %>%
    pmax(0) %>%  # Ensure ages are non-negative
    pmin(100)    # Cap at 100 for realistic age range
)


# Create histogram with Google Blue color
ggplot(ages_in_city, aes(x = Age)) +
  geom_histogram(
    binwidth = 5,
    fill = "#4285F4",      # Google Blue color
    color = "white",       # Lighter border for contrast
    alpha = 0.7            # Semi-transparent fill for a smooth visual effect
  ) +
  labs(
    title = "Age Distribution of Residents",
    x = "Age",
    y = "Frequency"
  ) +
  theme_minimal(base_size = 15) +  # Set base font size for better readability
  theme(
    plot.title = element_text(hjust = 0.5, size = 18, face = "bold"),  # Center and bold title
    axis.title = element_text(size = 14),  # Make axis titles more prominent
    axis.text = element_text(size = 12)   # Adjust axis labels font size
  )


# ---------------------------------------------


# 2. Box Plot Dataset: Monthly expenses in different cities
set.seed(456)
monthly_expenses <- data.frame(
  City = rep(c("New York", "Los Angeles", "Chicago", "Houston", "Phoenix"), each = 100),
  Expense = c(
    rnorm(100, mean = 3500, sd = 500), # New York
    rnorm(100, mean = 3000, sd = 400), # Los Angeles
    rnorm(100, mean = 2800, sd = 450), # Chicago
    rnorm(100, mean = 2500, sd = 300), # Houston
    rnorm(100, mean = 2200, sd = 350)  # Phoenix
  ) %>%
    round()
)


# Create box plot with Google Blue color
ggplot(monthly_expenses, aes(x = City, y = Expense)) +
  geom_boxplot(
    fill = "#4285F4",           # Google Blue color for the fill
    color = "black",            # Black border for contrast
    outlier.color = "red",   # Outliers in yellow for visibility
    alpha = 0.7,                # Slight transparency for smooth effect
    outlier.shape = 16,         # Outlier points as circles
    outlier.size = 3            # Adjust size of outlier points
  ) +
  labs(
    title = "Monthly Expenses by City",
    x = "City",
    y = "Monthly Expense (USD)"
  ) +
  theme_minimal(base_size = 15) +  # Set base font size for better readability
  theme(
    plot.title = element_text(hjust = 0.5, size = 18, face = "bold"),  # Center and bold title
    axis.title = element_text(size = 14),  # Make axis titles more prominent
    axis.text = element_text(size = 12)    # Adjust axis labels font size
  )


# ---------------------------------------------


# 3. Scatter Plot Dataset: Relationship between hours studied and exam scores

# Generate hours studied
hours_studied <- runif(100, min = 0, max = 10)  # Hours studied: 0 to 10

# Generate exam scores based on a linear relationship with noise
exam_score <- 50 + 5 * hours_studied + rnorm(100, sd = 5)

# Create data frame
scatter_data <- data.frame(
  Hours_Studied = hours_studied,
  Exam_Score = exam_score
)

# Create scatter plot with Google Green color and attractive styling
ggplot(scatter_data, aes(x = Hours_Studied, y = Exam_Score)) +
  geom_point(
    color = "#4285F4",    # Google Green color for the points
    size = 3,             # Larger point size for better visibility
    alpha = 0.6           # Slight transparency to avoid overlap
  ) +
  labs(
    title = "Relationship Between Hours Studied and Exam Scores",
    x = "Hours Studied",
    y = "Exam Score"
  ) +
  theme_minimal(base_size = 15) +  # Set base font size for readability
  theme(
    plot.title = element_text(hjust = 0.5, size = 18, face = "bold"),  # Center and bold title
    axis.title = element_text(size = 14),  # Make axis titles more prominent
    axis.text = element_text(size = 12),   # Adjust axis labels font size
    panel.grid.major = element_line(color = "grey", size = 0.3),  # Add light grid lines for clarity
    panel.grid.minor = element_line(color = "grey", size = 0.2)   # Minor grid lines for subtle detail
  )


# ---------------------------------------------


# 4. Line Plot Dataset: Monthly temperature of a city over a year
months <- factor(month.abb, levels = month.abb)
line_data <- data.frame(
  Month = months,
  Temperature = c(30, 32, 35, 38, 40, 42, 43, 42, 40, 37, 33, 30) + rnorm(12, sd = 1) # Simulated monthly temperature
)


# Create line plot with Google Green color
ggplot(line_data, aes(x = Month, y = Temperature, group = 1)) +
  geom_line(color = "#4285F4", size = 1) +   # Google Green for the line
  geom_point(color = "#4285F4", size = 2) +   # Google Green for the points
  labs(
    title = "Monthly Temperature Trend",
    x = "Month",
    y = "Temperature (°C)"
  ) +
  theme_minimal() +  # Clean, minimalistic theme
  theme(
    plot.title = element_text(hjust = 0.5)  # Center the plot title
  )

# ---------------------------------------------


# 5. Bar Plot Dataset: Average coffee sales by day of the week
bar_data <- data.frame(
  Day = factor(c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"),
               levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")),
  Coffee_Sales = c(200, 220, 250, 240, 300, 400, 350) # Average coffee sales
)


# Create bar plot with Google Green color
ggplot(bar_data, aes(x = Day, y = Coffee_Sales)) +
  geom_bar(stat = "identity",
           fill = "#4285F4",
           color = "black",
           alpha = 0.7) +  # Google Green for the bars
  labs(
    title = "Average Coffee Sales by Day of the Week",
    x = "Day of the Week",
    y = "Coffee Sales (Cups)"
  ) +
  theme_minimal() +  # Clean, minimalistic theme
  theme(
    plot.title = element_text(hjust = 0.5)  # Center the plot title
  )

# ---------------------------------------------


# 6. Dot Plot Dataset: Number of employees in each department
dot_data <- data.frame(
  Department = factor(c("HR", "Finance", "Engineering", "Sales", "Marketing", "IT"),
                      levels = c("HR", "Finance", "Engineering", "Sales", "Marketing", "IT")),
  Employees = c(15, 10, 50, 40, 20, 25) # Number of employees in each department
)


# Create dot plot with Google Green color
ggplot(dot_data, aes(x = Department, y = Employees)) +
  geom_point(color = "#4285F4", size = 4) +  # Google Green for the dots
  labs(
    title = "Number of Employees by Department",
    x = "Department",
    y = "Number of Employees"
  ) +
  theme_minimal() +  # Clean, minimalistic theme
  theme(
    plot.title = element_text(hjust = 0.5)  # Center the plot title
  )


# ---------------------------------------------


# 7. Pair Plot Dataset: Car attributes (mpg, horsepower, weight, and acceleration)
pair_plot_data <- data.frame(
  MPG = rnorm(100, mean = 25, sd = 5),             # Miles per gallon
  Horsepower = rnorm(100, mean = 150, sd = 30),    # Horsepower
  Weight = rnorm(100, mean = 3000, sd = 500),      # Weight in pounds
  Acceleration = rnorm(100, mean = 10, sd = 2)     # Acceleration (0-60 in seconds)
)


# Create pair plot
ggpairs(
  pair_plot_data,
  title = "Pair Plot of Car Attributes",
  diag = list(continuous = "densityDiag"),  # Density plots on the diagonal
  upper = list(continuous = "cor"),        # Correlation coefficients on the upper triangle
  lower = list(continuous = wrap("smooth", color = "#4285F4"))  # Google Blue for smooth lines in the lower triangle
) +
  theme_minimal() +
  theme(
    # Customize grid and background with Google Grey
    panel.grid.major = element_line(color = scales::alpha("#9E9E9E", 0.3), size = 0.5),  # Transparent major grid lines
    panel.grid.minor = element_line(color = scales::alpha("#9E9E9E", 0.3), size = 0.25),  # Transparent minor grid lines
    panel.background = element_rect(fill = "white"),   # Google Grey background for panels
    
    # Customize the color of dots and lines with Google Blue
    strip.background = element_rect(fill = "#4285F4"),  # Google Blue for strip background
    strip.text = element_text(color = "white"),          # White text on strip labels
    axis.text = element_text(color = "black"),         # Google Blue for axis text
    
    # Center title and apply styling
    plot.title = element_text(hjust = 0.5, size = 18, face = "bold", color = "black")  # Google Blue centered title
  )


# ---------------------------------------------


# 8. Heatmap Dataset: Average temperature by city and month
cities <- c("New York", "Los Angeles", "Chicago", "Houston", "Phoenix")
months <- month.abb
heatmap_data <- expand.grid(
  City = cities,
  Month = months
) %>%
  mutate(
    Avg_Temperature = round(rnorm(n(), mean = 70, sd = 10), 1) # Randomized temperature values
  ) %>%
  tidyr::pivot_wider(names_from = Month, values_from = Avg_Temperature)



# Transform heatmap_data back to long format for plotting
heatmap_long <- heatmap_data %>%
  pivot_longer(
    cols = -City,
    names_to = "Month",
    values_to = "Avg_Temperature"
  )


# Create heatmap with Google Blue and Google Red
ggplot(heatmap_long, aes(x = Month, y = City, fill = Avg_Temperature)) +
  geom_tile(color = "white") +
  scale_fill_gradient(low = "#4285F4", high = "#DB4437") +  # Google Blue for low and Google Red for high
  labs(
    title = "Average Monthly Temperature by City",
    x = "Month",
    y = "City",
    fill = "Avg Temp (°F)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 18, face = "bold", color = "black"),  # Google Blue title
    axis.text = element_text(color = "black"),  # Google Blue for axis text
    axis.title = element_text(color = "black")  # Google Blue for axis title
  )


# ---------------------------------------------


# 9. Parallel Coordinates Plot Dataset: Student performance in subjects (4 students)
parallel_coords_data <- data.frame(
  Student_ID = paste0("S", 1:4),  # Reduced to 4 students
  Math = round(rnorm(4, mean = 75, sd = 10)),
  English = round(rnorm(4, mean = 70, sd = 15)),
  Science = round(rnorm(4, mean = 80, sd = 12)),
  History = round(rnorm(4, mean = 65, sd = 18))
)

# Generate a color palette with Google colors (4 colors for 4 students)
google_colors <- c(
  "#4285F4",  # Google Blue
  "#34A853",  # Google Green
  "#FBBC05",  # Google Yellow
  "#EA4335"   # Google Red
)

# Reshape data to long format for parallel coordinates
parallel_long <- parallel_coords_data %>%
  pivot_longer(
    cols = -Student_ID,
    names_to = "Subject",
    values_to = "Score"
  )


# Create parallel coordinates plot with Google color palette for 4 students
ggparcoord(
  data = parallel_coords_data,
  columns = 2:5,  # Columns representing subjects
  groupColumn = 1,  # Optional: Student_ID for grouping
  scale = "uniminmax",  # Scale values between 0 and 1
  mapping = aes(color = factor(Student_ID))  # Assign a unique color for each student
) +
  scale_color_manual(values = google_colors) +
  labs(
    title = "Parallel Coordinates Plot of Student Performance",
    x = "Subjects",
    y = "Normalized Scores"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.title = element_text(hjust = 0.5, color = "black", size = 18, face = "bold")  # Centered title in black
  )


# ---------------------------------------------


# 10. Pie Chart Dataset: Time spent by employees on different work tasks
tasks <- c("Meetings", "Emails", "Coding", "Research", "Documentation", "Collaboration", "Admin", "Breaks")
time_spent <- c(2, 1.5, 4, 1, 1, 1.5, 0.5, 2)  # Time in hours

pie_chart_data <- data.frame(
  Task = tasks,
  Time_Spent = time_spent  # Time spent in hours
)

# Google color palette for 8 categories
google_colors <- c(
  "#4285F4",  # Google Blue
  "#34A853",  # Google Green
  "#FBBC05",  # Google Yellow
  "#EA4335",  # Google Red
  "#FF6D01",  # Custom Orange (for balance)
  "#9C27B0",  # Purple
  "#607D8B",  # Blue Grey
  "#00BCD4"   # Cyan
)

# Create pie chart with Google color palette
ggplot(pie_chart_data, aes(x = "", y = Time_Spent, fill = Task)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +  # Converts the bar chart to a pie chart
  labs(title = "Time Spent by Employees on Different Work Tasks (in hours)") +
  theme_void() +  # Removes unnecessary background grid lines
  scale_fill_manual(values = google_colors) +  # Apply Google color palette
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold")  # Center the title
  )

# Create bar chart with Google color palette, arranged from high to low
ggplot(pie_chart_data, aes(x = reorder(Task, -Time_Spent), y = Time_Spent, fill = Task)) +
  geom_bar(stat = "identity") +
  labs(title = "Time Spent by Employees on Different Work Tasks (in hours)") +
  scale_fill_manual(values = google_colors) +  # Apply Google color palette
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),  # Center the title
    axis.text.x = element_text(angle = 45, hjust = 1)  # Rotate x-axis labels for clarity
  )


# ---------------------------------------------


# Create dataset: Employee Performance, Satisfaction, and Department
employee_data <- data.frame(
  Employee_ID = 1:100,
  Performance_Score = rnorm(100, mean = 75, sd = 10),  # Performance score out of 100
  Satisfaction_Score = rnorm(100, mean = 65, sd = 15),  # Satisfaction score out of 100
  Department = sample(c("Sales", "Marketing", "Engineering", "HR", "Finance"), 100, replace = TRUE),
  Age = sample(22:60, 100, replace = TRUE)  # Age of employees
)

# Google color palette for 5 departments
google_colors <- c(
  "Sales" = "#4285F4",  # Google Blue
  "Marketing" = "#34A853",  # Google Green
  "Engineering" = "#FBBC05",  # Google Yellow
  "HR" = "#EA4335",  # Google Red
  "Finance" = "#00BCD4"  # Google Cyan
)

# 1. Scatter plot with Color (Department)
ggplot(employee_data, aes(x = Performance_Score, y = Satisfaction_Score, color = Department)) +
  geom_point() +
  scale_color_manual(values = google_colors) +
  labs(title = "Employee Performance vs Satisfaction (Colored by Department)") +
  theme_minimal()

# 2. Scatter plot with Size (Age)
ggplot(employee_data, aes(x = Performance_Score, y = Satisfaction_Score, size = Age)) +
  geom_point(color = "#4285F4") +  # Google Blue as default
  labs(title = "Employee Performance vs Satisfaction (Sized by Age)") +
  theme_minimal()

# 3. Scatter plot with Transparency (Satisfaction Score)
ggplot(employee_data, aes(x = Performance_Score, y = Satisfaction_Score, alpha = Satisfaction_Score)) +
  geom_point(color = "#4285F4") +  # Google Blue as default
  labs(title = "Employee Performance vs Satisfaction (With Transparency)") +
  scale_alpha_continuous(range = c(0.3, 1)) +  # Set transparency range
  theme_minimal()

# 4. Scatter plot with Shape (Department)
ggplot(employee_data, aes(x = Performance_Score, y = Satisfaction_Score, shape = Department)) +
  geom_point(color = "#4285F4") +  # Google Blue as default
  scale_shape_manual(values = c(16, 17, 18, 19, 20)) +  # Custom shapes for departments
  labs(title = "Employee Performance vs Satisfaction (Different Shapes for Department)") +
  theme_minimal()
