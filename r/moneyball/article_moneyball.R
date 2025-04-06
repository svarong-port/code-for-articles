# Code for Moneyball in R


# Dataset
# Name: Moneyball
# Source: https://www.kaggle.com/datasets/wduckett/moneyball-mlb-stats-19622012?resource=download
# Retrieved date: 06 Apr 2025

# References

# Moneyball: How linear regression changed baseball
# URL:  https://kharshit.github.io/blog/2017/07/28/moneyball-how-linear-regression-changed-baseball

## Moneyball: The Power of Sports Analytics
## URL: https://learning.edx.org/course/course-v1:MITx+15.071x+2T2020/block-v1:MITx+15.071x+2T2020+type@sequential+block@6324edb8a22c4e35b937490647bfe203/block-v1:MITx+15.071x+2T2020+type@vertical+block@553e126434c744a1ab9f9bd817e593ef


# --------------------------------------------------


# Install and load packages

## Install
install.packages("ggplot2") # for diamonds dataset and visualisation
install.packages("dplyr") # for data manipulation

## Load
library(ggplot2)
library(dplyr)


# --------------------------------------------------


# Prepare the dataset

## Load the dataset
baseball <- read.csv("baseball.csv")

## Preview the dataset
head(baseball)

## View the structure
glimpse(baseball)


## Convert character columns to factor
baseball <- baseball |>
  mutate(across(c("Team",
                  "League",
                  "Playoffs"),
                as.factor))
         
## Check the results
glimpse(baseball)


## Subset the data
moneyball <- subset(baseball,
                    Year < 2002)

## Check the results
glimpse(moneyball)


# --------------------------------------------------


# Find the number of wins to get to playoffs
ggplot(moneyball,
       aes(x = W,
           y = Team,
           color = Playoffs)) +
  
  ## Call jitter plot
  geom_jitter(height = 0.1,
              width = 0.2,
              alpha = 0.7,
              size = 2) +
  
  ## Create vertical line
  geom_vline(xintercept = 95,
             color = "black",
             linetype = "dashed",
             linewidth = 1) +
  
  ## Set the colour of the data points
  scale_color_manual(values = c("0" = "red", "1" = "green"),
                     labels = c("0" = "No", "1" = "Yes"),
                     name = "Playoff Status") +
  
  ## Add text elements
  labs(title = "The Number of Wins vs Playoffs",
       x = "The Number of Wins",
       y = "Teams") +
  
  ## Set theme to mininal
  theme_light()


# --------------------------------------------------


# Find the difference in score runs and runs allowed

## Compute run difference (RD)
moneyball <- moneyball |>
  mutate(RD = RS - RA)

## Check the results
glimpse(moneyball)

## Create a linear regression model
linear_reg_win <- lm(W ~ RD,
                     data = moneyball)

## See the results
summary(linear_reg_win)

## Find RD required to win >= 95

### Get intercept
RD_intercept <- as.numeric(coef(linear_reg_win)[1])

### Get slope
RD_slope <- as.numeric(coef(linear_reg_win)[2])

### Calculate the required RD
RD_required <- (95 - RD_intercept) / RD_slope

## Print the required RD
cat("RD required to win at least 95:",
    round(RD_required, 0))


# --------------------------------------------------


# Verify predictors of score runs

## OBP, SLG, BA

### Fit a linear regression
linear_reg_RS_BA <- lm(RS ~ OBP + SLG + BA,
                       data = moneyball)

### Show the results
summary(linear_RS_run_BA)


## OBP, SLG, BA

### Fit a linear regression
linear_RS_run <- lm(RS ~ OBP + SLG,
                    data = moneyball)

### Show the results
summary(linear_RS_run)


# --------------------------------------------------


# Verify predictors of runs allowed

## Fit a lienar regression
linear_reg_RA <- lm(RS ~ OBP + SLG,
                     data = moneyball)

## Show the results
summary(linear_reg_RA)