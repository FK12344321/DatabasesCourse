import psycopg2
from geopy.geocoders import Nominatim

conn = psycopg2.connect(
    host="localhost",
    database="dvdrental",
    user="user",
    password="pwd")

cur = conn.cursor()
cur.callproc('get_addresses', ())

rows = cur.fetchall()
geolocator = Nominatim(user_agent="my_app", timeout=10000)
for row in rows:
    address = row[0]
    location = geolocator.geocode(address)
    latitude = 0 if location is None else location.latitude
    longitude = 0 if location is None else location.longitude
    cur.execute("UPDATE address set longitude = %s , latitude = %s where address = %s; ",
                (longitude, latitude, address))
    print(f"{address} - ({latitude}, {longitude})")

conn.commit()
cur.close()
conn.close()