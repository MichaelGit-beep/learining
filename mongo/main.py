import pymongo

myclient = pymongo.MongoClient(
    "mongodb://admin:admin@mongodb-aws-svc.mongodb.svc.cluster.local/admin?replicaSet=mongodb-aws&ssl=false"
)

mycol = myclient["newdb"]["customers"]
mydict = {"name": "John", "address": "Highway 37"}
print("Yes!" if mycol.insert_one(mydict).acknowledged else "No!")
