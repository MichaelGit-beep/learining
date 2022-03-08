N = 4
nums = [2, 6, 13, 39]

counter = 0
for i in range(N):
    for j in range(i+1, N):
        if nums[i] * nums[j] % 26 == 0:
            counter += 1
                
print(counter)