import random

def mathematical(func):
    def inner(a):
        print('Hello from inner func')
        return func(a)
        
    return inner
        
@mathematical
def convert(a):
    return ("{:.2f}".format(a))


# print(convert(5))


some = random.randint(30, 100)
while some > 20:
    print(some)
    some = random.randint(30, 100)
else:
    print(f"Finished, some value is {some}")
    