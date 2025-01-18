import math
x = int(input())
ans = 0
while math.factorial(ans) <= x:
    ans += 1
print(ans-1)