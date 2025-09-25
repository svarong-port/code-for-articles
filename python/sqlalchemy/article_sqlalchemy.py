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


# Query the database
df_customers = pd.read_sql("SELECT * FROM customers", engine)

# View the df
df_customers.head(10)