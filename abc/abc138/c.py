n = int(input())
v = list(map(int,input().split(" "))) # type: ignore

v.sort()

sum = v[0]
for i in v[1:]:
    sum = (sum + i) / 2
    v[0] = sum#type:ignore
print(sum)