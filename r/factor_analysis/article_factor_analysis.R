# Code for Factor Analysis With psych package


## Install and load the package

## Install
install.packages("psych") # EFA and CFA
install.packages("lavaan") # CFA
install.packages("dplyr") # data manipulation

## Load
library(psych)
library(lavaan)
library(dplyr)


# ---------------------------------------


# Load the data

## Load
data(bfi)

## Select only the items
items <- bfi[, 1:25]

## Preview
head(items)

## View the structure
str(items)


# ---------------------------------------


# Split the data

## Set seed for reproducibility
set.seed(2018)

## Define index for splitting
splitting <- sample(nrow(items),
                    nrow(items) * 0.8)

## Create an EFA dataset
items_efa <- items[splitting, ]

## Create a CFA dataset
items_cfa <- items[-splitting, ]


# ---------------------------------------


# Perform EFAs

## Theory-driven approach
efa_theory <- fa(items_efa,
                 nfactors = 5,
                 rotate = "oblimin")

## View the results
print(efa_theory$loadings,
      cutoff = 0.3)


## Empirical approach

### Create a correlation matrix
items_cor_mat <- cor(items_efa,
                     use = "pairwise.complete.obs")

### Get Eigen values
eigens <- eigen(items_cor_mat)

### View Eigen values
eigens$values

### Plot Eigen values
scree(items_cor_mat,
      factors = FALSE)

### Perform EFA with 7 factors
efa_emp <- fa(items_efa,
              nfactors = 7,
              rotate = "oblimin")

## View the results
print(efa_emp$loadings,
      cutoff = 0.3)


## Compare the EFA models
efa_compared <- data.frame(Model = c("Theory", "Empirical"),
                           TLI = c(mean(efa_theory$TLI), mean(efa_emp$TLI)),
                           RMSEA = c(mean(efa_theory$RMSEA), mean(efa_emp$RMSEA)),
                           BIC = c(efa_theory$BIC, efa_emp$BIC))

## Round values to 2 decimals
efa_compared <- efa_compared |>
  mutate(across(TLI:BIC, round, 2))

## Print the data frame
print(efa_compared)


# ---------------------------------------


# Perform CFAs

## Theory-driven approach

# Create a syntax for factor loadings
model_theory <- "
  AGE =~ A1 + A2 + A3 + A4 + A5
  CON =~ C1 + C2 + C3 + C4 + C5
  EXT =~ E1 + E2 + E3 + E4 + E5
  NEU =~ N1 + N2 + N3 + N4 + N5
  OPE =~ O1 + O2 + O3 + O4 + O5
"

### Feed the syntax to cfa()
cfa_theory <- cfa(model = model_theory,
                  data = items_cfa)

### View the results
summary(cfa_theory)


## Empirical approach

### Create a syntax for factor loadings
model_emp <- "
  AGE =~ A1 + A2 + A3 + A4 + A5
  CON =~ C1 + C2 + C3 + C4 + C5
  EXT =~ E1 + E2 + E4 + E5
  NEU =~ N1 + N2 + N3 + N4 + N5
  OPE =~ O1 + O3 + O4
" 

## Perform CFA
cfa_emp <- cfa(model = model_emp,
               data = items_cfa)

### View the results
summary(cfa_emp)


## Compare the models

### Extract the metrics
cfa_theory_fit_measures <- fitMeasures(cfa_theory)
cfa_emp_fit_measures <- fitMeasures(cfa_emp)

### Create a data frame
cfa_compared <- data.frame(Model = c("Theory", "Empirical"),
                           TLI = c(cfa_theory_fit_measures["tli"],
                                   cfa_emp_fit_measures["tli"]),
                           RMSEA = c(cfa_theory_fit_measures["rmsea"],
                                     cfa_emp_fit_measures["rmsea"]),
                           BIC = c(cfa_theory_fit_measures["bic"],
                                   cfa_emp_fit_measures["bic"]))

### Round values to 2 decimals
cfa_compared <- cfa_compared |>
  mutate(across(TLI:BIC, round, 2))

### Print the data frame
print(cfa_compared)