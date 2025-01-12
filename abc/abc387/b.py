x = int(input())

sum = 0
for i in range(1,10):
    for j in range(1,10):
        if (i * j != x):
            sum += i*j

print(sum)