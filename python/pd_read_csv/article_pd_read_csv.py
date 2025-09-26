# Import Files With pd.read_csv()


# Import pandas
import pandas as pd


# 1. filepath_or_buffer

# Load the dataset
df1 = pd.read_csv("matches_clean.csv")

# View the result
print(df1)


# 2. sep

# Load the dataset with ";" as delim
df2 = pd.read_csv("matches_semicolon.txt", sep=";")

# View the result
print(df2)


# 3. header

# Load the dataset where the header is the 3rd row
df3 = pd.read_csv("matches_with_metadata.txt", header=2)

# View the result
print(df3)


# 4. skiprows

# Load the dataset, skipping the metadata
df4 = pd.read_csv("matches_with_metadata.txt", skiprows=[0, 1])

# View the result
print(df4)


# 5. nrows

# Load the first 3 rows
df5 = pd.read_csv("matches_clean.csv", nrows=3)

# View the result
print(df5)


# 6. usecols

# Load only HomeTeam and HomeGoals
df6 = pd.read_csv("matches_clean.csv", usecols=["HomeTeam", "HomeGoals"])

# View the result
print(df6)


# 7. index_col

# Load the dataset with MatchID as index col
df7 = pd.read_csv("matches_clean.csv", index_col="MatchID")

# View the result
print(df7)


# 8. names

# Set col names
col_names = [
    "id",
    "home",
    "away",
    "home_goals",
    "away_goals",
    "date"
]

# Load the dataset with custom col names
df8 = pd.read_csv("matches_no_header.csv", names=col_names)

# View the result
print(df8)


# 9. dtype

# Set col data types
col_dtypes = {
    "MatchID": str,
    "HomeGoals": "int32",
    "AwayGoals": "int32"
}

# Load the dataset, specifying data types for MatchID, HomeGoals, and AwayGoals
df9 = pd.read_csv("matches_clean.csv", dtype=col_dtypes)

# View the result
df9.info()