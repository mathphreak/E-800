#!/usr/bin/env python
import psycopg2
conn = psycopg2.connect("host=db dbname=postgres user=postgres")
cur = conn.cursor()
cur.execute("""
    SELECT submissions.id, submissions.code, assignments.run_script
    FROM submissions
    LEFT JOIN assignments
        ON submissions.assignment_id = assignments.id
    WHERE submissions.pending;
""")
(id, code, script) = cur.fetchone()
cur.close()
conn.close()
