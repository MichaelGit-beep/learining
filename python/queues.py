from threading import Thread, Lock, current_thread
from queue import Queue
import time
import os


def worker(q, lock):
    while True:
        value = q.get()
        # Processing
        time.sleep(1)
        with lock:
            print(f"in {current_thread().name} got {value}")
        q.task_done()

if __name__ == "__main__":

    q = Queue()
    lock = Lock()
    for i in range(os.cpu_count()):
        thread = Thread(target=worker, args=(q, lock))
        thread.daemon = True
        thread.start()

    for i in range(1, 21):
        q.put(i)

    q.join()
    print("end main")