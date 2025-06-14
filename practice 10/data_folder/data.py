import json

def get_data(file_path):
    with open(file_path, 'r+') as q:
        content = json.load(q)
    return content

def load_data(data, file_path):
    with open(file_path, 'r+') as q:
        json.dump(data, q)

