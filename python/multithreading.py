from threading import Thread, Lock
from queue import Queue
import time
import os


database_val = 0
def increase(lock):
    global database_val

    lock.acquire()
    local = database_val
    local += 1
    time.sleep(0.1) 
    database_val = local
    lock.release()
 
    # Acquire and Release lock with context manager
    with lock:
        local = database_val
        local += 1
        time.sleep(0.1) 
        database_val = local

if __name__ == "__main__":
    print("start value: ", database_val)

    threads = []
    lock = Lock()
    for i in range(os.cpu_count()):
        threads.append(Thread(target=increase, args=(lock,)))

    for thread in threads:
        thread.start()

    for thread in threads:
        thread.join()

    print("end value: ", database_val)