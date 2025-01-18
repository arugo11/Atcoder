from collections import deque
n = int(input())
cumsum = deque([0])
for _ in range(n):
    op, *val = map(int,input().split(" "))
    if op == 1:
        cumsum.append(cumsum[-1] + val[0])
    elif op == 2:
        cumsum.popleft()
    else:
        # print("val",val)
        print(cumsum[val[0]-1] - cumsum[0])