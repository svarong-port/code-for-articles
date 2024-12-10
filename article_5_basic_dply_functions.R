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


# select() example
select(hr_data, Name, Department, Engagement)


# ---------------------------------------


# filter() examples
filter(hr_data, AttritionRisk == "High")

filter(hr_data, AttritionRisk == "High" & Department == "Finance")


# ---------------------------------------


# arrange() examples
arrange(hr_data, Engagement)

arrange(hr_data, desc(Engagement))


# ---------------------------------------


# summarise() examples
summarise(hr_data, mean(Engagement))

summarise(group_by(hr_data, AttritionRisk), mean(Engagement))

summarise(group_by(hr_data, AttritionRisk), AvgEng = mean(Engagement))


# ---------------------------------------


# mutate() example
mutate(hr_data, YearsUntilRetirement = 60 - Age)


# ---------------------------------------


# pipe examples

hr_data |>
  group_by(AttritionRisk) |>
  summarise(AvgEng = mean(Engagement))

hr_data |>
  filter(AttritionRisk == "High") |>
  arrange(desc(YearsAtCompany), desc(Salary))

hr_data |> 
  group_by(Department) |>
  summarise(AvgEng = mean(Engagement),
            Empcount = n()) |>
  arrange(desc(AvgEng))
  
hr_data |>
  group_by(Department) |>
  summarise(HighRiskCount = sum(AttritionRisk == "High"),
            TotalEmp = n(),
            HighRiskRatio = (HighRiskCount / TotalEmp) * 100) |>
  select(Department, HighRiskRatio, TotalEmp, HighRiskCount) |>
  arrange(desc(HighRiskRatio))
