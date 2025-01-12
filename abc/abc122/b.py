s = input()

cnt = 0
ans = -1
for i in s:
    if i in ["A", "C", "G", "T"]:
        cnt += 1
        ans = max(cnt,ans)
    else:
        ans = max(cnt,ans)
        cnt = 0
print(ans)
