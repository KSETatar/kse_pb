import requests

response = requests.get("https://en.wikipedia.org/wiki/Solid_Snake")
print(response.status_code)
txt = response.text

with open("solid_snake.txt", "w", encoding="utf8") as file:
    file.write(response.text) 

