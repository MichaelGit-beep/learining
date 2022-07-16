import os 
# with open(os.path.join(os.path.dirname(__file__), "bin.txt"), mode="wb") as bin:
#     bin.write(bytearray(10000000000))

# print(os.path.getsize(os.path.join(os.path.dirname(__file__), "bin.txt")))

try:
    os.remove(os.path.join(os.path.dirname(__file__), "bin.txt"))
except FileNotFoundError as e:
    print(e.errno)