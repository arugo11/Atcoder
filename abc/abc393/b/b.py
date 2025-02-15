s = input()

def find_B(x):
    ans = []
    for i in range(len(s)):
        if s[i] == "B" and i > x:
            ans.append(i)
    return ans
cnt = 0
for i in range(len(s)):
    if s[i] == "A":
        find_b = find_B(i)
        if find_b == []:print(cnt);exit()
        for j in find_b:
            if (j + (j - i)) < len(s):
                if s[j + (j - i)] == "C":
                    cnt += 1
print(cnt)
