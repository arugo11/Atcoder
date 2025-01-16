_, c1, c2 = map(str,input().split())
s = input()

for i in s:
    if i != c1:
        print(c2,end="")
    else:
        print(c1,end="")
print()
