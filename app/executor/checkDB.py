#!/usr/bin/env python
import psycopg2
conn = psycopg2.connect("host=db dbname=postgres user=postgres")
cur = conn.cursor()
cur.execute("SELECT id, code FROM submissions WHERE pending;")
(id, code) = cur.fetchone()
cur.close()
conn.close()
