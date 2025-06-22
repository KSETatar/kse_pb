import requests
import pandas as pd
from datetime import datetime, timedelta

# 1. Отримати прогнози погоди

latitude, longitude = 50.450, 30.523  # взяв наче Київ)

url = "https://api.open-meteo.com/v1/forecast"
params = {
    "latitude": latitude,
    "longitude": longitude,
    "hourly": "temperature_2m,wind_speed_10m",
    "forecast_days": 7,
    "timezone": "auto"
}

# 2. Перетворення даних

response = requests.get(url, params=params)
data = response.json()

times = data['hourly']['time']
temperatures = data['hourly']['temperature_2m']
wind_speeds = data['hourly']['wind_speed_10m']

dataframe = pd.DataFrame({
    "datetime": pd.to_datetime(times),
    "temperature": temperatures,
    "wind_speed": wind_speeds
})

dataframe.set_index("datetime", inplace=True)

# 3. Виконати базовий дослідницький аналіз даних

now = datetime.now()

three_days_later = now + timedelta(days=3)
dataframe_3_days = dataframe[now:three_days_later]

min_temp = dataframe_3_days["temperature"].min()
max_temp = dataframe_3_days["temperature"].max()
mean_temp = dataframe_3_days["temperature"].mean()

mean_wind_speed = dataframe["wind_speed"].mean()
count_above_avg = (dataframe["wind_speed"] > mean_wind_speed).sum()

print(f"Мінімальна температура за 3 дні: {min_temp:.2f}°C")
print(f"Максимальна температура за 3 дні: {max_temp:.2f}°C")
print(f"Середня температура за 3 дні: {mean_temp:.2f}°C")

print(f"Середня швидкість вітру: {mean_wind_speed:.2f} км/год")
print(f"Годин, коли швидкість вітру перевищувала середню: {count_above_avg}")