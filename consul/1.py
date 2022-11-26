a = []
for i in range(50):
    a.append(a)

a.extend([1])
print(len(a[0][1][0]))