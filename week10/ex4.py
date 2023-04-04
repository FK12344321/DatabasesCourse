from pymongo import MongoClient


def updateGrades(db):
    cursor = db.restaurants.find({'address.street': 'Prospect Park West'})

    for restaurant in cursor:
        a_count = 0
        for grade in restaurant["grades"]:
            if grade["grade"] == 'A':
                a_count += 1
        if a_count > 1:
            print(db.restaurants.delete_one({
                'restaurant_id': restaurant['restaurant_id']}))
        else:
            print(db.restaurants.update_one(
               {'restaurant_id': restaurant['restaurant_id']},
                {'$push': {'grades': {
                    'grade': 'A'
                }}}))


client = MongoClient("mongodb://127.0.0.1:27017")
db = client['test']

updateGrades(db)
