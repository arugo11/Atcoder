l = list(map(int, input().split()))

ans = []

for i in range(1,14):
    for j in range(1,14):
        if i != j:
            ans.append(sorted([i, i, i ,j ,j]))
            ans.append(sorted([i, i, j, j, j]))

# print(ans)
for i in range(1,14):
    tmp = l.copy()
    tmp.append(i)
    # print(tmp)
    if sorted(tmp) in ans:
        print("Yes")
        exit()
    _ = tmp.pop(-1)
print("No")
