# this is actually probably best done in a jupyter notebook, or something else
# with a live readout

import psycopg2 as pg2

conn = pg2.connect(
    database='dvdrental',
    user='postgres',
    password='ranger',
    host='localhost'
)

cur = conn.cursor()

cur.execute('select * from payment')

print(cur.fetchone())
print(cur.fetchmany(10))

# careful with this one could get overwhelming if there are a lot of rows
# print(cur.fetchall())

# at the end, close the connetion
conn.close()

# don't be little bobby tables
