import os
import json

my_headers = os.path.join(os.path.dirname(__file__), "headers.txt")
with open(my_headers, "r") as f: 
    opened_file = f.readlines()


header = {}

for i in opened_file:
    tmp_list = i.strip().split(":")
    if len(tmp_list) > 1:
        key, value = tmp_list[0], tmp_list[1].lstrip()
        header[key] = value


tmp_json = my_headers = os.path.join(os.path.dirname(__file__), "header.json")
with open(tmp_json, "a") as f:
    json.dump(header, f, indent=4)