a,b = map(str,input().split(" "))

if (a == "sick" and b == "sick"):
    print(1)
elif(a == "sick" and b == "fine"):
    print(2)
elif(a == "fine" and b == "sick"):
    print(3)
else:
    print(4)