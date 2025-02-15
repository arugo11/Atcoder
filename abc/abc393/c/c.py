n, m = map(int, input().split())
graph = set()
cnt = 0
for _ in range(m):
    a, b = map(int, input().split())
    if a == b:cnt += 1;continue
    if a < b:a,b = b, a
    if (a,b) in graph: cnt += 1;continue
    graph.add((a,b))

print(cnt)
