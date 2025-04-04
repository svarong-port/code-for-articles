# Createa a simple example decision tree

## Create a small dataset for decision making
job_data <- data.frame(
  RelatedSkill = c("Yes", "Yes", "Yes", "Yes", "No", "No", "No", "No"),
  AttractiveSalary = c("Yes", "No", "Yes", "No", "Yes", "No", "Yes", "No"),
  WorkType = c("Hybrid", "Hybrid", "Remote", "Remote", "Hybrid", "Remote", "Remote", "Hybrid"),
  Apply = c("Yes", "No", "Yes", "No", "No", "No", "Yes", "No")  # Decision to apply
)

## Convert categorical variables to factors
job_data[] <- lapply(job_data, as.factor)

## Build the decision tree model
dt_model <- rpart(Apply ~ RelatedSkill + AttractiveSalary + WorkType, 
                  data = job_data, 
                  method = "class", 
                  control = rpart.control(cp = 0, minsplit = 1, maxdepth = 3))

## Plot the decision tree with all predictors
rpart.plot(dt_model,
           type = 3,
           extra = 101,
           under = TRUE,
           tweak = 1.2)