# Usinh json Package in Python


# Import json
import json

# Create a Python dict
cookies = {
    "name": "Chocolate Chip",
    "flavor": "chocolate",
    "price": 1.5,
    "ingredients": ["flour", "butter", "sugar", "chocolate chips"],
    "is_gluten_free": False
}


# json.dumps(): Python dict to JSON string
cookies_json_str = json.dumps(cookies)

# View the result
print(cookies_json_str)


# json.dumps() with indent
cookies_json_str = json.dumps(cookies, indent=4)

# View the result
print(cookies_json_str)


# json.loads(): JSON string to Python dict
cookies_dict = json.loads(cookies_json_str)

# View the result
print(cookies_dict)


# json.dump(): Python dict to JSON file
with open("cookies.json", "x") as file:
    json.dump(cookies_dict, file, indent=4)


# json.load(): JSON file to Python dict
with open("cookies.json", "r") as file:
    cookies_dict_from_file = json.load(file)

# View the result
print(cookies_dict_from_file)
