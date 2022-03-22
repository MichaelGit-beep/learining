import random 
import time

array = [3, 5, 2, 7, 6, 4, 3, 2, 1, 0, 6, 3, 7, 8]

counters = []
for i in range(len(array)):
    counters.append(0)

for num in array:
    counters[num] += 1

sorted_arr = list()
print(counters)

for i in range(len(counters)):
    for _ in range(counters[i]):
        sorted_arr.append(i)
        
print(sorted_arr)
    
    