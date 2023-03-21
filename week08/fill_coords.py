import psycopg2
from geopy.geocoders import Nominatim

conn = psycopg2.connect(
    host="localhost",
    database="dvdrental",
    user="user",
    password="pwd")

cur = conn.cursor()
cur.callproc('get_addresses', ())

row = cur.fetchone()
address = row[0]
geolocator = Nominatim(user_agent="my_app", timeout=10000)
print(1)
while address is not None:
    location = geolocator.geocode(address)
    latitude = 0 if location.latitude is None else location.latitude
    longitude = 0 if location.longitude is None else location.longitude
    print(1)
    cur.execute("UPDATE address set longitude = %s , latitude = %s where address = %s; ",
                (longitude, latitude, address))
    print(f"{address} - ({latitude}, {longitude})")
    row = cur.fetchone()


cur.close()
conn.close()