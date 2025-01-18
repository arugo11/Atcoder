s = input()

idx = 0
cnt = 0 


while idx < len(s):
    if s[idx] == '0':
        idx += 1
        cnt += 1
        if idx != len(s):
            if s[idx] == '0':
                idx += 1
    else:
        cnt += 1
        idx += 1

print(cnt)
