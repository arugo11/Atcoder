n , d = map(int,input().split(" "))
TL = [list(map(int, input().split())) for _ in range(n)]

for i in range(d):
    ans = -1
    for j in TL:
        ans = max(ans,(j[1] + (i + 1)) * j[0])
    print(ans)