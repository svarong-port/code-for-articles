# Usinh json Package in Python


# Import json
import json

# Import pprint
from pprint import pprint


# -------------------------------------


# 1. json.loads()

# Create a JSON string
cookie_json_string = """
{
    "customer": "Luna",
    "cookies": [
        "Chocolate Chip",
        "Oatmeal",
        "Sugar"
    ],
    "is_member": true,
    "total_price": 120
}
"""

# Convert to Python object
cookie_python_dict = json.loads(cookie_json_string)

# View the result
pprint(cookie_python_dict)


# -------------------------------------


# 2. json.dumps()

# Create a Python dict
cookie_py_dict = {
    "customer": "Luna",
    "cookies": [
        "Chocolate Chip",
        "Oatmeal",
        "Sugar"
    ],
    "is_member": True,
    "total_price": 120
}

# Convert to JSON string
cookie_json_str = json.dumps(cookie_py_dict)

# View the result
print(cookie_json_str)


# -------------------------------------


# Convert to JSON string with indent argument
cookie_json_str_indent = json.dumps(cookie_py_dict, indent=4)

# View the result
print(cookie_json_str_indent)


# -------------------------------------


# json.load()

# Load JSON data
with open("cookie_order.json", "r") as file:
    cookie_order = json.load(file)

# View the result
pprint(cookie_order)


# -------------------------------------


# 4. json.dump()

# Update status
cookie_order["status"] = "on the way"

# Write to JSON file
with open("cookie_order_updated_indent.json", "w") as file:
    json.dump(cookie_order, file, indent=2)