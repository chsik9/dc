# Ring Algorithm
 
p=[]
print("Enter Total no of nodes : ", end="")
n = int(input())
for i in range(1,n+1):
    p.append(i)

coordinator = max(p)
p.remove(coordinator)
 
print("Enter the Node which finds the coordiantor : ", end="")
find = int(input())

dead = list(int(i) for i in input("Enter dead nodes :\n").split())
for i in dead:
    if i == find:
        print("since the finder coordinator fails we can't find the coordinator")
        exit()
    else:
        p.remove(i)    

pos = p.index(find)
msg = [find]
print("\nP", p[pos], "passes",msg)
pos = (pos+1)%len(p)

 
while (p[pos] != msg[0]):
    msg.append(p[pos])
    print("\nP",p[pos], "passes", msg)
    pos = (pos+1)%len(p)
 
print(f"\nNew coordinator : P{max(msg)}")