N = 4
nums = [2, 6, 13, 39]

counter = 0
for i in range(N):
        print("Here")
        for j in range(N):
            if nums[i] * nums[j] % 26 == 0:
                print(f"{nums[i]} * {nums[j]}")
                counter += 1
print(counter)
        
