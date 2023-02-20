## Run mongodb nad mongosh with docker
```
docker network create mongo
docker run -d --name mongo  --network mongo mongo
docker run -d --name mongosh --network mongo rtsp/mongosh
```

## Open mongosh and connect to db
```
docker exec -it  mongosh mongosh mongodb://mongo:27017
```
## Work with DB
```
show dbs
use dbname
db.dropDatabase()
```

## Work with collections
```
show collections

db.users.insertOne({ name: "John", age: 30}) #Create collection users and insert one item
db.users.deleteOne({name: "John"}) # Delete one document with this arrt
db.users.find() # Find all documents
db.users.find({name: "John"}) # Find all match documents
db.users.drop() # Delete the whole collection

db.users.insertMany([{name: "Ine"}, {name: "two"}])
db.users.deleteMany({age:30} # Delete couple documents with this arrt
```


# Query 
```
db.users.find().limit(3)
db.users.find().sort({ name: -1}).limit(2)
db.users.find().skip(1).limit(2)

# find(attr, filter) 
db.users.find({name: "two"})
db.users.find({name: "two"}, { name: 1, age: 1, _id: 0})
db.users.find({}, {_id: 0})
```

# Complex query
```
db.users.find({ name: { $eq: "Ine" } })
db.users.find({ name: { $nq: "Ine" } })
db.users.find({ age: { $exists: true}})
db.users.find({ age: { $exists: true, $gt: 0} })
db.users.find({ $or: [ {age: {$gt: 0}}, {age: {$exists: true}} ] })
db.users.find({ age: { $not: {$exists: true } } })


db.users.insertMany([{name: "Michael", balance: 100, debt: 200}, {name: "Jris", balance: 20, debt: 0}])
db.users.find({ $expr: { $gt: ["$debt", "$balance"]}})

db.users.insertOne({ streets: {main:["lipov", "gaga"], secondary: "thanK" }})
db.users.find({ "streets.main" : { $exists: true }})

db.users.countDocuments() # Count all docs
```

# Update documents
```
db.users.updateOne({ age: {$exists: true}}, 
    {$set: { age: 100 }}
)


db.users.updateOne({_id: ObjectId("63ecd45017e38eb8821be9c4")}, 
    { $set: { newattr: "yes"}} 
)

db.users.updateOne({_id: ObjectId("63ece08317e38eb8821be9cb")}, 
    {$unset: {counter: ""}}
)

db.users.updateOne({ _id: ObjectId("63ecd8ac17e38eb8821be9c7")}, 
    { $inc: {age: 2} }
)

db.users.insertMany([{counter: 100}, {counter: 200}])
db.users.updateMany({counter: {$exists: true}}, { $inc: {counter: 2}})
```

# Deleting
```
db.users.deleteOne({ _id: { $exists: true } })
db.users.deleteMany({ _id: { $exists: true } })
```