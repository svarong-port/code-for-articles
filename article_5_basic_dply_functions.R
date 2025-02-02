# Code for 5 basic dplyr functions


# ---------------------------------------


# Call dplyr
library(dplyr)


# ---------------------------------------


# Create the dataset
hr_data <- data.frame(
  ID = 1:15,
  Name = c("Alice", "Bob", "Carol", "David", "Eve", "Frank", "Grace", 
           "Henry", "Ivy", "Jack", "Karen", "Liam", "Mona", "Nate", "Olivia"),
  Department = c("HR", "IT", "Finance", "HR", "Sales", "IT", "Finance", 
                 "Sales", "IT", "HR", "Finance", "Sales", "IT", "HR", "Sales"),
  Age = c(34, 29, 45, 50, 27, 30, 42, 35, 31, 40, 38, 28, 33, 55, 26),
  Engagement = c(85, 70, 65, 55, 90, 75, 60, 88, 80, 50, 68, 72, 78, 40, 95),
  YearsAtCompany = c(5, 2, 15, 25, 1, 3, 10, 7, 4, 20, 12, 1, 6, 30, 0),
  AttritionRisk = c("Low", "Medium", "High", "High", "Low", "Medium", "High", 
                    "Low", "Medium", "High", "High", "Low", "Medium", "High", "Low"),
  Salary = c(55000, 60000, 70000, 75000, 50000, 62000, 68000, 58000, 
             61000, 77000, 72000, 51000, 64000, 80000, 49000)
)

# View dataset
hr_data


# ---------------------------------------


# select() example
select(hr_data, Name, Department, Engagement)


# ---------------------------------------


# filter() examples

## 1 condition
filter(hr_data, AttritionRisk == "High")

## more than 1 condition
filter(hr_data, AttritionRisk == "High" & Department == "Finance")


# ---------------------------------------


# arrange() examples

## default sorting: ascending
arrange(hr_data, Engagement)


## sort descending
arrange(hr_data, desc(Engagement))


# ---------------------------------------


# summarise() examples

## summarise() alone
summarise(hr_data, mean(Engagement))


## summarise() + group_by()
summarise(group_by(hr_data, AttritionRisk), mean(Engagement))


## naming output in summarise()
summarise(group_by(hr_data, AttritionRisk), AvgEng = mean(Engagement))


# ---------------------------------------


# mutate() example
mutate(hr_data, YearsUntilRetirement = 60 - Age)


# ---------------------------------------


# pipe examples

## example 1
hr_data |>
  group_by(AttritionRisk) |>
  summarise(AvgEng = mean(Engagement))

## example 2
hr_data |>
  filter(AttritionRisk == "High") |>
  arrange(desc(YearsAtCompany), desc(Salary))


## example 3
hr_data |> 
  group_by(Department) |>
  summarise(AvgEng = mean(Engagement),
            EmpCount = n()) |>
  arrange(desc(AvgEng))

## example 4
hr_data |>
  group_by(Department) |>
  summarise(HighRiskCount = sum(AttritionRisk == "High"),
            TotalEmp = n(),
            HighRiskRatio = (HighRiskCount / TotalEmp) * 100) |>
  select(Department, HighRiskRatio, TotalEmp, HighRiskCount) |>
  arrange(desc(HighRiskRatio))
