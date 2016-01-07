#!/usr/bin/env python
import psycopg2
import subprocess
import os
conn = psycopg2.connect("host=db dbname=postgres user=postgres")
conn.autocommit = True
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
with open("/root/e800_run.sh", "w") as script_file:
    script_file.write(script)
    script_file.write("\n")

with open("/root/code.txt", "w") as code_file:
    code_file.write(code)
    code_file.write("\n")

output = subprocess.check_output(["sh", "/root/e800_run.sh"], stderr=subprocess.STDOUT)
cur = conn.cursor()
cur.execute("""
    UPDATE submissions
    SET
        output = %(output)s,
        pending = false
    WHERE id = %(id)s;
""", {'output': output, 'id': id})
cur.close()
conn.close()
os.remove("/root/e800_run.sh")
os.remove("/root/code.txt")
