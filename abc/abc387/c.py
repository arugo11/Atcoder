l, r = map(int,input().split())

cnt = 0
for i in range(l, r+1):
    top = int(str(i)[0])
    flag = True
    for j in range(1,len(str(i))):
        print(top,str(i)[j])
        if(top < int(str(i)[j])):
            flag = False
            break
    if flag:
        cnt += 1

print(cnt)