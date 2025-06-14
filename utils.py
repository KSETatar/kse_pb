def prime(n):
    if n <= 1:
        return False
    if n == 2:
        return True
    if n % 2:
        return False
    for i in range (3, (n**0.5)+1, 2):
        if n % i == 0:
            return False

