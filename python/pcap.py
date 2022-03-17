import time
import random

random_list = random.sample(range(0, 65535), 9999)


def costum_sort(l, **type):
    for i in range(1, len(l)):
        while l[i] < l[i-1] and i > 0:
            tmp = l[i-1]
            l[i-1] = l[i]
            l[i] = tmp
            i -= 1
            
    if type.get("type") == "descending":
        for i in range(1, len(l)):
            while l[i] > l[i-1] and i > 0:
                tmp = l[i-1]
                l[i-1] = l[i]
                l[i] = tmp
                i -= 1
           
start = time.perf_counter()     
print(random_list, end='\n***\n')
costum_sort(random_list)
# random_list.sort()
print(random_list, end='\n***\n')
finish = time.perf_counter()     
print(finish - start)
