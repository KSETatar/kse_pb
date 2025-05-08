#Завдання 1
name = "Tatar"
age = 20
height = 1.78
weight = 65.0
country = "Ukraine"
city = "Kyiv"
is_student = True
has_passport = True
fully_functional = False
year = 2025
GPA = 86.09

#Завдання 2
a=4
b=20
print(a,b)
c=a,b
print(c)
b,a=c
print(a,b)

#Завдання 3
x=3
y=9
print(2*x+3*y)
print(x**2+2*x*y+y**2)
print(x*(2/8)*(13/7)*y)
print(y**(1/2)*(4*x-2*y))
print(x%b)
print((y/x)**2)
print(x>y)
print(x**2==y)

#Завдання 4
product_name = "Порохотягар"
product_price = "300,000"
Intro =f"{product_name} дорівнює {product_price} гривень"
print(Intro)

#Завдання 5
x1=1
x2=2
x3=3
x4=1

((x1>3) or (x2>x4) and not (x2!=x3)or(x1==x4))

#Завдання 6
height = float(input("Введіть ваш зріст у метрах"))
weight = float(input("Введіть вашу вагу в кг"))
bmi=height**2/weight
Thingie =f"При вазі {weight} кг і рості {height} метрів ваш BMI складає {bmi}"
print(Thingie)

#Бонус
rad1=30
rad2=36.3
size1=3.14*rad1**2
size2=3.14*rad2**2
diff=(size2-size1)/size1
# Значення відстоків має бути 2 cимволи типу
Thingie =f"Друга піцa на {round(diff*100,2)}% більша за першу" 
print(Thingie)