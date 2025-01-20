import pymongo

myclient = pymongo.MongoClient(
    "mongodb://my-user:admin@localhost:27017/admin?replicaSet=example-mongodb&ssl=false"
)

mycol = myclient["newdb"]["customers"]
mydict = {"name": "John", "address": "Highway 37"}
print("Yes!" if mycol.insert_one(mydict).acknowledged else "No!")
