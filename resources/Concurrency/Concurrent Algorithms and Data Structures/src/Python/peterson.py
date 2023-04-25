import threading

turn = 0
flag = [False, False]
counter = 0
iterations = 30000

def critical_section(me):
    global turn
    global flag
    global counter
    other = 1 - me
    for i in range(iterations):
        flag[me] = True
        turn = other
        while flag[other] and turn == other:
            pass
        # Critical section
        counter += 1
        # End of critical section
        flag[me] = False

t1 = threading.Thread(target=critical_section, args=(0,))
t2 = threading.Thread(target=critical_section, args=(1,))
t1.start()
t2.start()
t1.join()
t2.join()
print("Counter value:", counter)