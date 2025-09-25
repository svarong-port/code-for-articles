# Working With Database Using sqlalchemy

# Import packages
from sqlalchemy import create_engine, inspect
import pandas as pd


# Connect to the database
engine = create_engine("sqlite:///chinook.sqlite")


# List the tables

# Get the inspector
inspector = inspect(engine)

# List the table names
tables = inspector.get_table_names()

# Print the table names
print(tables)


# Get the table

# Set the query
brazil_customers_query = """
SELECT FirstName, LastName, Phone, Email
FROM Customer
WHERE Country = 'Brazil';
"""

# Query the database
df = pd.read_sql(brazil_customers_query, engine)

# View the df
print(df)