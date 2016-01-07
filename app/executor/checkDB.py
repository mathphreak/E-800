#!/usr/bin/env python
import psycopg2
from subprocess import call
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
with open("/root/e800_run.sh", "w") as script_file:
    script_file.write(script)
    script_file.write("\n")
with open("/root/code.txt", "w") as code_file:
    code_file.write(code)
    code_file.write("\n")
call(["sh", "/root/e800_run.sh"])
cur.close()
conn.close()
