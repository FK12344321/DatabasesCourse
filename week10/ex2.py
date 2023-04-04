from pymongo import MongoClient
from datetime import datetime


def insertRestaurant(db):
    result = db.restaurants.insert_one({
                        'borough': 'Innopolis', 'cuisine': 'Serbian',
                        'name': 'The Best Restaurant', 'restaurant_id': '41712354',
                        'grades': [
                            {'grade': 'A',
                             'score': '11',
                             'date': datetime.strptime('04 Apr 2023', '%d %b %Y')
                             }
                        ],
                        'address': {
                            'building': '126',
                            'street': 'Sportivnaya',
                            'zipcode': '126',
                            'coord': [
                                -73.9557413,
                                40.7720266
                            ],
                        }})
    print(result)


client = MongoClient("mongodb://127.0.0.1:27017")
db = client['test']
insertRestaurant(db)
