n = int(input())
a = list(map(int,input().split(" ")))

# a.sort()
# print(a)

def search_tgt_index(tgt,s = 0) -> int:
    #tgt以上でtgtにもっとも近い値を求める
    e = n - 1
    cnt = 0
    while e - (s - 1) >= 1:
        m  = (s + e) // 2
        # print(f"[{cnt}] m = ({s} + {e} // 2 == ({m}))")
        if a[m] < tgt:
            # print(f"{a[m]}({m}) < {tgt}")
            # print(f"s = {m + 1}")
            s = m + 1
        else:
            # print(f"{a[m]}({m}) > {tgt}")
            # print(f"e = {m - 1}")
            e = m - 1
        cnt += 1

    if a[m] < tgt:
        return m + 1
    return m

cnt = 0
for i in range(n):
    tgt = a[i] * 2
    if tgt > a[-1]:
        # print(a[i]*2,a[-1])
        print(cnt)
        exit()
    # print("test", tgt,a[search_tgt_index(tgt,i)])
    cnt += (n - search_tgt_index(tgt))