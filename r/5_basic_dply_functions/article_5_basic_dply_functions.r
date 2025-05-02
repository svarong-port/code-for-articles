# Code for 5 basic dplyr functions


# Install dplyr
install.packages("dplyr")

# Load dplyr
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

# View the dataset
hr_data


# ---------------------------------------


# Select data
select(hr_data,
       Name,
       Department,
       Engagement)


# ---------------------------------------


# Filter data

## With 1 condition
filter(hr_data,
       AttritionRisk == "High")

## With >1 conditions
filter(hr_data,
       AttritionRisk == "High" & Department == "Finance")


# ---------------------------------------


# Arrange data

## Sort ascending
arrange(hr_data,
        Engagement)


## Sort descending
arrange(hr_data,
        desc(Engagement))


# ---------------------------------------


# Summarise data

## Calculate mean
summarise(hr_data,
          mean(Engagement))


## Summarise with group by
summarise(group_by(hr_data, AttritionRisk),
          mean(Engagement))


## Naming the output
summarise(group_by(hr_data, AttritionRisk),
          AvgEng = mean(Engagement))


# ---------------------------------------


# Mutate data
mutate(hr_data,
       YearsUntilRetirement = 60 - Age)


# ---------------------------------------


# Using the pipe operator

## Example 1
hr_data |>
  
  ## Group by AttritionRisk
  group_by(AttritionRisk) |>
  
  ## Calculate mean
  summarise(AvgEng = mean(Engagement))


## Example 2
hr_data |>
  
  ## Filter for high attrition risk
  filter(AttritionRisk == "High") |>
  
  ## Sort descending by tenure and salary
  arrange(desc(YearsAtCompany),
          desc(Salary))


## Example 3
hr_data |> 
  
  ## Group by department
  group_by(Department) |>
  
  ## Calculate mean and count the number of employees
  summarise(AvgEng = mean(Engagement),
            EmpCount = n()) |>
  
  ## Sort descending by average engagement
  arrange(desc(AvgEng))

## Example 4
hr_data |>
  
  ## Group by department
  group_by(Department) |>
  
  ## Calculate sum and percentage
  summarise(HighRiskCount = sum(AttritionRisk == "High"),
            TotalEmp = n(),
            HighRiskRatio = (HighRiskCount / TotalEmp) * 100) |>
  
  ## Select desired columns
  select(Department, HighRiskRatio, TotalEmp, HighRiskCount) |>
  
  ## Sort descending by high rish ratio
  arrange(desc(HighRiskRatio))