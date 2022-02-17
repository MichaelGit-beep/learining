def smart_devision(func):
    
    def inner(a, b):
        print(f"Trying to divide {a} to {b}")
        if b == 0:
            return None

        return func(a, b)
    
    return inner

@smart_devision
def division(a, b):
    return a / b

# print(smart_devision(division)(5, 6))
print(division(5, 0))