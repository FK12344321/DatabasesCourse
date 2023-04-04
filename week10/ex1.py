from pymongo import MongoClient


def printIrish(db):
    cursor = db.restaurants.find({'cuisine': 'Irish'})
    printCursor(cursor)


def printIrishAndRussian(db):
    cursor = db.restaurants.find({'cuisine': {'$in': ['Irish', 'Russian']}})
    printCursor(cursor)


def printWithAddress(db):
    cursor = db.restaurants.find({
        "address.building": "284", "address.street": "Prospect Park West", "address.zipcode": "11215"})
    printCursor(cursor)

def printCursor(cursor):
    for restaurant in cursor:
        print(restaurant)



client = MongoClient("mongodb://127.0.0.1:27017")
db = client['test']

printWithAddress(db)
