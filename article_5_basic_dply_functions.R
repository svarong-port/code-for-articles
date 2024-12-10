# Code for 5 basic dplyr functions


# ---------------------------------------


# Call dplyr
library(dplyr)


# ---------------------------------------


# Create dataset
hr_data <- data.frame(
  ID = 1:10,
  Name = c("Alice", "Bob", "Charlie", "Diana", "Ethan", "Fiona", "George", "Hannah", "Ian", "Jane"),
  Department = c("HR", "IT", "Finance", "HR", "Finance", "IT", "HR", "Finance", "IT", "HR"),
  Age = c(25, 30, 35, 28, 45, 32, 40, 29, 31, 38),
  YearsAtCompany = c(1, 5, 8, 2, 15, 6, 10, 3, 4, 12),
  Performance = c(85, 90, 95, 88, 80, 92, 87, 89, 91, 93)
)


# ---------------------------------------


# View the dataset
hr_data


# ---------------------------------------


# select() example
select(hr_data, Name, Department, Performance)


# ---------------------------------------


# filter() examples
filter(hr_data, Department == "HR")

filter(hr_data, Department == "HR" & YearsAtCompany >= 10)


# ---------------------------------------


# arrange() examples
arrange(hr_data, Department)

arrange(hr_data, desc(Department))


# ---------------------------------------


# summarise() examples
summarise(hr_data, mean(Performance))

summarise(group_by(hr_data, Department), mean(Performance))
          
summarise(group_by(hr_data, Department), AvgPer = mean(Performance))


# ---------------------------------------


# mutate() example
mutate(hr_data, YearsUntilRetirement = 60 - Age)


# ---------------------------------------


# pipe examples

hr_data |> 
  group_by(Department) |>
  summarise(AvgPer = mean(Performance))

hr_data |>
  group_by(Department) |>
  summarise(AvgPer = mean(Performance),
            EmpCount = n()) |>
  arrange(desc(AvgPer))

hr_data |>
  filter(Age >= 30 & Department == "IT") |>
  arrange(desc(Performance))
