from pymongo import MongoClient


def deleteBrooklynRestaurant(db):
    result = db.restaurants.delete_one({'borough': 'Brooklyn'})
    print(result)


def deleteAllThai(db):
    result = db.restaurants.delete_many({'cuisine': 'Thai'})
    print(result)


client = MongoClient("mongodb://127.0.0.1:27017")
db = client['test']

deleteAllThai(db)
