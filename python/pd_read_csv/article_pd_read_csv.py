# Import Files With pd.read_csv()


# Import pandas
import pandas as pd


# Import data
df = pd.read_csv("customers_clean.csv")

# View the result
print(df)


# 1. sep
df1 = pd.read_csv("customers_semicolon.txt", sep=";")

# View the result
print(df1)


# 2. header
df2 = pd.read_csv("customers_with_header.txt", header=2)

# View the result
print(df2)


# 3. index_col
df3 = pd.read_csv("customers_clean.csv", index_col="CustomerID")

# View the result
print(df3)


# 4. usecols
df4 = pd.read_csv("customers_clean.csv", usecols=["CustomerID", "FirstName", "LastName", "Address"])

# View the result
print(df4)


# 5. nrows
df5 = pd.read_csv("customers_clean.csv", nrows=3)

# View the result
print(df5)


# 6. skiprows
df6 = pd.read_csv("customers_with_header.csv", skiprows=2)

# View the result
print(df6)


# 7. names
df7 = pd.read_csv("customers_clean.csv", names=["ID", "FullName", "Years", "Sex", "Purchase", "JoinDate"])

# View the result
print(df7)


# 8. dtype
df8 = pd.read_csv("customers_clean.csv", dtype={"CustomerID": str, "Age": "int32"})

# View the result
print(df8)